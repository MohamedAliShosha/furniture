import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../home/presentation/cubit/featured_items/featured_items_cubit.dart';
import '../../../home/presentation/cubit/featured_items/featured_items_state.dart';
import 'package:gap/gap.dart';
import '../../../../core/utils/app_texts.dart';
import '../../../../core/utils/constants.dart';
import 'featured_products_grid_view.dart';

class FeaturedProductsViewBlocBuilder extends StatelessWidget {
  const FeaturedProductsViewBlocBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FeaturedItemsCubit, FeaturedItemsState>(
      builder: (context, state) {
        final featuredItems =
            state is FeaturedItemsSuccess ? state.products : [];
        if (featuredItems.isEmpty) {
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
                  AppTexts.noFeaturedProductsAvailable,
                  style: AppConstants.titleStyle.copyWith(
                    color: Colors.grey[600],
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          );
        }
        return FeaturedProductsGridView(
          featuredItems: featuredItems,
        );
      },
    );
  }
}
