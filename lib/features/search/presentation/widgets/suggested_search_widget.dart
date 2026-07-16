import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furniture/features/home/services/get_all_products_service.dart';
import 'package:gap/gap.dart';

import '../../../../core/utils/app_texts.dart';
import '../../../../core/utils/constants.dart';
import '../../../home/presentation/cubit/categories/categories_cubit.dart';
import '../../../home/presentation/cubit/categories/categories_state.dart';
import 'search_category_chip.dart';

class SuggestedSearchWidget extends StatelessWidget {
  const SuggestedSearchWidget({super.key, required this.searchController});

  final TextEditingController searchController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriesCubit, CategoriesState>(
      builder: (context, state) {
        final categories =
            state is CategoriesSuccess ? state.categories : <dynamic>[];

        return Padding(
          padding: const EdgeInsets.all(
            AppConstants.defaultPadding,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppTexts.popularCategories,
                style: AppConstants.headingStyle.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Gap(16),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: categories.map((category) {
                  final categoryName = category.name;
                  return SearchCategoryChip(
                    label: categoryName,
                    icon: _getCategoryIcon(categoryName),
                    onTap: () {
                      searchController.text = categoryName;
                    },
                  );
                }).toList(),
              ),
              const Gap(32),
              Text(
                AppTexts.popularSearches,
                style: AppConstants.headingStyle.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Gap(16),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  AppTexts.modernChair,
                  AppTexts.sofaSet,
                  AppTexts.diningTable,
                  AppTexts.bed,
                  AppTexts.storage,
                  AppTexts.officeChair,
                  AppTexts.tvCabinet,
                  AppTexts.coffeeTable,
                ].map((term) {
                  return SearchCategoryChip(
                    label: term,
                    icon: _getSearchTermIcon(term),
                    onTap: () {
                      searchController.text = term;
                      AllProductsService().setSearchQuery(term);
                    },
                  );
                }).toList(),
              )
            ],
          ),
        );
      },
    );
  }

  IconData _getCategoryIcon(String category) {
    switch (category.toLowerCase()) {
      case 'all':
        return Icons.grid_view_rounded;
      case 'chairs':
        return Icons.chair_rounded;
      case 'tables':
        return Icons.table_restaurant_rounded;
      case 'lights':
        return Icons.light_rounded;
      case 'decorations':
        return Icons.deblur_rounded;
      case 'sofas':
        return Icons.weekend_rounded;
      case 'beds':
        return Icons.bed_rounded;
      default:
        return Icons.category_rounded;
    }
  }

  IconData _getSearchTermIcon(String term) {
    if (term.toLowerCase().contains('chairs')) {
      return Icons.chair_rounded;
    } else if (term.toLowerCase().contains('sofa')) {
      return Icons.weekend_rounded;
    } else if (term.toLowerCase().contains('table')) {
      return Icons.table_restaurant_rounded;
    } else if (term.toLowerCase().contains('bed')) {
      return Icons.bed_rounded;
    } else if (term.toLowerCase().contains('storage') ||
        term.toLowerCase().contains('cabinet')) {
      return Icons.kitchen_rounded;
    } else if (term.toLowerCase().contains('tv')) {
      return Icons.tv_rounded;
    } else if (term.toLowerCase().contains('coffee')) {
      return Icons.coffee_rounded;
    } else {
      return Icons.search_rounded;
    }
  }
}
