import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../data/repositories/product_repo.dart';
import '../cubit/all_products/all_products_state.dart';
import '../cubit/featured_items/featured_items_cubit.dart';
import '../cubit/all_products/all_products_cubit.dart';
import '../cubit/featured_items/featured_items_state.dart';
import '../cubit/products_by_category/products_by_category_cubit.dart';
import '../widgets/home_view_body.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 0,
        elevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
        ),
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => FeaturedItemsCubit(GetIt.instance<ProductRepo>())
              ..fetchFeaturedItems(),
          ),
          BlocProvider(
            create: (_) => AllProductsCubit(GetIt.instance<ProductRepo>())
              ..fetchAllProducts(),
          ),
          BlocProvider(
            create: (_) =>
                ProductsByCategoryCubit(GetIt.instance<ProductRepo>()),
          ),
        ],
        child: const _HomeView(),
      ),
    );
  }
}

class _HomeView extends StatelessWidget {
  const _HomeView();

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
          return HomeViewBody(
            featuredProducts: const [],
            allProducts: const [],
          ); // Initial state
        }
      },
    );
  }
}
