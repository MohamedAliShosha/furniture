import 'package:flutter/material.dart';

import '../../../../core/utils/constants.dart';
import '../../data/models/product_model.dart';
import '../../services/special_offers_service.dart';

class ProductPrice extends StatelessWidget {
  const ProductPrice({
    super.key,
    required this.productModel,
  });

  final ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    final specialOffersService = SpecialOffersService();
    final bestOffer = specialOffersService.getBestOffer(productModel);
    final discountedPrice = bestOffer != null
        ? productModel.price -
            ((productModel.price * bestOffer.discountPercentage) / 100)
        : productModel.price;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: bestOffer != null
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '\$${productModel.price.toStringAsFixed(2) ?? '0.00'}',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 12,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                    Text(
                      '\$${discountedPrice.toStringAsFixed(2)}',
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: AppConstants.primaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                )
              : Text(
                  maxLines: 1,
                  '\$${productModel.price.toStringAsFixed(2) ?? '0.00'}',
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: AppConstants.primaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
        ),
      ],
    );
  }
}
