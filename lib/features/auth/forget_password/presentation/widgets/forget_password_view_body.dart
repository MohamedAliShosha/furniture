import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../../core/utils/constants.dart';
import 'forget_password_form.dart';

class ForgetPasswordViewBody extends StatefulWidget {
  const ForgetPasswordViewBody({
    super.key,
  });

  @override
  State<ForgetPasswordViewBody> createState() => _ForgetPasswordViewBodyState();
}

class _ForgetPasswordViewBodyState extends State<ForgetPasswordViewBody> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();

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
