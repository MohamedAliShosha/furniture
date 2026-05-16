import 'package:flutter/material.dart';

import '../../services/wishlist_service.dart';

class FavoriteButton extends StatefulWidget {
  const FavoriteButton({
    super.key,
    required this.productId,
  });

  final String productId;

  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  bool isInWishList = false;
  final WishListService wishListService = WishListService();

  @override
  void initState() {
    super.initState();
    isInWishList = wishListService.isProductInWhishList(widget.productId);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 4,
          ),
        ],
      ),
      child: InkWell(
        onTap: () {
          setState(() {
            wishListService.toggleWhishList(widget.productId);
            isInWishList = !isInWishList;
          });
        },
        child: Icon(
          isInWishList ? Icons.favorite : Icons.favorite_border,
          color: isInWishList ? Colors.red : Colors.grey,
          size: 18,
        ),
      ),
    );
  }
}
