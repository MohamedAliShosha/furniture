import 'package:furniture/features/home/data/models/user_model.dart';

class UserService {
  UserModel? _user; // instance of the user model

  // This getter It allows other classes/widgets to read _user safely using: user instead of the priv instance _user
  UserModel? get user => _user;

  void setUser(UserModel user) {
    _user = user;
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
    _user = user!.copyWith(
        name: name,
        email: email,
        phoneNumber: phone,
        profileImage: profileImage);
  }

  void clearUser() {
    _user = null;
  }
}
