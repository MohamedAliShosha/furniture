import 'package:furniture/features/home/data/models/user_model.dart';

// bool isLoggedInUser = true;

class UserService {
  static bool _isLoggedIn = false;
  static bool _isGuest = false;

  UserModel? _user;

  /// The currently stored user, or null when no user profile is available.
  UserModel? get user => _user;

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

  void clearUser() {
    _user = null;
    _isLoggedIn = false;
    _isGuest = false;
  }

  /// Marks the user as a guest and preserves anonymous access.
  void continueAsGuest() {
    _user = null;
    _isLoggedIn = false;
    _isGuest = true;
  }
}
