import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../core/utils/constants.dart';

class AuthHeader extends StatelessWidget {
  final String title;
  final String subtitle;

  const AuthHeader({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppConstants.headingStyle.copyWith(
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Gap(8),
        Text(
          subtitle,
          style: AppConstants.bodyStyle.copyWith(
            fontSize: 16,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }
}
