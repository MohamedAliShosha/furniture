import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/app_texts.dart';
import '../../../../core/widgets/custom_empty_state.dart';
import '../../../home/presentation/cubit/products_by_category/products_by_category_cubit.dart';
import '../../../home/presentation/cubit/products_by_category/products_by_category_state.dart';
import '../../../home/presentation/widgets/products_grid_view.dart';

class CategorizedProductsBlocBuilder extends StatelessWidget {
  const CategorizedProductsBlocBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsByCategoryCubit, ProductsByCategoryState>(
      builder: (context, state) {
        if (state is ProductsByCategoryLoading) {
          return const Center(
            child: CupertinoActivityIndicator(),
          );
        }

        if (state is ProductsByCategoryFailure) {
          return Center(
            child: Text(
              state.message,
              style: const TextStyle(
                color: Colors.red,
              ),
            ),
          );
        }
        final products =
            (state is ProductsByCategorySuccess) ? state.products : <dynamic>[];
        if (products.isEmpty) {
          return CustomEmptyState(
            message: AppTexts.noItemsFoundForThisCategory,
            icon: Icon(
              Icons.category_outlined,
              size: 64,
              color: Colors.grey[400],
            ),
          );
        }

        return ProductsGridView(products: products.cast());
      },
    );
  }
}
