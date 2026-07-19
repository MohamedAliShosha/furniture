import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/utils/app_router.dart';
import '../../../../core/utils/app_texts.dart';
import '../../../../core/utils/constants.dart';
import '../../data/models/product_model.dart';
import '../widgets/animated_list_item.dart';
import '../widgets/featured_item_card.dart';

class ProductsGridView extends StatelessWidget {
  const ProductsGridView({
    super.key,
    required this.products,
  });

  final List<ProductModel> products;

  @override
  Widget build(BuildContext context) {
    if (products.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_off_rounded,
              size: 64,
              color: Colors.grey[400],
            ),
            const Gap(16),
            Text(
              AppTexts.noProductsFound,
              style: AppConstants.titleStyle.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.grey[600],
              ),
            ),
            const Gap(8),
            Text(
              AppTexts.trySearchingForSomething,
              style: AppConstants.bodyStyle.copyWith(
                color: Colors.grey[500],
              ),
            ),
          ],
        ),
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.all(AppConstants.defaultPadding),
      itemCount: products.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.65,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
      ),
      itemBuilder: (context, index) {
        final ProductModel product = products[index];
        return AnimatedListItem(
          isVertical: false,
          index: index,
          child: Hero(
            tag: 'product_${product.id}',
            child: FeaturedItemCard(
              productModel: product,
              onTap: () {
                GoRouter.of(context).push(
                  AppRouter.kProductDetailsView,
                  extra: product,
                );
              },
            ),
          ),
        );
      },
    );
  }
}
