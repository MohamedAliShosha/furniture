import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../../core/utils/constants.dart';
import '../../../../../utils/app_texts.dart';
import '../../../auth_shared_widgets/auth_button.dart';
import '../../../auth_shared_widgets/auth_text_field.dart';

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
    return Form(
      key: formKey,
      child: Column(
        children: [
          AuthTextField(
            hintText: 'Enter your email',
            label: 'Email',
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
            title: 'Reset Password',
            onPressed: () {},
          ),
          const Gap(24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Remember your password ? ',
                style: AppConstants.bodyStyle.copyWith(
                  color: Colors.grey.shade600,
                  // fontSize: 16,
                ),
              ),
              const Gap(4),
            ],
          ),
        ],
      ),
    );
  }
}
