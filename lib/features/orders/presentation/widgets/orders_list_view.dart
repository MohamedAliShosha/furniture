import 'package:flutter/material.dart';
import 'package:furniture/core/utils/constants.dart';

import '../../data/models/order_model.dart';
import 'order_card_widget.dart';

class OrdersListView extends StatelessWidget {
  const OrdersListView({
    super.key,
    required this.orders,
  });

  final List<OrderModel> orders;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(AppConstants.defaultPadding),
      itemCount: orders.length,
      itemBuilder: (context, index) {
        final order = orders[index];
        return OrderCardWidget(
          order: order,
        ); // replace with your item widget
      },
    );
  }
}
