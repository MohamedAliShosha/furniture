import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../core/utils/constants.dart';
import '../../services/cart_service.dart';
import 'add_to_cart_button.dart';
import 'featured_item_card.dart';
import 'product_price_widget.dart';

class ProductDataWidget extends StatelessWidget {
  const ProductDataWidget({
    super.key,
    required this.widget,
    required this.addToCartService,
  });

  final FeaturedItemCard widget;
  final CartService addToCartService;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.productModel.name ?? '',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: AppConstants.bodyStyle.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Gap(4),
            Text(
              widget.productModel.category ?? '',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppConstants.bodyStyle.copyWith(
                fontSize: 12,
                color: Colors.grey.shade600,
              ),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: ProductPrice(
                    productModel: widget.productModel,
                  ),
                ),
                const Gap(8),
                // cart button
                AddToCartButton(
                  productModel: widget.productModel,
                  addToCartService: addToCartService,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
