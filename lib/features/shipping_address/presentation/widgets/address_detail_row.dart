import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/constants.dart';

class AddressDetailRow extends StatelessWidget {
  const AddressDetailRow({
    super.key,
    required this.icon,
    required this.title,
  });

  final IconData icon;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: 20,
          color: AppColors.secondaryText,
        ),
        const Gap(4),
        Text(
          title,
          style: AppConstants.bodyStyle.copyWith(
            color: Colors.grey[800],
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
