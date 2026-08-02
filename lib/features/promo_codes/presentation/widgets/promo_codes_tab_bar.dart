import 'package:flutter/material.dart';
import 'package:furniture/core/utils/app_colors.dart';
import 'package:furniture/core/utils/constants.dart';
import 'package:furniture/core/utils/app_texts.dart';

class PromoCodesTabBar extends StatelessWidget {
  const PromoCodesTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: AppConstants.defaultPadding,
        vertical: AppConstants.defaultPadding,
      ),
      height: 45,
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(25),
      ),
      child: TabBar(
        labelStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        labelColor: AppColors.white,
        unselectedLabelColor: Colors.grey[600],
        dividerColor: Colors.transparent,
        indicatorSize: TabBarIndicatorSize.tab,
        padding: const EdgeInsets.all(3),
        indicator: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 2),
            )
          ],
        ),
        tabs: const [
          Tab(text: AppTexts.availableTab),
          Tab(text: AppTexts.usedTab),
        ],
      ),
    );
  }
}
