import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../../core/utils/constants.dart';
import 'forget_password_form.dart';

class ForgetPasswordViewBody extends StatelessWidget {
  const ForgetPasswordViewBody({
    super.key,
    required this.formKey,
    required this.emailController,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Forget Password ?',
                style: AppConstants.headingStyle.copyWith(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Gap(8),
              Text(
                'Enter you email to reset your password',
                style: AppConstants.bodyStyle.copyWith(
                  color: Colors.grey.shade600,
                  fontSize: 16,
                ),
              ),
              const Gap(40),
              ForgetPasswordForm(
                formKey: formKey,
                emailController: emailController,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
