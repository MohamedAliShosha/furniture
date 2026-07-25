import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/constants.dart';
import '../../data/models/order_model.dart';
import 'icon_label_row.dart';
import 'order_action_buttons.dart';
import 'order_status_badge.dart';

class OrderCardWidget extends StatelessWidget {
  const OrderCardWidget({super.key, required this.order});

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius),
        boxShadow: [
          BoxShadow(
            color: AppColors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  overflow: TextOverflow.ellipsis,
                  order.id,
                  style: AppConstants.titleStyle.copyWith(fontSize: 16),
                ),
              ),
              const Gap(8),
              OrderStatusBadge(status: order.status),
            ],
          ),
          const Gap(12),
          Wrap(
            spacing: 16,
            runSpacing: 8,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              IconLabelRow(
                icon: Icons.calendar_today,
                label: DateFormat('MMM dd, yyyy').format(order.orderDate),
              ),
              IconLabelRow(
                icon: Icons.shopping_bag_outlined,
                label: '${order.orderItems.length} items',
              ),
            ],
          ),
          Divider(
            height: 24,
            color: Colors.grey[300],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total Amount',
                style: AppConstants.bodyStyle.copyWith(
                  color: Colors.grey[600],
                  fontSize: 14,
                ),
              ),
              Text(
                '\$${order.total.toStringAsFixed(2)}',
                style: AppConstants.bodyStyle.copyWith(
                  color: AppColors.primary,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          if (order.isActive) ...[
            const Gap(16),
            OrderActionButtons(order: order),
          ]
        ],
      ),
    );
  }
}
