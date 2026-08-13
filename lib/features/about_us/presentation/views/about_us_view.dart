import 'package:flutter/material.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_texts.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../widgets/about_us_view_body.dart';

class AboutUsView extends StatelessWidget {
  const AboutUsView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.white,
      appBar: CustomAppBar(
        title: AppTexts.aboutUs,
      ),
      body: SafeArea(
        child: AboutUsViewBody(),
      ),
    );
  }
}
