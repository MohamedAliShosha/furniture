import '../../../../core/utils/app_texts.dart';
import '../data/enums/notification_type_enum.dart';

String getNotificationTypeDescription(NotificationType type) {
  switch (type) {
    case NotificationType.order:
      return AppTexts.receiveUpdatesAboutYourOrders;
    case NotificationType.promotion:
      return AppTexts.receivePromotionalOffersAndDiscounts;
    case NotificationType.newArrival:
      return AppTexts.getNotifiedAboutNewArrivalsInOurStore;
    case NotificationType.delivery:
      return AppTexts.receiveUpdatesAboutYourDeliveryStatus;
    default:
      return '';
  }
}
