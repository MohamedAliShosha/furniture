import 'package:flutter/material.dart';

import '../../../../core/utils/app_texts.dart';
import '../../../../core/utils/constants.dart';
import 'category_chip.dart';

class CategoriesListView extends StatefulWidget {
  const CategoriesListView({super.key});

  @override
  State<CategoriesListView> createState() => _CategoriesListViewState();
}

class _CategoriesListViewState extends State<CategoriesListView> {
  String _selectedCategory = 'All'; // Default selected category

  // List that holds the categories
  final List<String> categories = [
    'All',
    'Chairs',
    'Tables',
    'Lightings',
    'Decorations',
    'SOFAS',
    'BEDS',
  ];

  // Function to handle category selection
  void _onCategorySelected(String category) {
    setState(() {
      _selectedCategory = category;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8, left: 16),
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
            itemCount: categories.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: CategoryChip(
                  title: categories[index],
                  isSelected: _selectedCategory == categories[index],
                  onTap: () => _onCategorySelected(categories[index]),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
