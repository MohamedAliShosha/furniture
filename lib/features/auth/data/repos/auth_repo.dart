import 'package:dartz/dartz.dart';
import 'package:furniture/features/auth/data/domain/entities/user_entity.dart';
import '../../../../core/errors/failure.dart';

abstract class AuthRepo {
  // The AuthRepo contains all methods of the authentication feature process
  Future<Either<Failure, UserEntity>> createUserWithEmailAndPassword(
      {required String email, required String password, required String name});

  Future<Either<Failure, UserEntity>> signInWithEmailAndPassword(
      {required String email, required String password});

  Future<Either<Failure, UserEntity>> signInWithGoogle();

  Future addUserData({required UserEntity user});
  Future saveUserData({required UserEntity user});
  Future<UserEntity> getUserData({required String userId});
}
