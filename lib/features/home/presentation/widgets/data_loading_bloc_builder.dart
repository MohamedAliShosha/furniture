import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furniture/core/utils/app_router.dart';
import 'package:furniture/core/utils/app_texts.dart';
import 'package:go_router/go_router.dart';
import '../cubit/all_products/all_products_state.dart';
import '../cubit/all_products/all_products_cubit.dart';
import '../cubit/featured_items/featured_items_cubit.dart';
import '../cubit/featured_items/featured_items_state.dart';
import '../cubit/categories/categories_cubit.dart';
import '../cubit/categories/categories_state.dart';
import '../cubit/products_by_category/products_by_category_cubit.dart';
import '../cubit/products_by_category/products_by_category_state.dart';
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
                return BlocBuilder<ProductsByCategoryCubit,
                    ProductsByCategoryState>(
                  builder: (context, productsByCategoryState) {
                    final featuredProducts =
                        (featuredState is FeaturedItemsSuccess)
                            ? featuredState.products
                            : <dynamic>[];
                    final allProducts = (allProductsState is AllProductsSuccess)
                        ? allProductsState.products
                        : <dynamic>[];
                    final categories = (categoriesState is CategoriesSuccess)
                        ? categoriesState.categories
                        : <dynamic>[];
                    final isFeaturedLoading =
                        featuredState is FeaturedItemsLoading;
                    final isAllProductsLoading =
                        allProductsState is AllProductsLoading;
                    final isCategoriesLoading =
                        categoriesState is CategoriesLoading;
                    final productsByCategory =
                        (productsByCategoryState is ProductsByCategorySuccess)
                            ? productsByCategoryState.products
                            : <dynamic>[];
                    final isProductsByCategoryLoading =
                        productsByCategoryState is ProductsByCategoryLoading;

                    return HomeViewBody(
                      featuredProducts: featuredProducts,
                      allProducts: allProducts,
                      categories: categories,
                      isFeaturedLoading: isFeaturedLoading,
                      isAllProductsLoading: isAllProductsLoading,
                      isCategoriesLoading: isCategoriesLoading,
                      productsByCategory: productsByCategory,
                      isProductsByCategoryLoading: isProductsByCategoryLoading,
                      selectedCategory: _selectedCategory,
                      onCategoryTap: (category) {
                        if (category == AppTexts.allCategory) {
                          context
                              .read<ProductsByCategoryCubit>()
                              .fetchProductsByCategory(AppTexts.allCategory);
                        } else {
                          context
                              .read<ProductsByCategoryCubit>()
                              .fetchProductsByCategory(category);
                          GoRouter.of(context).push(
                            AppRouter.kCategoryView,
                            extra: category,
                          );
                        }
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
      },
    );
  }
}
