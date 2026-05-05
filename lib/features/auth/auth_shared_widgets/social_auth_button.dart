import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../core/utils/constants.dart';

class SocialAuthButton extends StatelessWidget {
  const SocialAuthButton({
    super.key,
    required this.title,
    required this.icon,
    required this.onPressed,
  });

  final String title;
  final String icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(
          vertical: 16,
        ),
        side: BorderSide(
          color: Colors.grey[300]!,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            AppConstants.defaultBorderRadius,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            icon,
            height: 24,
            width: 24,
          ),
          const Gap(12),
          Text(title,
              style: AppConstants.bodyStyle.copyWith(
                  color: Colors.grey[800], fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
