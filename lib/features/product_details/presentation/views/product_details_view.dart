import 'package:flutter/material.dart';

import '../../../home/data/models/product_model.dart';
import '../widgets/product_details_widget.dart';
import '../widgets/product_image_gallery.dart';

class ProductDetailsView extends StatelessWidget {
  const ProductDetailsView({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Column(
        children: [
          ProductImageGallery(product: product),
          Expanded(
            child: ProductDetailsWidget(product: product),
          ),
        ],
      ),
    );
  }
}
