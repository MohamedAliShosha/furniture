import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/utils/constants.dart';
import '../../../../../core/utils/shared_pref_service.dart';
import '../../../../auth/data/repos/auth_repo.dart';
import '../../../../auth/services/firebase_auth_service.dart';
import '../../../data/models/user_model.dart';
import '../../../services/user_service.dart';
import 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final UserService userService;
  final AuthRepo authRepo;
  final FirebaseAuthService firebaseAuthService;

  UserCubit(
    this.userService,
    this.authRepo,
    this.firebaseAuthService,
  ) : super(UserInitial());

  /// Initialize user state - check if user is logged in
  Future<bool> initializeUser() async {
    emit(UserLoading());
    try {
      final firebaseUser = firebaseAuthService.getCurrentUser();
      UserModel? user = userService.user;

      if (firebaseUser != null) {
        final userEntity = await authRepo.getUserData(userId: firebaseUser.uid);
        user = UserModel.fromEntity(userEntity);
        userService.setUser(user);
      }

      final isLoggedIn = userService.isUserLoggedIn || user != null;
      emit(UserSuccess(
        user: user,
        isLoggedIn: isLoggedIn,
        isGuest: userService.isGuest,
      ));
      return isLoggedIn;
    } catch (e) {
      emit(
        UserFailure(
          e.toString(),
        ),
      );
      return false;
    }
  }

  /// Set user after login/registration
  Future<void> setUser(UserModel user) async {
    try {
      userService.setUser(user);
      emit(UserSuccess(
        user: user,
        isLoggedIn: true,
        isGuest: false,
      ));
    } catch (e) {
      emit(UserFailure(e.toString()));
    }
  }

  /// Save the account password used for validation checks.
  Future<void> setPassword(String password) async {
    try {
      userService.setPassword(password);
      emit(UserSuccess(
        user: userService.user,
        isLoggedIn: userService.isUserLoggedIn,
        isGuest: userService.isGuest,
      ));
    } catch (e) {
      emit(UserFailure(e.toString()));
    }
  }

  /// Update user profile information
  Future<void> updateUser({
    String? name,
    String? email,
    String? phone,
    String? profileImage,
  }) async {
    try {
      userService.updateUser(
        name: name,
        email: email,
        phone: phone,
        profileImage: profileImage,
      );
      final updatedUser = userService.user;
      emit(UserSuccess(
        user: updatedUser,
        isLoggedIn: updatedUser != null,
      ));
    } catch (e) {
      emit(UserFailure(e.toString()));
    }
  }

  /// Change the current user's password after validating the existing password.
  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    emit(UserLoading());
    final result = await authRepo.changePassword(
      currentPassword: currentPassword,
      newPassword: newPassword,
    );
    result.fold(
      (failure) => emit(UserFailure(failure.errorMessage)),
      (_) => emit(UserSuccess(
        user: userService.user,
        isLoggedIn: userService.isUserLoggedIn,
        isGuest: userService.isGuest,
      )),
    );
  }

  /// Clear user data on logout
  Future<void> logout() async {
    try {
      await firebaseAuthService.signOut();
      await Prefs.remove(AppConstants.kUserData);
      userService.clearUser();
      emit(const UserSuccess(
        user: null,
        isLoggedIn: false,
        isGuest: false,
      ));
    } catch (e) {
      emit(
        UserFailure(
          e.toString(),
        ),
      );
    }
  }

  Future<void> continueAsGuest() async {
    try {
      await firebaseAuthService.signOut();
      await Prefs.remove(AppConstants.kUserData);
      userService.continueAsGuest();
      emit(const UserSuccess(
        user: null,
        isLoggedIn: false,
        isGuest: true,
      ));
    } catch (e) {
      emit(UserFailure(e.toString()));
    }
  }

  /// Get current user
  UserModel? getCurrentUser() {
    return userService.user;
  }

  /// Check if user is logged in
  bool isUserLoggedIn() {
    return userService.isUserLoggedIn;
  }

  Future<void> refreshUser() async {
    try {
      emit(UserLoading());
      final firebaseUser = firebaseAuthService.getCurrentUser();

      if (firebaseUser != null) {
        final userEntity = await authRepo.getUserData(userId: firebaseUser.uid);
        final user = UserModel.fromEntity(userEntity);
        userService.setUser(user);
        emit(UserSuccess(
          user: user,
          isLoggedIn: true,
          isGuest: false,
        ));
      } else {
        emit(const UserSuccess(
          user: null,
          isLoggedIn: false,
          isGuest: false,
        ));
      }
    } catch (e) {
      emit(UserFailure(e.toString()));
    }
  }
}
