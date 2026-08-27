import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/repos/auth_repo.dart';

part 'forget_password_state.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  ForgetPasswordCubit(this.authRepo) : super(ForgetPasswordInitial());

  final AuthRepo authRepo;

  Future<void> forgotPassword({required String email}) async {
    emit(ForgetPasswordLoading());
    final result = await authRepo.forgotPassword(email: email);
    result.fold(
      (failure) => emit(
        ForgetPasswordFailure(errorMessage: failure.errorMessage),
      ),
      (_) => emit(ForgetPasswordSuccess()),
    );
  }
}
