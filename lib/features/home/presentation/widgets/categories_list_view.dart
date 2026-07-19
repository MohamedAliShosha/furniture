import 'package:flutter/material.dart';

import '../../../../core/utils/app_texts.dart';
import '../../../../core/utils/constants.dart';
import '../../../../features/home/data/models/category_model.dart';
import 'category_chip.dart';

class CategoriesListView extends StatelessWidget {
  final List<dynamic> categories;
  final ValueChanged<String>? onCategoryTap;
  final String selectedCategory;

  const CategoriesListView({
    super.key,
    required this.categories,
    this.onCategoryTap,
    this.selectedCategory = AppTexts.allCategory,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 16, left: 16),
          child: Text(
            AppTexts.categories,
            style: AppConstants.titleStyle.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        SizedBox(
          height: 45,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            itemCount: categories.length + 1,
            itemBuilder: (context, index) {
              if (index == 0) {
                const title = AppTexts.allCategory;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: CategoryChip(
                    title: title,
                    isSelected: selectedCategory == title,
                    onTap: () => onCategoryTap?.call(title),
                  ),
                );
              }
              final category = categories[index - 1] as CategoryModel;
              final title = category.name;
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: CategoryChip(
                  title: title,
                  isSelected: selectedCategory == title,
                  onTap: () => onCategoryTap?.call(title),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
