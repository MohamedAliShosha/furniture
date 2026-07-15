import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/utils/app_router.dart';
import '../../../../core/utils/constants.dart';
import '../../../home/presentation/widgets/animated_list_item.dart';
import '../../../home/presentation/widgets/featured_item_card.dart';

class FeaturedProductsGridView extends StatelessWidget {
  const FeaturedProductsGridView({
    super.key,
    required this.featuredItems,
  });

  final List featuredItems;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(
        AppConstants.defaultPadding,
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: .65,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
      ),
      itemCount: featuredItems.length,
      itemBuilder: (context, index) {
        return AnimatedListItem(
          isVertical: false,
          index: index,
          child: Hero(
            tag: 'featured ${featuredItems[index].id}',
            child: FeaturedItemCard(
              onTap: () {
                GoRouter.of(context).push(AppRouter.kProductDetailsView);
              },
              productModel: featuredItems[index],
            ),
          ),
        );
      },
    );
  }
}
