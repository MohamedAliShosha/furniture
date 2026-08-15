import '../data/models/user_model.dart';

class UserService {
  static bool _isLoggedIn = false;
  static bool _isGuest = false;

  UserModel? _user;
  String? _password;

  /// The currently stored user, or null when no user profile is available.
  UserModel? get user => _user;

  /// The current saved password used for authentication checks.
  String? get password => _password;

  /// A global login flag to match the existing shared login-state approach.
  bool get isUserLoggedIn => _isLoggedIn;

  /// A guest flag for anonymous users who chose to continue without signing in.
  bool get isGuest => _isGuest;

  /// Sets the current user and marks the service as logged in.
  void setUser(UserModel user) {
    _user = user;
    _isLoggedIn = true;
    _isGuest = false;
  }

  /// Stores the account password for validation checks during change-password flows.
  void setPassword(String newPassword) {
    _password = newPassword;
  }

  void updateUser({
    String? name,
    String? email,
    String? phone,
    String? profileImage,
  }) {
    if (_user == null) {
      return;
    }

    _user = _user!.copyWith(
      name: name,
      email: email,
      phoneNumber: phone,
      profileImage: profileImage,
    );
  }

  /// Validates the current password and updates it when the new value is valid.
  bool changePassword({
    required String currentPassword,
    required String newPassword,
  }) {
    if (_user == null || !_isLoggedIn) {
      return false;
    }

    if (_password == null ||
        _password!.toLowerCase() != currentPassword.toLowerCase()) {
      return false;
    }

    if (newPassword.length < 6) {
      return false;
    }

    if (newPassword.toLowerCase() == currentPassword.toLowerCase()) {
      return false;
    }

    // Make the new password is now the one used for future validation
    _password = newPassword;
    return true;
  }

  void clearUser() {
    _user = null;
    _password = null;
    _isLoggedIn = false;
    _isGuest = false;
  }

  /// Marks the user as a guest and preserves anonymous access.
  void continueAsGuest() {
    _user = null;
    _password = null;
    _isLoggedIn = false;
    _isGuest = true;
  }
}
