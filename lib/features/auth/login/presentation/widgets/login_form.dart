import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/utils/app_icons.dart';
import '../../../../../core/utils/app_router.dart';
import '../../../auth_shared_widgets/auth_button.dart';
import '../../../auth_shared_widgets/auth_divider.dart';
import '../../../auth_shared_widgets/auth_text_field.dart';
import '../../../auth_shared_widgets/social_auth_button.dart';
import 'dont_have_account.dart';

class LoginForm extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          AuthTextField(
            controller: emailController,
            label: 'Email',
            hintText: 'Enter your email',
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              }
              if (!value.contains('@')) {
                return 'Please enter a valid email';
              }
              return null;
            },
          ),
          const Gap(20),
          AuthTextField(
            controller: passwordController,
            label: 'Password',
            hintText: 'Enter your password',
            isPassword: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your password';
              }
              if (value.length < 6) {
                return 'Password must be at least 6 characters';
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
              child: Text('Forgot Password ?',
                  style: TextStyle(
                      color: Colors.grey[700], fontWeight: FontWeight.w500)),
            ),
          ),
          const Gap(12),
          AuthButton(
            title: 'Login',
            onPressed: () {},
          ),
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
          const DontHaveAccount()
        ],
      ),
    );
  }
}
