import 'package:flutter/material.dart';

import '../../../../core/utils/constants.dart';
import '../../../special_offer/presentation/cubit/special_offer_cubit.dart';
import '../../data/models/product_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductPrice extends StatelessWidget {
  const ProductPrice({
    super.key,
    required this.productModel,
  });

  final ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    final specialOfferCubit = context.read<SpecialOfferCubit>();
    final bestOffer = specialOfferCubit.getBestOffer(productModel);
    final discountedPrice = specialOfferCubit.getDiscountedPrice(productModel);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: bestOffer != null
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '\$${productModel.price.toStringAsFixed(2)}',
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
                  '\$${productModel.price.toStringAsFixed(2)}',
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
