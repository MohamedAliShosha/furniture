import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/constants.dart';

Widget buildMenuItem(
  BuildContext context, {
  required IconData icon,
  required String title,
  required String subtitle,
  required VoidCallback onTap,
  bool isSignOut = false,
}) {
  return ListTile(
    contentPadding: const EdgeInsets.symmetric(
      horizontal: AppConstants.defaultPadding,
      vertical: 8,
    ),
    leading: Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: isSignOut
            ? AppColors.red.withOpacity(0.1)
            : AppColors.primary.withOpacity(0.1),
        shape: BoxShape.circle,
      ),
      child: Icon(
        icon,
        color: isSignOut ? AppColors.red : AppColors.primary,
      ),
    ),
    title: Text(
      title,
      style: AppConstants.titleStyle.copyWith(
        fontSize: 16,
        color: isSignOut
            ? AppColors.red
            : AppColors.black.withOpacity(
                0.8,
              ),
      ),
    ),
    subtitle: Text(
      subtitle,
      style: AppConstants.bodyStyle.copyWith(
        fontSize: 12,
        color: AppColors.grey,
      ),
    ),
    trailing: const Icon(
      Icons.arrow_forward_ios,
      size: 16,
      color: AppColors.grey,
    ),
    onTap: onTap,
  );
}
