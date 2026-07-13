import 'package:flutter/material.dart';
import '../../../home/data/models/product_model.dart';

class ProductDetailsView extends StatefulWidget {
  const ProductDetailsView({super.key, required this.product});

  final ProductModel product;

  @override
  State<ProductDetailsView> createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<ProductDetailsView>
    with SingleTickerProviderStateMixin {
  final PageController _pageController =
      PageController(); // Controller for the PageView
  int _currentImageIndex = 0; // Track the current image index
  late AnimationController _animationController; // Controller for the animation
  late Animation<double>
      _contentAnimation; // Animation for the image transition

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _contentAnimation = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(
          0.0,
          1.0,
          curve: Curves.easeOut,
        ),
      ),
    );
    _animationController.forward();
    super.initState();
  }

  @override
  dispose() {
    _animationController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    final imageHeight = screenHeight * 0.45; // 45% of the screen height
    final topPadding =
        MediaQuery.of(context).padding.top; // Get the top padding
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: const Column(
        children: [
          // top section with images
        ],
      ),
    );
  }
}
