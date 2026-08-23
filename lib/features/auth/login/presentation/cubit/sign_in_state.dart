part of 'sign_in_cubit.dart';

sealed class SignInState extends Equatable {
  const SignInState();

  @override
  List<Object> get props => [];
}

final class SignInInitial extends SignInState {}

final class SignInLoading extends SignInState {}

final class SignInSuccess extends SignInState {
  final UserEntity user;
  const SignInSuccess({required this.user});
}

final class SignInFailure extends SignInState {
  final String errorMessage;
  const SignInFailure({required this.errorMessage});
}
