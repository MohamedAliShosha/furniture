import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furniture/core/utils/constants.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/utils/app_router.dart';
import '../../../home/data/models/product_model.dart';
import '../../../home/presentation/cubit/all_products/all_products_cubit.dart';
import '../../../home/presentation/cubit/all_products/all_products_state.dart';
import '../../../home/presentation/widgets/animated_list_item.dart';
import '../../../home/presentation/widgets/featured_item_card.dart';
import 'suggested_search_widget.dart';

class SearchViewBody extends StatelessWidget {
  const SearchViewBody({
    super.key,
    required TextEditingController searchController,
  }) : _searchController = searchController;

  final TextEditingController _searchController;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<TextEditingValue>(
        valueListenable: _searchController,
        builder: (context, value, child) {
          return BlocBuilder<AllProductsCubit, AllProductsState>(
            builder: (context, state) {
              final allProducts = state is AllProductsSuccess
                  ? state.products
                  : <ProductModel>[];
              log('All products: ${allProducts.length}');

              final query = _searchController.text.trim().toLowerCase();
              log('Search query: $query');
              final searchResults = query.isEmpty
                  ? <ProductModel>[]
                  : allProducts
                      .where((product) =>
                          product.name.toLowerCase().contains(query))
                      .toList();
              log('Search results: ${searchResults.length}');

              if (_searchController.text.isEmpty) {
                return SuggestedSearchWidget(
                  searchController: _searchController,
                );
              }
              if (searchResults.isEmpty) {
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
                        AppTexts.noItemsFound,
                        style: AppConstants.titleStyle.copyWith(
                          color: Colors.grey[600],
                          fontSize: 18,
                        ),
                      ),
                      const Gap(8),
                      Text(
                        AppTexts.trySearchWithDifferentKeywords,
                        style: AppConstants.bodyStyle.copyWith(
                          color: Colors.grey[500],
                        ),
                      ),
                    ],
                  ),
                );
              }
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: .65,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                ),
                padding: const EdgeInsets.all(
                  AppConstants.defaultPadding,
                ),
                itemCount: searchResults.length,
                itemBuilder: (context, index) {
                  final product = searchResults[index];
                  return AnimatedListItem(
                    isVertical: false,
                    index: index,
                    child: Hero(
                      tag: 'search ${product.id}',
                      child: FeaturedItemCard(
                        onTap: () {
                          GoRouter.of(context).push(
                            AppRouter.kProductDetailsView,
                            extra: product,
                          );
                        },
                        productModel: product,
                      ),
                    ),
                  );
                },
              );
            },
          );
        });
  }
}
