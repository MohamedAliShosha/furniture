import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/all_products/all_products_state.dart';
import '../cubit/all_products/all_products_cubit.dart';
import '../cubit/featured_items/featured_items_cubit.dart';
import '../cubit/featured_items/featured_items_state.dart';
import '../cubit/categories/categories_cubit.dart';
import '../cubit/categories/categories_state.dart';
import '../widgets/home_view_body.dart';

class DataLoadingBlocBuilder extends StatefulWidget {
  const DataLoadingBlocBuilder({super.key});

  @override
  State<DataLoadingBlocBuilder> createState() => _DataLoadingBlocBuilderState();
}

class _DataLoadingBlocBuilderState extends State<DataLoadingBlocBuilder> {
  String _selectedCategory = 'All';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FeaturedItemsCubit, FeaturedItemsState>(
      builder: (context, featuredState) {
        return BlocBuilder<AllProductsCubit, AllProductsState>(
          builder: (context, allProductsState) {
            return BlocBuilder<CategoriesCubit, CategoriesState>(
              builder: (context, categoriesState) {
                final featuredProducts = (featuredState is FeaturedItemsSuccess)
                    ? featuredState.products
                    : <dynamic>[];
                final allProducts = (allProductsState is AllProductsSuccess)
                    ? allProductsState.products
                    : <dynamic>[];
                final categories = (categoriesState is CategoriesSuccess)
                    ? categoriesState.categories
                    : <dynamic>[];
                final isFeaturedLoading = featuredState is FeaturedItemsLoading;
                final isAllProductsLoading = allProductsState is AllProductsLoading;
                final isCategoriesLoading = categoriesState is CategoriesLoading;

                return HomeViewBody(
                  featuredProducts: featuredProducts,
                  allProducts: allProducts,
                  categories: categories,
                  isFeaturedLoading: isFeaturedLoading,
                  isAllProductsLoading: isAllProductsLoading,
                  isCategoriesLoading: isCategoriesLoading,
                  selectedCategory: _selectedCategory,
                  onCategoryTap: (category) {
                    setState(() {
                      _selectedCategory = category;
                    });
                  },
                );
              },
            );
          },
        );
      },
    );
  }
}
