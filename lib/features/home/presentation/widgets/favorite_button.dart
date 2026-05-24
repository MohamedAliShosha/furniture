import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../wishlist/presentation/cubit/wishlist_cubit.dart';

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

  @override
  void initState() {
    super.initState();
    isInWishList =
        context.read<WishlistCubit>().isProductInWishlist(widget.productId);
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
            isInWishList = !isInWishList;
          });
          // Toggle wishlist through the cubit
          context.read<WishlistCubit>().toggleWishlistById(widget.productId);
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
