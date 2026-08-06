import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/notification_cubit.dart';
import '../cubit/notification_state.dart';
import 'recent_notification_list_view.dart';
import 'settings_section_widget.dart';

class NotificationsViewBlocBuilder extends StatelessWidget {
  const NotificationsViewBlocBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationCubit, NotificationState>(
      builder: (context, state) {
        final cubit = context.read<NotificationCubit>();
        final pushEnabled =
            state is NotificationSuccess ? state.pushEnabled : false;
        final emailEnabled =
            state is NotificationSuccess ? state.emailEnabled : false;

        return ListView(
          children: [
            const SizedBox(height: 20),
            SettingsSectionWidget(
              cubit: cubit,
              pushEnabled: pushEnabled,
              emailEnabled: emailEnabled,
            ),
            Divider(
              color: Colors.grey[300],
              height: 16,
            ),
            RecentNotificationListView(cubit: cubit),
          ],
        );
      },
    );
  }
}
