import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../cart/presentation/cubit/cart_cubit.dart';
import '../../../home/data/models/cart_item.dart';
import '../../../home/data/models/product_model.dart';
import '../../../home/presentation/cubit/user/user_cubit.dart';
import '../../../profile/presentation/widgets/auth_bottom_sheet.dart';

class AddToCartButton extends StatefulWidget {
  const AddToCartButton({
    super.key,
    required this.product,
    required this.selectedColor,
  });

  final ProductModel product;
  final String? selectedColor;

  @override
  State<AddToCartButton> createState() => _AddToCartButtonState();
}

class _AddToCartButtonState extends State<AddToCartButton> {
  bool _isAddedToCart = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: _isAddedToCart || widget.selectedColor == null
            ? null
            : () {
                final userCubit = context.read<UserCubit>();
                if (!userCubit.userService.isUserLoggedIn) {
                  AuthBottomSheet.show(
                    context,
                    message: 'Please log in to add items to your cart.',
                  );
                  return;
                }

                setState(() {
                  _isAddedToCart = true;
                });

                final cartItem = CartItemModel(
                  selectedColor: widget.selectedColor!,
                  product: widget.product,
                  quantity: 1,
                );

                final messenger = ScaffoldMessenger.of(context);
                final cartCubit = context.read<CartCubit>();

                cartCubit.addToCart(cartItem);
                Future.delayed(const Duration(milliseconds: 500), () {
                  if (!mounted) return;
                  setState(() {
                    _isAddedToCart = false;
                  });
                  messenger.showSnackBar(
                    SnackBar(
                      content: Text(
                        '${widget.product.name} added to cart!',
                      ),
                      action: SnackBarAction(
                        label: 'UNDO',
                        onPressed: () {
                          cartCubit.removeFromCart(widget.product.id);
                        },
                      ),
                    ),
                  );
                });
              },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: _isAddedToCart
            ? const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.white),
                  strokeWidth: 2,
                ),
              )
            : const Text(
                'Add to Cart',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.white,
                ),
              ),
      ),
    );
  }
}
