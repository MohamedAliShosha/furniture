import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furniture/features/auth/login/presentation/cubit/sign_in_cubit.dart';
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
import 'dont_have_account.dart';
import 'guest_button.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
    super.key,
    required GlobalKey<FormState> formKey,
    required this.emailController,
    required this.passwordController,
  }) : _formKey = formKey;

  final GlobalKey<FormState> _formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget._formKey,
      autovalidateMode: autoValidateMode,
      child: Column(
        children: [
          AuthTextField(
            controller: widget.emailController,
            label: AppTexts.emailLabel,
            hintText: AppTexts.emailHint,
            keyboardType: TextInputType.emailAddress,
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
            controller: widget.passwordController,
            label: AppTexts.passwordLabel,
            hintText: AppTexts.loginPasswordHint,
            isPassword: true,
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
          const Gap(12),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {
                // navigate to forgot password screen
                GoRouter.of(context).push(AppRouter.kForgetPasswordView);
              },
              child: Text(
                AppTexts.forgotPassword,
                style: TextStyle(
                  color: Colors.grey[700],
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          const Gap(12),
          BlocConsumer<SignInCubit, SignInState>(
            listener: (context, state) {
              if (state is SignInSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    backgroundColor: AppColors.primary,
                    content: Center(
                      child: Text(
                        'Sign In Successfully',
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
              if (state is SignInFailure) {
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
                isLoading: state is SignInLoading,
                title: AppTexts.loginButtonTitle,
                onPressed: () {
                  if (widget._formKey.currentState!.validate()) {
                    context.read<SignInCubit>().signInWithEmailAndPassword(
                          email: widget.emailController.text,
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
          Row(
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
              // const Gap(16),
              // Expanded(
              //   child: SocialAuthButton(
              //     title: AppTexts.facebookButtonTitle,
              //     icon: AppIcons.facebookIcon,
              //     onPressed: () {},
              //   ),
              // ),
            ],
          ),
          const Gap(24),
          const DontHaveAccount()
        ],
      ),
    );
  }
}
