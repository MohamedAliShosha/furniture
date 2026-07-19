import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'categorized_products_bloc_builder.dart';

class CategoryViewBody extends StatelessWidget {
  const CategoryViewBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const CategorizedProductsBlocBuilder();
  }
}
