import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../utils/app_colors.dart';
import '../utils/constants.dart';

class CustomEmptyState extends StatelessWidget {
  const CustomEmptyState({
    super.key,
    required this.message,
    this.subtitle,
    this.icon,
    this.iconColor,
    this.textColor,
  });

  final String message;
  final String? subtitle;
  final Widget? icon;
  final Color? iconColor;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.defaultPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon ??
                Icon(
                  CupertinoIcons.folder_open,
                  size: 64,
                  color: iconColor ?? Colors.grey[400],
                ),
            const Gap(16),
            Text(
              message,
              textAlign: TextAlign.center,
              style: AppConstants.titleStyle.copyWith(
                color: textColor ?? AppColors.grey,
                fontSize: 18,
              ),
            ),
            if (subtitle != null) ...[
              const Gap(8),
              Text(
                subtitle!,
                textAlign: TextAlign.center,
                style: AppConstants.bodyStyle.copyWith(
                  color: AppColors.grey,
                  fontSize: 16,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
