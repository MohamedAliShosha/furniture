import 'package:flutter/material.dart';
import '../../data/models/product_model.dart';
import '../widgets/all_products_grid_view.dart';
import '../widgets/categories_list_view.dart';
import '../widgets/featured_items_list_view.dart';
import '../widgets/home_header.dart';
import '../widgets/offers_page_view.dart';

class HomeViewBody extends StatelessWidget {
  final List<ProductModel> featuredProducts;
  final List<ProductModel> allProducts;

  const HomeViewBody({
    super.key,
    required this.featuredProducts,
    required this.allProducts,
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
              FeaturedItemsListView(products: featuredProducts),
              const SizedBox(height: 24),
            ],
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          sliver: AllProductsGridView(products: allProducts),
        ),
      ],
    );
  }
}
