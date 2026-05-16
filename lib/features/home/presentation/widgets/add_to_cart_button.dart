import 'package:flutter/material.dart';

import '../../../../core/utils/constants.dart';
import '../../data/models/cart_item.dart';
import '../../data/models/product_model.dart';
import '../../services/add_to_cart_service.dart';

class AddToCartButton extends StatefulWidget {
  const AddToCartButton({
    super.key,
    required this.productModel,
    required this.addToCartService,
  });

  final ProductModel productModel;
  final AddToCartService addToCartService;

  @override
  State<AddToCartButton> createState() => _AddToCartButtonState();
}

class _AddToCartButtonState extends State<AddToCartButton> {
  bool isAddedToCart = false;

  void addToCart() {
    setState(() {
      isAddedToCart = true;
      // Assuming you have a default color or you can set it to the first color in the list
      String defaultColor = widget.productModel.colors!.isNotEmpty
          ? widget.productModel.colors![0]
          : '#FFFFFF'; // fallback color

      // create a new cart item
      CartItem cartItem = CartItem(
        product: widget.productModel,
        selectedColor: defaultColor,
        quantity: 1, // you can adjust the quantity as needed
      );
      // add the cart item to the cart
      widget.addToCartService.addToCart(cartItem);

      // show success state
      Future.delayed(
        const Duration(milliseconds: 500),
        () {
          if (mounted) {
            setState(() {
              // set isAddedToCart to false after a short delay to reset the state
              isAddedToCart = false;
            });
            // show snackbar
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  '${widget.productModel.name} added to cart',
                ),
                action: SnackBarAction(
                  label: 'UNDO',
                  onPressed: () {
                    setState(() {
                      widget.addToCartService.removeFromCart(
                        widget.productModel.id!,
                      );
                    });
                  },
                ),
              ),
            );
          }
        },
      );
    });
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
