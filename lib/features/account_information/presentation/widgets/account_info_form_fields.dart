import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../core/utils/app_texts.dart';
import '../../../auth/auth_shared_widgets/auth_text_field.dart';

class AccountInfoFormFields extends StatelessWidget {
  const AccountInfoFormFields({
    super.key,
    required this.nameController,
    required this.emailController,
    required this.phoneController,
    required this.isEditing,
  });

  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final bool isEditing;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AuthTextField(
          hintText: AppTexts.fullNameHint,
          label: AppTexts.fullNameLabel,
          controller: nameController,
          enabled: isEditing,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return AppTexts.nameRequired;
            }
            return null;
          },
        ),
        const Gap(20),
        AuthTextField(
          hintText: AppTexts.emailHint,
          label: AppTexts.emailLabel,
          controller: emailController,
          enabled: isEditing,
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
          hintText: AppTexts.accountInfoPhoneHint,
          label: AppTexts.accountInfoPhoneLabel,
          controller: phoneController,
          keyboardType: TextInputType.phone,
          enabled: isEditing,
        ),
      ],
    );
  }
}
