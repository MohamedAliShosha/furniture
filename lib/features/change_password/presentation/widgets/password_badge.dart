import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_texts.dart';
import '../../../../core/utils/constants.dart';

class PasswordBadge extends StatelessWidget {
  const PasswordBadge({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(
            Icons.lock_outline,
            color: AppColors.primary,
          ),
        ),
        const Gap(16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppTexts.passwordSecurity,
                style: AppConstants.titleStyle.copyWith(
                  fontSize: 18,
                  color: AppColors.primary,
                ),
              ),
              const Gap(4),
              Text(
                AppTexts.chooseStrongPassword,
                style: AppConstants.bodyStyle.copyWith(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
