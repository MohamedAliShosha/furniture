import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../core/utils/app_texts.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/widgets/custom_empty_state.dart';

class RecentNotificationsListEmptyStateWidget extends StatelessWidget {
  const RecentNotificationsListEmptyStateWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomEmptyState(
          messageColor: Colors.grey[600],
          message: AppTexts.noNotificationsYet,
          icon: const Icon(Icons.notifications_off),
        ),
        const Gap(8),
        Text(
          AppTexts.youWillSeeNotificationsHere,
          style: AppConstants.bodyStyle.copyWith(
            color: Colors.grey[500],
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
