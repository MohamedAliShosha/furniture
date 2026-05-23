import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furniture/features/cart/presentation/cubit/cart_cubit.dart';

import '../../../../core/utils/constants.dart';
import '../../data/models/cart_item.dart';
import '../../data/models/product_model.dart';

class AddToCartButton extends StatefulWidget {
  const AddToCartButton({
    super.key,
    required this.productModel,
  });

  final ProductModel productModel;

  @override
  State<AddToCartButton> createState() => _AddToCartButtonState();
}

class _AddToCartButtonState extends State<AddToCartButton> {
  bool isAddedToCart = false;

  void addToCart() {
    setState(() {
      isAddedToCart = true;
    });

    String defaultColor = widget.productModel.colors!.isNotEmpty
        ? widget.productModel.colors![0]
        : '#FFFFFF';

    CartItemModel cartItem = CartItemModel(
      product: widget.productModel,
      selectedColor: defaultColor,
      quantity: 1,
    );

    context.read<CartCubit>().addToCart(cartItem);

    Future.delayed(
      const Duration(milliseconds: 500),
      () {
        if (mounted) {
          setState(() {
            isAddedToCart = false;
          });

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                '${widget.productModel.name} added to cart',
              ),
              action: SnackBarAction(
                label: 'UNDO',
                onPressed: () {
                  context.read<CartCubit>().removeFromCart(
                        widget.productModel.id,
                      );
                },
              ),
            ),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36,
      width: 36,
      decoration: BoxDecoration(
        color: isAddedToCart ? Colors.green : AppConstants.primaryColor,
        borderRadius: BorderRadius.circular(AppConstants.smallBorderRadius),
      ),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: isAddedToCart ? null : addToCart,
          borderRadius: BorderRadius.circular(AppConstants.smallBorderRadius),
          child: Center(
            child: Icon(
              isAddedToCart ? Icons.check : Icons.add_shopping_cart_outlined,
              color: Colors.white,
              size: 20,
            ),
          ),
        ),
      ),
    );
  }
}
