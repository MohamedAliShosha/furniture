import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/constants.dart';
import '../../../home/presentation/cubit/user/user_cubit.dart';
import '../../../home/presentation/cubit/user/user_state.dart';
import 'change_password_form.dart';

class ChangePasswordViewBody extends StatelessWidget {
  ChangePasswordViewBody({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        if (state is UserFailure) {
          final errorMessage = state.message;
          WidgetsBinding.instance.addPostFrameCallback(
            (_) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: AppColors.red,
                  content: Text(errorMessage),
                ),
              );
            },
          );
        }
        return SingleChildScrollView(
          padding: const EdgeInsets.all(
            AppConstants.defaultPadding,
          ),
          child: ChangePasswordForm(
            formKey: _formKey,
          ),
        );
      },
    );
  }
}
