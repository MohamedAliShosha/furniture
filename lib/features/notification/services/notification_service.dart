import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/utils/app_keys.dart';
import '../data/enums/notification_type_enum.dart';
import '../data/model/notification_model.dart';

class NotificationService {
  // List to store notifications in memory. In a real application, you might want to persist these in a database or use a state management solution.
  final List<NotificationModel> _notifications = [];
  // enables the user to receive push notifications. This can be toggled in the app settings.
  bool _pushedEnabled = true;
  // enables the user to receive email notifications. This can be toggled in the app settings.
  bool _emailEnabled = true;

  // This Map is used to store the user's notification preferences for each notification type.
  final Map<NotificationType, bool> _notificationPreferences = {
    NotificationType.order: true,
    NotificationType.promotion: true,
    NotificationType.newArrival: true,
    NotificationType.delivery: true,
  };

  String _getPreferenceKey(NotificationType type) {
    switch (type) {
      case NotificationType.order:
        return AppKeys.notificationPreferencesOrderKey;
      case NotificationType.promotion:
        return AppKeys.notificationPreferencesPromotionKey;
      case NotificationType.newArrival:
        return AppKeys.notificationPreferencesNewArrivalKey;
      case NotificationType.delivery:
        return AppKeys.notificationPreferencesDeliveryKey;
    }
  }

  List<NotificationModel> get getNotifications => _notifications;
  bool get pushedEnabled => _pushedEnabled;
  bool get emailEnabled => _emailEnabled;

  Map<NotificationType, bool> get notificationPreferences =>
      _notificationPreferences;

  Future<void> loadNotifications() async {
    await _loadNotificationPreferences();
  }

  Future<void> _loadNotificationPreferences() async {
    // Load the user's notification preferences from persistent storage (e.g., SharedPreferences).
    final prefs = await SharedPreferences.getInstance();
    _pushedEnabled = prefs.getBool(AppKeys.pushEnabledKey) ?? true;
    _emailEnabled = prefs.getBool(AppKeys.emailEnabledKey) ?? true;

    for (var type in NotificationType.values) {
      _notificationPreferences[type] = prefs.getBool(_getPreferenceKey(type)) ?? true;
    }
  }

  Future<void> setPushEnabled(bool value) async {
    _pushedEnabled = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(AppKeys.pushEnabledKey, value);
  }

  Future<void> setEmailEnabled(bool value) async {
    _emailEnabled = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(AppKeys.emailEnabledKey, value);
  }

  Future<void> setNotificationPreference(
      NotificationType type, bool value) async {
    _notificationPreferences[type] = value;
    final prefs = await SharedPreferences.getInstance();
    final prefKey = _getPreferenceKey(type);
    await prefs.setBool(prefKey, value);
  }

  void addNotification(NotificationModel notification) {
    // only add the notification if the user has enabled notifications for that type
    if (_notificationPreferences[notification.type] ?? false) {
      _notifications.insert(
          0, notification); // Add to the beginning of the list
    }
  }

  void removeNotification(String id) {
    _notifications.removeWhere((notification) => notification.id == id);
  }

  void markAsRead(String id) {
    final index =
        _notifications.indexWhere((notification) => notification.id == id);
    if (index != -1) {
      _notifications[index] =
          _notifications[index].notificationModelCopy(isRead: true);
    }
  }

  void clearNotifications() {
    _notifications.clear();
  }

  // add some sample notifications for testing
  Future<void> addSampleNotifications() async {
    if (_notifications.isNotEmpty) {
      return; // only add sample notifications if the list is empty
    }
    final sampleNotifications = [
      NotificationModel(
        id: '1',
        title: 'Order Confirmed',
        message: 'Your order #1234 has been confirmed.',
        timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
        type: NotificationType.order,
        isRead: false,
      ),
      NotificationModel(
        id: '2',
        title: 'New Promotion',
        message: 'Get 20% off on your next purchase!',
        timestamp: DateTime.now().subtract(const Duration(hours: 1)),
        type: NotificationType.promotion,
        isRead: false,
      ),
      NotificationModel(
        id: '3',
        title: 'New Arrival',
        message: 'Check out our latest collection of furniture.',
        timestamp: DateTime.now().subtract(const Duration(days: 1)),
        type: NotificationType.newArrival,
        isRead: false,
      ),
    ];

    for (var notification in sampleNotifications) {
      // only add the notification if the user has enabled notifications for that type
      if (_notificationPreferences[notification.type] ?? false) {
        addNotification(notification);
      }
    }
  }
}
