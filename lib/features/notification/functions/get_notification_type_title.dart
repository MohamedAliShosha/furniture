import '../../../../core/utils/app_texts.dart';
import '../data/enums/notification_type_enum.dart';

String getNotificationTypeTitle(NotificationType type) {
  switch (type) {
    case NotificationType.order:
      return AppTexts.orderUpdates;
    case NotificationType.promotion:
      return AppTexts.promotions;
    case NotificationType.newArrival:
      return AppTexts.newArrivals;
    case NotificationType.delivery:
      return AppTexts.deliveryStatus;
    default:
      return '';
  }
}
