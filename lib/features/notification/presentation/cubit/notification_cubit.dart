import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/enums/notification_type_enum.dart';
import '../../data/model/notification_model.dart';
import '../../services/notification_service.dart';
import 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  final NotificationService notificationService;

  NotificationCubit(this.notificationService) : super(NotificationInitial());

  Future<void> loadNotifications() async {
    if (isClosed) return;
    emit(NotificationLoading());

    try {
      await notificationService.loadNotifications();
      await notificationService.addSampleNotifications();
      final notifications = notificationService.getNotifications;
      final pushEnabled = notificationService.pushedEnabled;
      final emailEnabled = notificationService.emailEnabled;
      final notificationPreferences =
          notificationService.notificationPreferences;
      final successNotificationState = NotificationSuccess(
        notifications: notifications,
        pushEnabled: pushEnabled,
        emailEnabled: emailEnabled,
        notificationPreferences: notificationPreferences,
      );

      if (!isClosed) {
        emit(successNotificationState);
      }
    } catch (e) {
      if (!isClosed) {
        emit(
          NotificationFailure(
            e.toString(),
          ),
        );
      }
    }
  }

  Future<void> togglePush(bool value) async {
    if (isClosed) return;
    try {
      await notificationService.setPushEnabled(value);
      final notifications = notificationService.getNotifications;
      final pushEnabled = notificationService.pushedEnabled;
      final emailEnabled = notificationService.emailEnabled;
      final notificationPreferences =
          notificationService.notificationPreferences;
      if (!isClosed) {
        emit(
          NotificationSuccess(
            notifications: notifications,
            pushEnabled: pushEnabled,
            emailEnabled: emailEnabled,
            notificationPreferences: notificationPreferences,
          ),
        );
      }
    } catch (e) {
      if (!isClosed) {
        emit(NotificationFailure(e.toString()));
      }
    }
  }

  Future<void> toggleEmail(bool value) async {
    if (isClosed) return;
    try {
      await notificationService.setEmailEnabled(value);
      final notifications = notificationService.getNotifications;
      final pushEnabled = notificationService.pushedEnabled;
      final emailEnabled = notificationService.emailEnabled;
      final notificationPreferences =
          notificationService.notificationPreferences;
      if (!isClosed) {
        emit(
          NotificationSuccess(
            notifications: notifications,
            pushEnabled: pushEnabled,
            emailEnabled: emailEnabled,
            notificationPreferences: notificationPreferences,
          ),
        );
      }
    } catch (e) {
      if (!isClosed) {
        emit(NotificationFailure(e.toString()));
      }
    }
  }

  Future<void> setPreference(NotificationType type, bool value) async {
    if (isClosed) return;
    try {
      await notificationService.setNotificationPreference(type, value);
      final notifications = notificationService.getNotifications;
      final pushEnabled = notificationService.pushedEnabled;
      final emailEnabled = notificationService.emailEnabled;
      final notificationPreferences =
          notificationService.notificationPreferences;
      if (!isClosed) {
        emit(
          NotificationSuccess(
            notifications: notifications,
            pushEnabled: pushEnabled,
            emailEnabled: emailEnabled,
            notificationPreferences: notificationPreferences,
          ),
        );
      }
    } catch (e) {
      if (!isClosed) {
        emit(NotificationFailure(e.toString()));
      }
    }
  }

  Future<void> addNotification(NotificationModel notification) async {
    if (isClosed) return;
    try {
      notificationService.addNotification(notification);
      final notifications = notificationService.getNotifications;
      final pushEnabled = notificationService.pushedEnabled;
      final emailEnabled = notificationService.emailEnabled;
      final notificationPreferences =
          notificationService.notificationPreferences;
      if (!isClosed) {
        emit(
          NotificationSuccess(
            notifications: notifications,
            pushEnabled: pushEnabled,
            emailEnabled: emailEnabled,
            notificationPreferences: notificationPreferences,
          ),
        );
      }
    } catch (e) {
      if (!isClosed) {
        emit(NotificationFailure(e.toString()));
      }
    }
  }

  Future<void> markAsRead(String id) async {
    if (isClosed) return;
    try {
      notificationService.markAsRead(id);
      final notifications = notificationService.getNotifications;
      final pushEnabled = notificationService.pushedEnabled;
      final emailEnabled = notificationService.emailEnabled;
      final notificationPreferences =
          notificationService.notificationPreferences;
      if (!isClosed) {
        emit(
          NotificationSuccess(
            notifications: notifications,
            pushEnabled: pushEnabled,
            emailEnabled: emailEnabled,
            notificationPreferences: notificationPreferences,
          ),
        );
      }
    } catch (e) {
      if (!isClosed) {
        emit(NotificationFailure(e.toString()));
      }
    }
  }

  Future<void> removeNotification(String id) async {
    if (isClosed) return;
    try {
      notificationService.removeNotification(id);
      final notifications = notificationService.getNotifications;
      final pushEnabled = notificationService.pushedEnabled;
      final emailEnabled = notificationService.emailEnabled;
      final notificationPreferences =
          notificationService.notificationPreferences;
      if (!isClosed) {
        emit(
          NotificationSuccess(
            notifications: notifications,
            pushEnabled: pushEnabled,
            emailEnabled: emailEnabled,
            notificationPreferences: notificationPreferences,
          ),
        );
      }
    } catch (e) {
      if (!isClosed) {
        emit(NotificationFailure(e.toString()));
      }
    }
  }

  Future<void> clearNotifications() async {
    if (isClosed) return;
    try {
      notificationService.clearNotifications();
      final notifications = notificationService.getNotifications;
      final pushEnabled = notificationService.pushedEnabled;
      final emailEnabled = notificationService.emailEnabled;
      final notificationPreferences =
          notificationService.notificationPreferences;
      if (!isClosed) {
        emit(
          NotificationSuccess(
            notifications: notifications,
            pushEnabled: pushEnabled,
            emailEnabled: emailEnabled,
            notificationPreferences: notificationPreferences,
          ),
        );
      }
    } catch (e) {
      if (!isClosed) {
        emit(NotificationFailure(e.toString()));
      }
    }
  }
}
