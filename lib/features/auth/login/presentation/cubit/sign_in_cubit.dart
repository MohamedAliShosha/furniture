import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/domain/entities/user_entity.dart';
import '../../../data/repos/auth_repo.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit(this.authRepo) : super(SignInInitial());

  final AuthRepo authRepo;

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    emit(SignInLoading());
    var result = await authRepo.signInWithEmailAndPassword(
        email: email, password: password);
    result.fold(
      (failure) => emit(
        SignInFailure(
          errorMessage: failure.errorMessage,
        ),
      ),
      (user) => emit(
        SignInSuccess(user: user),
      ),
    );
  }

  Future<void> signInWithGoogle() async {
    emit(SignInLoading());
    var result = await authRepo.signInWithGoogle();
    result.fold(
      (failure) {
        // will be empty when the user cancel the google sign in
        if (failure.errorMessage.isEmpty) {
          emit(SignInInitial());
        } else {
          emit(SignInFailure(errorMessage: failure.errorMessage));
        }
      },
      (userEntity) => emit(SignInSuccess(user: userEntity)),
    );
  }
}
