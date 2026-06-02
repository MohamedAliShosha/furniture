import 'package:flutter/material.dart';

import 'fav_button_bloc_builder.dart';

class FavoriteButton extends StatelessWidget {
  const FavoriteButton({
    super.key,
    required this.productId,
  });

  final String productId;

  @override
  Widget build(BuildContext context) {
    return FavButtonBlocBuilder(
      productId: productId,
    );
  }
}
