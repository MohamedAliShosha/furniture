import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/app_texts.dart';
import '../../../../core/utils/constants.dart';
import '../../../special_offer/presentation/cubit/special_offer_cubit.dart';
import '../cubit/cart_cubit.dart';
import '../../../home/data/models/cart_item.dart';
import 'package:gap/gap.dart';

class CartItemCard extends StatelessWidget {
  const CartItemCard({super.key, required this.cartItem, this.onUndo});

  final CartItemModel cartItem;
  final Function(CartItemModel)? onUndo;

  @override
  Widget build(BuildContext context) {
    final specialOfferCubit = context.read<SpecialOfferCubit>();
    final discountedPrice =
        specialOfferCubit.getDiscountedPrice(cartItem.product);
    return Dismissible(
      key: Key(cartItem.product.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        color: Colors.red,
        child: const Icon(
          Icons.delete_outline,
          color: Colors.white,
        ),
      ),
      onDismissed: (direction) {
        context.read<CartCubit>().removeFromCart(cartItem.product.id);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Center(
              child: Text(
                '${cartItem.product.name} ${AppTexts.itemsRemovedFromCart}',
              ),
            ),
            action: SnackBarAction(
              label: AppTexts.undo,
              onPressed: () {
                if (onUndo != null) {
                  onUndo!(cartItem);
                }
              },
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(
          bottom: 16,
        ),
        padding: const EdgeInsets.all(
          12,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.05),
              blurRadius: 8,
              offset: const Offset(0, 4),
            )
          ],
        ),
        child: Row(
          children: [
            // product image
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: AssetImage(
                    cartItem.product.images.gallery.first,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const Gap(16),
            // product details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cartItem.product.name,
                    style: AppConstants.titleStyle.copyWith(
                      fontSize: 16,
                    ),
                  ),
                  const Gap(4),
                  Row(
                    children: [
                      Container(
                        width: 16,
                        height: 16,
                        decoration: BoxDecoration(
                          color: Color(
                            int.parse(
                              cartItem.selectedColor.replaceFirst('#', '0xFF'),
                            ),
                          ),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.grey[300]!,
                          ),
                        ),
                      ),
                      const Gap(8),
                      if (cartItem.product.hasSpecialOffer) ...[
                        Text(
                          '\$${cartItem.product.price.toStringAsFixed(2)}',
                          style: TextStyle(
                            color: Colors.grey[600],
                            decoration: TextDecoration.lineThrough,
                            fontSize: 12,
                          ),
                        ),
                        const Gap(4),
                        Text(
                          '\$${discountedPrice.toStringAsFixed(2)}',
                          style: const TextStyle(
                            color: AppConstants.primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ] else
                        Text(
                          '\$${cartItem.unitPrice.toStringAsFixed(2)}',
                          style: const TextStyle(
                            color: AppConstants.primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                    ],
                  ),
                  // Quantity control
                  Row(
                    children: [
                      buildQuantityButton(
                        context,
                        Icons.remove,
                        () {
                          if (cartItem.quantity > 1) {
                            context.read<CartCubit>().updateQuantity(
                                  cartItem.product.id,
                                  cartItem.quantity - 1,
                                );
                          }
                        },
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          '${cartItem.quantity}',
                          style: AppConstants.titleStyle.copyWith(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      buildQuantityButton(
                        context,
                        Icons.add,
                        () {
                          context.read<CartCubit>().updateQuantity(
                                cartItem.product.id,
                                cartItem.quantity + 1,
                              );
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildQuantityButton(
    BuildContext context,
    IconData icon,
    VoidCallback onPressed,
  ) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(8),
          child: Icon(
            icon,
            size: 18,
            color: Colors.black87,
          ),
        ),
      ),
    );
  }
}
