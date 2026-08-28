import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_icons.dart';
import '../../../../../core/utils/app_router.dart';
import '../../../../../core/utils/app_texts.dart';
import '../../../auth_shared_widgets/auth_button.dart';
import '../../../auth_shared_widgets/auth_divider.dart';
import '../../../auth_shared_widgets/auth_text_field.dart';
import '../../../auth_shared_widgets/social_auth_button.dart';
import '../../../login/presentation/cubit/sign_in_cubit.dart';
import '../../../login/presentation/widgets/guest_button.dart';
import '../cubit/sign_up_cubit.dart';
import 'already_have_account.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({
    super.key,
    required GlobalKey<FormState> formKey,
    required this.nameController,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
  }) : _formKey = formKey;

  final GlobalKey<FormState> _formKey;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget._formKey,
      autovalidateMode: autoValidateMode,
      child: Column(
        children: [
          AuthTextField(
            controller: widget.nameController,
            label: AppTexts.fullNameLabel,
            hintText: AppTexts.fullNameHint,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return AppTexts.nameRequired;
              }
              return null;
            },
          ),
          const Gap(20),
          AuthTextField(
            keyboardType: TextInputType.emailAddress,
            controller: widget.emailController,
            label: AppTexts.emailLabel,
            hintText: AppTexts.emailHint,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return AppTexts.emailRequired;
              }
              if (!value.contains('@')) {
                return AppTexts.invalidEmail;
              }
              return null;
            },
          ),
          const Gap(20),
          AuthTextField(
            keyboardType: TextInputType.visiblePassword,
            controller: widget.passwordController,
            label: AppTexts.passwordLabel,
            isPassword: true,
            hintText: AppTexts.passwordHint,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return AppTexts.passwordRequired;
              }
              if (value.length < 6) {
                return AppTexts.passwordMinLength;
              }
              return null;
            },
          ),
          const Gap(20),
          AuthTextField(
            keyboardType: TextInputType.visiblePassword,
            controller: widget.confirmPasswordController,
            label: AppTexts.confirmPasswordLabel,
            hintText: AppTexts.confirmPasswordHint,
            isPassword: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return AppTexts.passwordRequired;
              }
              if (value != widget.passwordController.text) {
                return AppTexts.passwordsDoNotMatch;
              }
              return null;
            },
          ),
          const Gap(32),
          BlocConsumer<SignUpCubit, SignUpState>(
            listener: (context, state) {
              if (state is SignUpSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    backgroundColor: AppColors.primary,
                    content: Center(
                      child: Text(
                        AppTexts.signUpSuccessfully,
                        style: TextStyle(
                          color: AppColors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                );
                GoRouter.of(context).pushReplacement(AppRouter.kMainView);
              }
              if (state is SignUpFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: AppColors.red,
                    content: Center(
                      child: Text(
                        state.errorMessage,
                        style: const TextStyle(
                          color: AppColors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                );
              }
            },
            builder: (context, state) {
              return AuthButton(
                isLoading: state is SignUpLoading,
                title: AppTexts.signUpButtonTitle,
                onPressed: () {
                  if (widget._formKey.currentState?.validate() ?? false) {
                    context.read<SignUpCubit>().createUserWithEmailAndPassword(
                          name: widget.nameController.text.trim(),
                          email: widget.emailController.text.trim(),
                          password: widget.passwordController.text,
                        );
                  } else {
                    setState(() => autoValidateMode = AutovalidateMode.always);
                  }
                },
              );
            },
          ),
          const Gap(16),
          const GuestButton(),
          const Gap(24),
          const AuthDivider(),
          const Gap(24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: SocialAuthButton(
                  title: AppTexts.googleButtonTitle,
                  icon: AppIcons.googleIcon,
                  onPressed: () {
                    context.read<SignInCubit>().signInWithGoogle();
                  },
                ),
              ),
            ],
          ),
          const Gap(12),
          const AlreadyHaveAccount(),
        ],
      ),
    );
  }
}
