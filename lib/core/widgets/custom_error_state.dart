import 'package:flutter/cupertino.dart';
import 'package:gap/gap.dart';

import '../utils/app_colors.dart';
import '../utils/constants.dart';

class CustomErrorState extends StatelessWidget {
  const CustomErrorState({
    super.key,
    required this.message,
    this.onRetry,
    this.retryLabel,
    this.icon,
  });

  final String message;
  final VoidCallback? onRetry;
  final String? retryLabel;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.defaultPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon ??
                const Icon(
                  CupertinoIcons.exclamationmark_circle_fill,
                  size: 64,
                  color: AppColors.red,
                ),
            const Gap(16),
            Text(
              message,
              textAlign: TextAlign.center,
              style: AppConstants.titleStyle.copyWith(
                color: AppColors.grey,
                fontSize: 18,
              ),
            ),
            if (onRetry != null) ...[
              const Gap(24),
              CupertinoButton(
                onPressed: onRetry,
                color: AppColors.primary,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                borderRadius:
                    BorderRadius.circular(AppConstants.defaultBorderRadius),
                child: Text(
                  retryLabel ?? 'Retry',
                  style: const TextStyle(
                    color: AppColors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
