import 'package:flutter/material.dart';
import 'package:furniture/core/utils/constants.dart';
import 'package:furniture/features/home/presentation/widgets/favorite_button.dart';

import '../../data/models/product_model.dart';

class ProductImage extends StatelessWidget {
  const ProductImage({
    super.key,
    required this.productModel,
  });

  final ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AspectRatio(
          aspectRatio: 1.2,
          child: Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              color: AppConstants.greyColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(
                  AppConstants.defaultBorderRadius,
                ),
                topRight: Radius.circular(
                  AppConstants.defaultBorderRadius,
                ),
              ),
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(
                  AppConstants.defaultBorderRadius,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Image.asset(
                  productModel.images.main ?? '',
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: 8,
          right: 8,
          child: FavoriteButton(productId: productModel.id),
        )
      ],
    );
  }
}
