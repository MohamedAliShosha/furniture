import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/utils/app_router.dart';
import '../../../../core/utils/app_texts.dart';
import '../cubit/home_cubit.dart';
import '../cubit/home_state.dart';
import '../widgets/all_products_grid_view.dart';
import '../widgets/categories_list_view.dart';
import '../widgets/custom_search_bar.dart';
import '../widgets/featured_items_list_view.dart';
import '../widgets/home_header.dart';
import '../widgets/offers_page_view.dart';

class HomeViewBlocBuilder extends StatefulWidget {
  const HomeViewBlocBuilder({super.key});

  @override
  State<HomeViewBlocBuilder> createState() => _HomeViewBlocBuilderState();
}

class _HomeViewBlocBuilderState extends State<HomeViewBlocBuilder> {
  String _selectedCategory = AppTexts.allCategory;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is HomeSuccess) {
          final featuredProducts = state.featuredProducts;
          final allProducts = state.allProducts;
          final categories = state.categories;
          final productsByCategory = state.productsByCategory;

          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    const HomeHeader(),
                    const Gap(8),
                    const CustomSearchBar(),
                    const Gap(8),
                    CategoriesListView(
                      categories: categories,
                      onCategoryTap: (category) {
                        if (category == AppTexts.allCategory) {
                          context.read<HomeCubit>().fetchAllHomeData();
                        } else {
                          context.read<HomeCubit>().fetchAllHomeData(category: category);
                          GoRouter.of(context).push(
                            AppRouter.kCategoryView,
                            extra: category,
                          );
                        }
                        setState(() {
                          _selectedCategory = category;
                        });
                      },
                      selectedCategory: _selectedCategory,
                    ),
                    const Gap(24),
                    const OffersPageView(),
                    FeaturedItemsListView(
                      products: featuredProducts,
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                sliver: _selectedCategory == AppTexts.allCategory
                    ? AllProductsGridView(
                        products: allProducts,
                      )
                    : AllProductsGridView(
                        products: productsByCategory,
                      ),
              ),
            ],
          );
        }

        if (state is HomeFailure) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, size: 48, color: Colors.red),
                const SizedBox(height: 16),
                Text(
                  AppTexts.somethingWentWrong,
                  style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => context.read<HomeCubit>().fetchAllHomeData(),
                  child: const Text(AppTexts.retry),
                ),
              ],
            ),
          );
        }

        return const Center(
          child: CupertinoActivityIndicator(),
        );
      },
    );
  }
}
