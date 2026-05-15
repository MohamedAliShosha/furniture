import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../core/utils/app_texts.dart';
import '../../../../core/utils/constants.dart';
import '../../data/models/product_model.dart';
import 'animated_featured_item.dart';
import 'featured_item_card.dart';

class FeaturedItemsListView extends StatelessWidget {
  const FeaturedItemsListView({
    super.key,
    required this.products,
  });

  final List<ProductModel> products;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.defaultPadding,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  AppTexts.featuredItems,
                  overflow: TextOverflow.ellipsis,
                  style: AppConstants.headingStyle.copyWith(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {},
                child: const Text(
                  'View All',
                  style: TextStyle(
                    color: AppConstants.primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
        const Gap(16),
        SizedBox(
          height: 300,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(
              horizontal: AppConstants.defaultPadding,
            ),
            itemCount: products.length,
            itemBuilder: (context, index) {
              return Container(
                width: 190,
                margin: EdgeInsets.only(
                  right: index == products.length - 1
                      ? 0
                      : AppConstants.defaultPadding,
                ),
                child: AnimatedFeaturedItem(
                  index: index,
                  isVertical: true,
                  child: Hero(
                    tag: 'featured ${products[index].id}',
                    child: FeaturedItemCard(
                      productModel: products[index],
                      onTap: () {},
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        const Gap(AppConstants.defaultPadding),
      ],
    );
  }
}
