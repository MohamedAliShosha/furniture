import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/all_products/all_products_state.dart';
import '../cubit/all_products/all_products_cubit.dart';
import '../cubit/featured_items/featured_items_cubit.dart';
import '../cubit/featured_items/featured_items_state.dart';
import '../widgets/home_view_body.dart';

class DataLoadingBlocBuilder extends StatelessWidget {
  const DataLoadingBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FeaturedItemsCubit, FeaturedItemsState>(
      builder: (context, featuredState) {
        return BlocBuilder<AllProductsCubit, AllProductsState>(
          builder: (context, allProductsState) {
            // Show header and other components immediately
            // Only show loading state for actual product data
            final featuredProducts = (featuredState is FeaturedItemsSuccess)
                ? featuredState.products
                : <dynamic>[];
            final allProducts = (allProductsState is AllProductsSuccess)
                ? allProductsState.products
                : <dynamic>[];
            final isFeaturedLoading = featuredState is FeaturedItemsLoading;
            final isAllProductsLoading = allProductsState is AllProductsLoading;

            return HomeViewBody(
              featuredProducts: featuredProducts,
              allProducts: allProducts,
              isFeaturedLoading: isFeaturedLoading,
              isAllProductsLoading: isAllProductsLoading,
            );
          },
        );
      },
    );
  }
}
