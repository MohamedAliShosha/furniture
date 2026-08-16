import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../core/utils/constants.dart';

class AccountInfoCard extends StatelessWidget {
  const AccountInfoCard({
    super.key,
    required this.title,
    required this.content,
    required this.icon,
    required this.color,
  });

  final String title;
  final String content;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(
          AppConstants.defaultBorderRadius,
        ),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: color,
          ),
          const Gap(16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppConstants.bodyStyle.copyWith(
                  color: Colors.grey[600],
                  fontSize: 14,
                ),
              ),
              const Gap(4),
              Text(
                content,
                style: AppConstants.titleStyle.copyWith(
                  color: color,
                  fontSize: 16,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
