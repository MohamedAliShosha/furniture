import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furniture/features/home/data/models/product_model.dart';
import 'package:furniture/features/profile/presentation/widgets/auth_bottom_sheet.dart';
import 'package:furniture/features/wishlist/presentation/cubit/wishlist_cubit.dart';
import 'package:furniture/features/wishlist/presentation/cubit/wishlist_state.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../home/presentation/cubit/user/user_cubit.dart';
import '../widgets/circular_icon_button.dart';

class ProductImageGallery extends StatefulWidget {
  const ProductImageGallery({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  State<ProductImageGallery> createState() => _ProductImageGalleryState();
}

class _ProductImageGalleryState extends State<ProductImageGallery> {
  late final PageController _pageController;
  int _currentImageIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final imageHeight = screenHeight * 0.45;
    final topPadding = MediaQuery.of(context).padding.top;

    return SizedBox(
      height: imageHeight + topPadding,
      child: Stack(
        children: [
          Positioned.fill(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentImageIndex = index;
                });
              },
              itemCount: widget.product.images.gallery.length,
              itemBuilder: (context, index) {
                return Container(
                  color: Colors.white,
                  child: Image.asset(
                    widget.product.images.gallery[index],
                    fit: BoxFit.contain,
                  ),
                );
              },
            ),
          ),
          Positioned(
            top: topPadding + 16,
            left: 16,
            right: 16,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircularIconButton(
                  iconData: Icons.arrow_back,
                  onTap: () => Navigator.of(context).pop(),
                  iconColor: Colors.black,
                ),
                BlocBuilder<WishlistCubit, WishlistState>(
                  builder: (context, state) {
                    final isInWishlist = state is WishlistSuccess &&
                        state.wishListedItems
                            .any((item) => item.id == widget.product.id);
                    return CircularIconButton(
                      iconData: isInWishlist
                          ? Icons.favorite
                          : Icons.favorite_border,
                      onTap: () {
                        final userCubit = context.read<UserCubit>();
                        if (!userCubit.userService.isUserLoggedIn) {
                          AuthBottomSheet.show(
                            context,
                            message:
                                'Please log in to add items to your wishlist.',
                          );
                          return;
                        }
                        context
                            .read<WishlistCubit>()
                            .toggleWishlistById(widget.product.id);
                      },
                      iconColor: isInWishlist ? Colors.red : null,
                    );
                  },
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 24,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                widget.product.images.gallery.length,
                (index) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: _currentImageIndex == index ? 12 : 8,
                  height: _currentImageIndex == index ? 12 : 8,
                  decoration: BoxDecoration(
                    color: _currentImageIndex == index
                        ? AppColors.primary
                        : Colors.grey[300],
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
