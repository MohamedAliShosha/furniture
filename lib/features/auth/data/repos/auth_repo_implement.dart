import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:furniture/core/errors/failure.dart';
import 'package:furniture/core/utils/constants.dart';
import 'package:furniture/features/auth/data/domain/entities/user_entity.dart';
import 'package:furniture/features/auth/data/repos/auth_repo.dart';

import '../../../../core/errors/custom_exception.dart';
import '../../../../core/utils/backend_endpoints.dart';
import '../../../../core/utils/shared_pref_service.dart';
import '../../../home/data/models/user_model.dart';
import '../../services/firebase_auth_service.dart';
import '../../services/database_service.dart';

class AuthRepoImplement implements AuthRepo {
  final FirebaseAuthService firebaseAuthService;
  final DatabaseService databaseService;

  AuthRepoImplement(
    this.firebaseAuthService,
    this.databaseService,
  );

  @override
  Future<Either<Failure, UserEntity>> createUserWithEmailAndPassword(
      {required String email,
      required String password,
      required String name}) async {
    User? user; // creating a variable of type User
    try {
      user = await firebaseAuthService.createUserWithEmailAndPassword(
          email: email, password: password);

      // creating a user entity and adding it to the database
      // I had used a UserEntity object to be able to get the value of the name that the user inputs and store it.
      var userEntity = UserEntity(
        name: name,
        email: email,
        uId: user.uid,
      );
      // adding user data to DB after creating an account successfully
      await addUserData(user: userEntity);
      return right(userEntity);
    } on CustomException catch (e) {
      // Check if the user has created account successfully but there is an exception when adding his data to firestore
      // then delete the user account from firebase auth
      await deleteUser(user);
      return left(
        ServerFailure(e.message),
      );
    } catch (e) {
      await deleteUser(user);
      // this line to log errors and display them at debug console => It's better to add log inside the "General catch bloc" not inside the "CustomException catch bloc", because the "Custom Exception made by me so the message inside it will be meaningful"
      log('Exception in AuthRepoImplement. createUserWithEmailAndPassword: ${e.toString()}');

      return left(
        ServerFailure('Something went wrong. Please try again later.'),
      );
    }
  }

  Future<void> deleteUser(User? user) async {
    if (user != null) {
      await firebaseAuthService.deleteUser();
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final user = await firebaseAuthService.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final userEntity = await getUserData(userId: user.uid);

      // Saving user data after successfully logging in
      await saveUserData(user: userEntity);

      return right(userEntity);
    } on CustomException catch (e) {
      log(
        'Exception in AuthRepoImplement.signInWithEmailAndPassword: ${e.message}',
      );

      return left(
        ServerFailure(e.message),
      );
    } catch (e) {
      log(
        'Exception in AuthRepoImplement.signInWithEmailAndPassword: ${e.toString()}',
      );

      return left(
        ServerFailure('Something went wrong. Please try again later.'),
      );
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signInWithGoogle() async {
    User? user;

    try {
      // The auth with google provides me the all data of the user even his name so, I don't need to create a userEntity object then getting user data through it
      user = await firebaseAuthService.signInWithGoogle();
      if (user == null) {
        return left(ServerFailure(''));
      }
      final userModel = UserModel.fromFirebaseUser(user);
      final userEntity = UserEntity(
        name: userModel.name ?? '',
        email: userModel.email ?? '',
        uId: userModel.id ?? '',
      );
      var isUserExists = await databaseService.checkIfDataExists(
          path: BackendEndpoints.isUserExists, documentId: user.uid);
      if (isUserExists) {
        await getUserData(userId: user.uid);
      } else {
        await addUserData(
          user: UserEntity(
            name: userEntity.name,
            email: userEntity.email,
            uId: userEntity.uId,
          ),
        );
      }
      return Right(userEntity);
    } catch (e) {
      await deleteUser(user);
      log('Exception in AuthRepoImplement. signInWithGoogle: ${e.toString()}');
      return left(
        ServerFailure('Something went wrong. Please try again later.'),
      );
    }
  }

  @override
  Future<Either<Failure, void>> forgotPassword({required String email}) async {
    try {
      await firebaseAuthService.sendPasswordResetEmail(email: email);
      return right(null);
    } on CustomException catch (e) {
      return left(ServerFailure(e.message));
    } catch (e) {
      log('Exception in AuthRepoImplement.forgotPassword: ${e.toString()}');
      return left(
        ServerFailure('Something went wrong. Please try again later.'),
      );
    }
  }

  @override
  Future<Either<Failure, void>> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      await firebaseAuthService.updatePassword(
        currentPassword: currentPassword,
        newPassword: newPassword,
      );
      return right(null);
    } on CustomException catch (e) {
      return left(ServerFailure(e.message));
    } catch (e) {
      log('Exception in AuthRepoImplement.changePassword: ${e.toString()}');
      return left(
        ServerFailure('Something went wrong. Please try again later.'),
      );
    }
  }

  @override
  Future addUserData({required UserEntity user}) async {
    await databaseService.addData(
      path: BackendEndpoints.isUserExists,
      data: UserModel.fromEntity(user).toJson(),
      documentId: user.uId,
    );
  }

  @override
  Future<UserEntity> getUserData({required String userId}) async {
    var userData = await databaseService.getData(
        path: BackendEndpoints.isUserExists, documentId: userId);
    final userModel = UserModel.fromJson(userData);
    return UserEntity(
      name: userModel.name ?? '',
      email: userModel.email ?? '',
      uId: userModel.id ?? '',
    );
  }

  @override
  Future saveUserData({required UserEntity user}) async {
    // jsonEncode is used to convert a dart object to String that can be stored inside DB using key & value
    var jsonData = jsonEncode(UserModel.fromEntity(user).toJson());
    await Prefs.setString(AppConstants.kUserData, jsonData);
  }
}
