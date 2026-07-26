import 'package:flutter/material.dart';

import '../../../../core/utils/constants.dart';
import '../../../../core/utils/app_texts.dart';
import '../../data/enums/order_status_enum.dart';

class OrderStatusBadge extends StatelessWidget {
  const OrderStatusBadge({super.key, required this.status});

  final OrderStatusEnum status;

  @override
  Widget build(BuildContext context) {
    final color = _getStatusColor(status);
    return Container(
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppConstants.smallBorderRadius),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Text(
        _getStatusText(status),
        style: AppConstants.bodyStyle.copyWith(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Color _getStatusColor(OrderStatusEnum orderStatus) {
    return switch (orderStatus) {
      OrderStatusEnum.processing => Colors.orange,
      OrderStatusEnum.confirmed => Colors.blue,
      OrderStatusEnum.shipped => Colors.indigo,
      OrderStatusEnum.outForDelivery => Colors.purple,
      OrderStatusEnum.delivered => Colors.green,
      OrderStatusEnum.cancelled => Colors.red,
    };
  }

  String _getStatusText(OrderStatusEnum orderStatus) {
    return switch (orderStatus) {
      OrderStatusEnum.processing => AppTexts.processing,
      OrderStatusEnum.confirmed => AppTexts.confirmed,
      OrderStatusEnum.shipped => AppTexts.shipped,
      OrderStatusEnum.outForDelivery => AppTexts.outOfDelivery,
      OrderStatusEnum.delivered => AppTexts.delivered,
      OrderStatusEnum.cancelled => AppTexts.cancelled,
    };
  }
}
