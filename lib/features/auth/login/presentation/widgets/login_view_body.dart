import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../../../core/utils/app_icons.dart';
import '../../../auth_shared_widgets/auth_header.dart';
import '../../../auth_shared_widgets/auth_divider.dart';
import 'dont_have_account.dart';
import 'login_form.dart';
import '../../../auth_shared_widgets/social_auth_button.dart';

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
              const AuthHeader(
                title: 'Welcome Back',
                subtitle: 'Sign in to continue shopping',
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
              const DontHaveAccount()
            ],
          ),
        ),
      ),
    );
  }
}
