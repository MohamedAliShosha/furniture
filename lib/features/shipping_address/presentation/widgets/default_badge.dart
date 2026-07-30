import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_texts.dart';
import '../../../../core/utils/constants.dart';

class DefaultBadge extends StatelessWidget {
  const DefaultBadge({
    super.key,
    this.boxDecorationColor,
    this.textColor,
  });

  final Color? boxDecorationColor;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: boxDecorationColor ?? AppColors.primary,
        borderRadius: BorderRadius.circular(AppConstants.smallBorderRadius),
      ),
      child: Text(
        AppTexts.defaultText,
        style: AppConstants.bodyStyle.copyWith(
          color: textColor ?? AppColors.primary,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
