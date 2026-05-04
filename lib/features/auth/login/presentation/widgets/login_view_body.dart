import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../../core/utils/app_icons.dart';
import '../../../../../core/utils/constants.dart';
import 'auth_divider.dart';
import 'login_form.dart';
import 'social_auth_button.dart';

class LoginViewBody extends StatelessWidget {
  const LoginViewBody({
    super.key,
    required GlobalKey<FormState> formKey,
    required this.emailController,
    required this.passwordController,
  }) : _formKey = formKey;

  final GlobalKey<FormState> _formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(40),
              Text(
                'Welcome Back',
                style: AppConstants.headingStyle.copyWith(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Gap(
                8,
              ),
              Text(
                'Sign in to continue shopping',
                style: AppConstants.bodyStyle.copyWith(
                  color: Colors.grey.shade600,
                  fontSize: 16,
                ),
              ),
              const Gap(32),
              LoginForm(
                  formKey: _formKey,
                  emailController: emailController,
                  passwordController: passwordController),
              const Gap(24),
              const AuthDivider(),
              Row(
                children: [
                  Expanded(
                    child: SocialAuthButton(
                      title: 'Google',
                      icon: AppIcons.googleIcon,
                      onPressed: () {},
                    ),
                  ),
                  const Gap(16),
                  Expanded(
                    child: SocialAuthButton(
                      title: 'Facebook',
                      icon: AppIcons.facebookIcon,
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
              const Gap(24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account ? ",
                    style: AppConstants.bodyStyle.copyWith(
                      color: Colors.grey.shade600,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      // navigate to sign up screen
                    },
                    child: const Text('Sign Up',
                        style: TextStyle(
                          color: AppConstants.primaryColor,
                          fontWeight: FontWeight.w600,
                        )),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
