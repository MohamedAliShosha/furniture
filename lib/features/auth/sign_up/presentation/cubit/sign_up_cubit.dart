import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/domain/entities/user_entity.dart';
import '../../../data/repos/auth_repo.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit(this.authRepo) : super(SignUpInitial());

  final AuthRepo authRepo;

  Future<void> createUserWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
  }) async {
    emit(SignUpLoading());
    final result = await authRepo.createUserWithEmailAndPassword(
      email: email,
      password: password,
      name: name,
    );
    result.fold(
      (failure) => emit(SignUpFailure(errorMessage: failure.errorMessage)),
      (user) => emit(SignUpSuccess(user: user)),
    );
  }
}
