import 'package:flutter/material.dart';
import 'featured_products_bloc_builder.dart';

class FeaturedProductViewBody extends StatelessWidget {
  const FeaturedProductViewBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const FeaturedProductsBlocBuilder();
  }
}
