import 'package:flutter/material.dart';
import '../../../../core/utils/app_router.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_texts.dart';
import '../../../../core/utils/constants.dart';

class AuthBottomSheet extends StatelessWidget {
  const AuthBottomSheet({
    super.key,
    required this.message,
    this.actionButtonText,
    this.onActionButtonPressed,
    this.onContinueAsGuest,
  });
  final String message;
  final String? actionButtonText;
  final VoidCallback? onActionButtonPressed;
  final VoidCallback? onContinueAsGuest;

  static Future<void> show(
    BuildContext context, {
    required String message,
    String? actionButtonText,
    VoidCallback? onActionButtonPressed,
    VoidCallback? onContinueAsGuest,
  }) {
    return showModalBottomSheet(
      context: context,
      builder: (context) => AuthBottomSheet(
        message: message,
        actionButtonText: actionButtonText,
        onActionButtonPressed: onActionButtonPressed,
        onContinueAsGuest: onContinueAsGuest,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(
            20,
          ),
        ),
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 4,
            margin: const EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Icon(
            Icons.lock_outline,
            size: 48,
            color: Colors.grey[400],
          ),
          const Gap(16),
          Text(
            AppTexts.signInRequired,
            style: AppConstants.headingStyle.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          const Gap(8),
          Text(
            message,
            textAlign: TextAlign.center,
            style: AppConstants.bodyStyle.copyWith(
              color: Colors.grey[600],
            ),
          ),
          const Gap(24),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context); // Close the bottom sheet
              GoRouter.of(context).push(AppRouter.kLoginView);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              minimumSize: const Size(double.infinity, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              AppTexts.signIn,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.white,
              ),
            ),
          ),
          const Gap(12),
          TextButton(
            onPressed: () {
              if (onContinueAsGuest != null) {
                onContinueAsGuest!();
              }
              Navigator.pop(context);
            },
            child: Text(
              AppTexts.continueAsGuest,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.grey[700],
              ),
            ),
          ),
          if (actionButtonText != null) ...[
            const Gap(12),
            OutlinedButton(
              onPressed: onActionButtonPressed,
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                actionButtonText!,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.white,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
