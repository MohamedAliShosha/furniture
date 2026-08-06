import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/constants.dart';
import '../cubit/notification_cubit.dart';
import '../cubit/notification_state.dart';
import 'recent_notifications_list_empty_state_widget.dart';
import 'recent_notifications_list_header.dart';

class RecentNotificationListView extends StatelessWidget {
  const RecentNotificationListView({super.key, required this.cubit});

  final NotificationCubit cubit;

  @override
  Widget build(BuildContext context) {
    final state = cubit.state;
    final notifications =
        state is NotificationSuccess ? state.notifications : [];
    if (notifications.isEmpty) {
      return const RecentNotificationsListEmptyStateWidget();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(AppConstants.defaultPadding),
          child: RecentNotificationsListHeader(cubit: cubit),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: notifications.length,
          itemBuilder: (context, index) {
            final notification = notifications[index];
            return Dismissible(
              key: Key(notification.id),
              direction: DismissDirection.endToStart,
              onDismissed: (direction) {
                cubit.removeNotification(notification.id);
              },
              background: Container(
                color: Colors.red,
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.only(right: 20),
                child: const Icon(
                  Icons.delete,
                  color: AppColors.white,
                ),
              ),
              child: ListTile(
                  leading: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: notification.type.color.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      notification.type.icon,
                      color: notification.type.color,
                    ),
                  ),
                  title: Text(
                    notification.title,
                    style: AppConstants.titleStyle.copyWith(
                      fontSize: 16,
                      color: notification.isRead
                          ? AppColors.grey
                          : AppColors.black,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Gap(4),
                      Text(
                        notification.message,
                        style: AppConstants.bodyStyle.copyWith(
                          color: Colors.grey[600],
                          fontSize: 14,
                        ),
                      ),
                      const Gap(4),
                      Text(
                        timeago.format(notification.timestamp),
                        style: AppConstants.bodyStyle.copyWith(
                          color: AppColors.grey,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  contentPadding:
                      const EdgeInsets.all(AppConstants.defaultPadding),
                  onTap: () {
                    cubit.markAsRead(notification.id);
                  }),
            );
          },
        ),
      ],
    );
  }
}
