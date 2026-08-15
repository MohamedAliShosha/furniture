import 'package:flutter/material.dart';
import 'package:furniture/core/widgets/custom_app_bar.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_texts.dart';
import '../widgets/change_password_view_body.dart';

class ChangePasswordView extends StatelessWidget {
  const ChangePasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: const CustomAppBar(
        title: AppTexts.changePasswordTitle,
      ),
      body: SafeArea(
        child: ChangePasswordViewBody(),
      ),
    );
  }
}
