import 'package:flutter/material.dart';
import '../../../../core/utils/app_texts.dart';
import '../../../../core/utils/constants.dart';
import '../../data/enums/notification_type_enum.dart';
import '../../functions/get_notification_type_description.dart';
import '../../functions/get_notification_type_title.dart';
import '../cubit/notification_cubit.dart';

class SettingsSectionWidget extends StatelessWidget {
  const SettingsSectionWidget({
    super.key,
    required this.cubit,
    required this.pushEnabled,
    required this.emailEnabled,
  });

  final NotificationCubit cubit;
  final bool pushEnabled;
  final bool emailEnabled;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(AppConstants.defaultPadding),
          child: Text(
            AppTexts.settings,
            style: AppConstants.titleStyle.copyWith(
              fontSize: 18,
            ),
          ),
        ),
        SwitchListTile(
          // true as default value, you can change it based on your needs
          value: pushEnabled,
          onChanged: (value) {
            cubit.togglePush(value);
          },
          title: const Text(
            AppTexts.pushNotifications,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: const Text(
            AppTexts.receivePushNotifications,
          ),
        ),
        SwitchListTile(
          value: emailEnabled,
          onChanged: (value) {
            cubit.toggleEmail(value);
          },
          title: const Text(
            AppTexts.emailNotifications,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: const Text(
            AppTexts.receiveEmailNotifications,
          ),
        ),
        Divider(
          color: Colors.grey[300],
          height: 32,
        ),
        Padding(
          padding: const EdgeInsets.all(AppConstants.defaultPadding),
          child: Text(
            AppTexts.notificationTypes,
            style: AppConstants.titleStyle.copyWith(
              fontSize: 18,
            ),
          ),
        ),
        ...NotificationType.values.map(
          (type) => SwitchListTile(
            value: cubit.notificationService.notificationPreferences[type] ??
                false,
            onChanged: (value) {
              cubit.setPreference(type, value);
            },
            title: Text(
              getNotificationTypeTitle(type),
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              getNotificationTypeDescription(type),
            ),
          ),
        )
      ],
    );
  }
}
