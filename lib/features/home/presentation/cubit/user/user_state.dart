import '../../../data/models/user_model.dart';

abstract class UserState {
  const UserState();
}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserSuccess extends UserState {
  final UserModel? user;
  final bool isLoggedIn;
  final bool isGuest;

  const UserSuccess({
    this.user,
    required this.isLoggedIn,
    this.isGuest = false,
  });
}

class UserFailure extends UserState {
  final String message;

  const UserFailure(this.message);
}
