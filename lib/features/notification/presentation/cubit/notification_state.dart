import 'package:furniture/features/notification/data/model/notification_model.dart';

import '../../data/enums/notification_type_enum.dart';

abstract class NotificationState {
  const NotificationState();
}

class NotificationInitial extends NotificationState {}

class NotificationLoading extends NotificationState {}

class NotificationSuccess extends NotificationState {
  final List<NotificationModel> notifications;
  final bool pushEnabled;
  final bool emailEnabled;
  final Map<NotificationType, bool> notificationPreferences;

  const NotificationSuccess({
    required this.notifications,
    required this.pushEnabled,
    required this.emailEnabled,
    required this.notificationPreferences,
  });
}

class NotificationFailure extends NotificationState {
  final String message;

  const NotificationFailure(this.message);
}
