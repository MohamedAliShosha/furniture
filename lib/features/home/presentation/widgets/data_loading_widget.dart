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
      builder: (context, state) {
        if (state is FeaturedItemsLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is FeaturedItemsSuccess) {
          return BlocBuilder<AllProductsCubit, AllProductsState>(
            builder: (context, allProductsState) {
              if (allProductsState is AllProductsLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (allProductsState is AllProductsSuccess) {
                return HomeViewBody(
                  featuredProducts: state.products,
                  allProducts: allProductsState.products,
                );
              } else {
                return HomeViewBody(
                  featuredProducts: state.products,
                  allProducts: const [], // fallback
                );
              }
            },
          );
        } else {
          return const HomeViewBody(
            featuredProducts: [],
            allProducts: [],
          ); // Initial state
        }
      },
    );
  }
}
