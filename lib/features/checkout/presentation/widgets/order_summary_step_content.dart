import 'package:flutter/material.dart';
import '../../../../core/utils/app_texts.dart';
import '../../../home/data/models/cart_item.dart';
import 'order_item_card.dart';
import 'price_row.dart';

class OrderSummaryStepContent extends StatelessWidget {
  const OrderSummaryStepContent({
    super.key,
    required this.cartItems,
    required this.total,
  });

  final List<CartItemModel> cartItems;
  final double total;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...cartItems.map(
          (item) => OrderItemCard(cartItem: item),
        ),
        const Divider(
          height: 32,
        ),
        PriceRow(label: AppTexts.subtotal, amount: total),
        const Divider(
          height: 8,
        ),
        const PriceRow(label: AppTexts.shipping, amount: 10.0),
        const Divider(
          height: 8,
        ),
        PriceRow(
          label: AppTexts.total,
          amount: total + 10,
          isTotal: true,
        ),
      ],
    );
  }
}
