import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/utils/constants.dart';
import '../../../../../core/utils/app_texts.dart';
import '../../../auth_shared_widgets/auth_button.dart';
import '../../../auth_shared_widgets/auth_text_field.dart';
import '../../presentation/cubit/forget_password_cubit.dart';

class ForgetPasswordForm extends StatelessWidget {
  const ForgetPasswordForm({
    super.key,
    required this.formKey,
    required this.emailController,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ForgetPasswordCubit, ForgetPasswordState>(
      listener: (context, state) {
        if (state is ForgetPasswordSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: Colors.green,
              content: Text(AppTexts.resetPasswordSuccess),
            ),
          );
          GoRouter.of(context).pop();
        } else if (state is ForgetPasswordFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.red,
              content: Text(state.errorMessage),
            ),
          );
        }
      },
      builder: (context, state) {
        final isLoading = state is ForgetPasswordLoading;
        return Form(
          key: formKey,
          child: Column(
            children: [
              AuthTextField(
                hintText: AppTexts.emailHint,
                label: AppTexts.emailLabel,
                keyboardType: TextInputType.emailAddress,
                controller: emailController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return AppTexts.emailRequired;
                  } else if (!value.contains('@')) {
                    return AppTexts.invalidEmail;
                  }
                  return null;
                },
              ),
              const Gap(20),
              AuthButton(
                title: AppTexts.resetPasswordButtonTitle,
                isLoading: isLoading,
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    context
                        .read<ForgetPasswordCubit>()
                        .forgotPassword(email: emailController.text.trim());
                  }
                },
              ),
              const Gap(24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppTexts.rememberYourPassword,
                    style: AppConstants.bodyStyle.copyWith(
                      color: Colors.grey.shade600,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      GoRouter.of(context).pop();
                    },
                    child: const Text(
                      AppTexts.signIn,
                      style: TextStyle(
                        color: AppConstants.primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
