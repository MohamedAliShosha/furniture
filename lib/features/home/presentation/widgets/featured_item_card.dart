import 'package:flutter/material.dart';
import '../../../../core/utils/constants.dart';
import '../../data/models/product_model.dart';
import '../../services/cart_service.dart';
import '../../services/special_offers_service.dart';
import '../../services/wishlist_service.dart';
import 'product_data_widget.dart';
import 'product_image.dart';

class FeaturedItemCard extends StatefulWidget {
  const FeaturedItemCard({super.key, this.onTap, required this.productModel});

  final ProductModel productModel;
  final VoidCallback? onTap;

  @override
  State<FeaturedItemCard> createState() => _FeaturedItemCardState();
}

class _FeaturedItemCardState extends State<FeaturedItemCard> {
  bool isAddedToCart = false;
  WishListService wishListService = WishListService();
  CartService addToCartService = CartService();
  SpecialOffersService specialOffersService = SpecialOffersService();

  @override
  Widget build(BuildContext context) {
    final bool isInWishList =
        wishListService.isProductInWhishList(widget.productModel.id);

    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(
            AppConstants.defaultBorderRadius,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            /// IMAGE
            ProductImage(
              productModel: widget.productModel,
            ),

            /// Data
            ProductDataWidget(
              widget: widget,
              addToCartService: addToCartService,
            ),
          ],
        ),
      ),
    );
  }
}
