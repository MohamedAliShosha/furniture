import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/utils/app_icons.dart';
import '../../../../../core/utils/app_router.dart';
import '../../../../../core/utils/app_texts.dart';
import '../../../auth_shared_widgets/auth_button.dart';
import '../../../auth_shared_widgets/auth_divider.dart';
import '../../../auth_shared_widgets/auth_text_field.dart';
import '../../../auth_shared_widgets/social_auth_button.dart';
import 'already_have_account.dart';

class SignUpForm extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          AuthTextField(
            controller: nameController,
            label: AppTexts.fullNameLabel,
            hintText: AppTexts.fullNameHint,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return AppTexts.confirmPasswordRequired;
              }
              return null;
            },
          ),
          const Gap(20),
          AuthTextField(
            keyboardType: TextInputType.emailAddress,
            controller: emailController,
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
            controller: passwordController,
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
            controller: confirmPasswordController,
            label: AppTexts.confirmPasswordLabel,
            hintText: AppTexts.confirmPasswordHint,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return AppTexts.passwordRequired;
              }
              if (value != passwordController.text) {
                return AppTexts.passwordsDoNotMatch;
              }
              return null;
            },
          ),
          const Gap(32),
          AuthButton(
            title: AppTexts.signUpButtonTitle,
            onPressed: () {
              GoRouter.of(context).pushReplacement(AppRouter.kMainView);
            },
          ),
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
                  onPressed: () {},
                ),
              ),
              const Gap(16),
              Expanded(
                child: SocialAuthButton(
                  title: AppTexts.facebookButtonTitle,
                  icon: AppIcons.facebookIcon,
                  onPressed: () {},
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
