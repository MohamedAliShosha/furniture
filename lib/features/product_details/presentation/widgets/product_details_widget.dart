import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/constants.dart';
import '../../../home/data/models/product_model.dart';
import 'add_to_cart_button.dart';
import 'color_selector.dart';
import 'product_name_and_price.dart';

class ProductDetailsWidget extends StatelessWidget {
  const ProductDetailsWidget({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
        ),
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProductNameAndPrice(product: product),
            const SizedBox(height: 24),
            if (product.category != null) ...[
              Text(
                product.category!,
                style: AppConstants.bodyStyle.copyWith(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Description',
                style: AppConstants.bodyStyle.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                product.details?.description ?? '',
                style: AppConstants.bodyStyle.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 24),
              ColorSelector(colors: product.colors ?? []),
              const SizedBox(height: 32),
            ],
            AddToCartButton(
              product: product,
              selectedColor: product.colors?.isNotEmpty == true
                  ? product.colors![0]
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
