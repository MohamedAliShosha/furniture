import 'package:flutter/material.dart';

import '../../../../core/utils/app_texts.dart';
import '../../../../core/utils/constants.dart';
import '../cubit/notification_cubit.dart';

class RecentNotificationsListHeader extends StatelessWidget {
  const RecentNotificationsListHeader({
    super.key,
    required this.cubit,
  });

  final NotificationCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          AppTexts.recentNotifications,
          style: AppConstants.titleStyle.copyWith(
            fontSize: 18,
          ),
        ),
        const Spacer(),
        TextButton(
          onPressed: () {
            cubit.clearNotifications();
          },
          child: const Text(
            AppTexts.clearAll,
          ),
        ),
      ],
    );
  }
}
