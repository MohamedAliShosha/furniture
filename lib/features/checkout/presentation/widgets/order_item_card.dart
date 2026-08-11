// ============================================================================
// ORDER ITEM CARD
// ============================================================================

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../core/utils/constants.dart';
import '../../../home/data/models/cart_item.dart';

class OrderItemCard extends StatelessWidget {
  const OrderItemCard({
    super.key,
    required this.cartItem,
  });

  final CartItemModel cartItem;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: AssetImage(
                  cartItem.product.images.gallery.first,
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const Gap(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cartItem.product.name,
                  style: AppConstants.bodyStyle.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Gap(4),
                Row(
                  children: [
                    Text(
                      '${cartItem.quantity} * \$${cartItem.product.price} ',
                      style: AppConstants.bodyStyle.copyWith(
                        color: Colors.grey[600],
                      ),
                    ),
                    const Gap(8),
                    Container(
                      width: 16,
                      height: 16,
                      decoration: BoxDecoration(
                        color: Color(
                          int.parse(
                            cartItem.selectedColor.replaceFirst('#', '0xFF'),
                          ),
                        ),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.grey[300]!,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          Text(
            '\$${(cartItem.product.price * cartItem.quantity).toStringAsFixed(2)}',
            style: AppConstants.bodyStyle.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
