import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../home/presentation/cubit/featured_items/featured_items_cubit.dart';
import '../../../home/presentation/cubit/featured_items/featured_items_state.dart';
import '../../../../core/utils/app_texts.dart';
import '../../../../core/widgets/custom_empty_state.dart';
import 'featured_items_grid_view.dart';

class FeaturedProductsBlocBuilder extends StatelessWidget {
  const FeaturedProductsBlocBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FeaturedItemsCubit, FeaturedItemsState>(
      builder: (context, state) {
        final featuredItems =
            state is FeaturedItemsSuccess ? state.products : [];
        if (featuredItems.isEmpty) {
          return CustomEmptyState(
            message: AppTexts.noFeaturedProductsAvailable,
            icon: Icon(
              Icons.search_off_rounded,
              size: 64,
              color: Colors.grey[400],
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
