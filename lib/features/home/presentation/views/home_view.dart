import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/service_locator.dart';

import '../cubit/featured_items/featured_items_cubit.dart';
import '../cubit/all_products/all_products_cubit.dart';
import '../cubit/products_by_category/products_by_category_cubit.dart';
import '../cubit/categories/categories_cubit.dart';
import '../widgets/home_view_content.dart';

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
            create: (_) => getIt<FeaturedItemsCubit>()..fetchFeaturedItems(),
          ),
          BlocProvider(
            create: (_) => getIt<AllProductsCubit>()..fetchAllProducts(),
          ),
          BlocProvider(
            create: (_) => getIt<ProductsByCategoryCubit>(),
          ),
          BlocProvider(
            create: (_) => getIt<CategoriesCubit>()..fetchCategories(),
          ),
        ],
        child: const HomeViewContent(),
      ),
    );
  }
}
