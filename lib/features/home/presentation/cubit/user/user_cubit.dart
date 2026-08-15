import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/models/user_model.dart';
import '../../../services/user_service.dart';
import 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final UserService userService;

  UserCubit(this.userService) : super(UserInitial());

  /// Initialize user state - check if user is logged in
  Future<void> initializeUser() async {
    emit(UserLoading());
    try {
      final user = userService.user;
      final isLoggedIn = userService.isUserLoggedIn || user != null;
      emit(UserSuccess(
        user: user,
        isLoggedIn: isLoggedIn,
        isGuest: userService.isGuest,
      ));
    } catch (e) {
      emit(
        UserFailure(
          e.toString(),
        ),
      );
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
    try {
      final success = userService.changePassword(
        currentPassword: currentPassword,
        newPassword: newPassword,
      );

      if (!success) {
        emit(const UserFailure(
            'Unable to change password. Please check your current password and try again.'));
        return;
      }

      emit(UserSuccess(
        user: userService.user,
        isLoggedIn: userService.isUserLoggedIn,
        isGuest: userService.isGuest,
      ));
    } catch (e) {
      emit(UserFailure(e.toString()));
    }
  }

  /// Clear user data on logout
  Future<void> logout() async {
    try {
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
}
