import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../widgets/all_products_grid_view.dart';
import '../widgets/categories_list_view.dart';
import '../widgets/featured_items_list_view.dart';
import '../widgets/home_header.dart';
import '../widgets/offers_page_view.dart';

class HomeViewBody extends StatelessWidget {
  final List<dynamic> featuredProducts;
  final List<dynamic> allProducts;
  final bool isFeaturedLoading;
  final bool isAllProductsLoading;

  const HomeViewBody({
    super.key,
    required this.featuredProducts,
    required this.allProducts,
    this.isFeaturedLoading = false,
    this.isAllProductsLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            children: [
              const HomeHeader(),
              const SizedBox(height: 8),
              const CategoriesListView(),
              const SizedBox(height: 24),
              const OffersPageView(),
              // Featured items with loading indicator
              isFeaturedLoading
                  ? const SizedBox(
                      height: 200,
                      child: Center(
                        child: CupertinoActivityIndicator(),
                      ),
                    )
                  : FeaturedItemsListView(
                      products: featuredProducts.cast(),
                    ),
              const SizedBox(height: 24),
            ],
          ),
        ),
        // All products with loading indicator
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          sliver: isAllProductsLoading
              ? const SliverToBoxAdapter(
                  child: SizedBox(
                    height: 400,
                    child: Center(
                      child: CupertinoActivityIndicator(),
                    ),
                  ),
                )
              : AllProductsGridView(
                  products: allProducts.cast(),
                ),
        ),
      ],
    );
  }
}
