import 'package:flutter/material.dart';
import 'notifications_view_bloc_builder.dart';

class NotificationViewBody extends StatelessWidget {
  const NotificationViewBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const NotificationsViewBlocBuilder();
  }
}
