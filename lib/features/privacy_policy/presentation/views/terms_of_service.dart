import 'package:flutter/material.dart';
import 'package:furniture/core/utils/app_colors.dart';
import 'package:furniture/core/utils/app_texts.dart';
import 'package:furniture/core/widgets/custom_app_bar.dart';
import '../widgets/terms_of_service_view_body.dart';

class TermsOfServiceView extends StatelessWidget {
  const TermsOfServiceView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.white,
      appBar: CustomAppBar(
        title: AppTexts.termsOfService,
      ),
      body: SafeArea(
        child: TermsOfServiceViewBody(),
      ),
    );
  }
}
