import 'package:flutter/material.dart';
import 'package:furniture/core/utils/constants.dart';
import 'package:gap/gap.dart';

class CustomErrorWidget extends StatelessWidget {
  const CustomErrorWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          Icons.error,
          size: 64,
          color: Colors.grey,
        ),
        const Gap(16),
        Text(
          'Failed to load data',
          style: AppConstants.bodyStyle.copyWith(
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }
}
