import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../wishlist/presentation/cubit/wishlist_cubit.dart';
import '../../../wishlist/presentation/cubit/wishlist_state.dart';

class FavButtonBlocBuilder extends StatelessWidget {
  const FavButtonBlocBuilder({
    super.key,
    required this.productId,
  });

  final String productId;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WishlistCubit, WishlistState>(
      builder: (context, state) {
        final isInWishlist =
            context.read<WishlistCubit>().isProductInWishlist(productId);

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
              // Toggle wishlist through the cubit
              context.read<WishlistCubit>().toggleWishlistById(productId);
            },
            child: Icon(
              isInWishlist ? Icons.favorite : Icons.favorite_border,
              color: isInWishlist ? Colors.red : Colors.grey,
              size: 18,
            ),
          ),
        );
      },
    );
  }
}
