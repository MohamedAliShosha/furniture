import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furniture/features/home/services/user_service.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/utils/app_router.dart';
import '../../../../core/utils/constants.dart';
import '../cubit/cart_cubit.dart';
import '../cubit/cart_state.dart';
import 'cart_item_card.dart';
import 'cart_total_items_price.dart';
import 'empty_cart_widget.dart';

class CartViewBody extends StatefulWidget {
  const CartViewBody({super.key});

  @override
  State<CartViewBody> createState() => _CartViewBodyState();
}

class _CartViewBodyState extends State<CartViewBody> {
  @override
  void initState() {
    super.initState();
    context.read<CartCubit>().fetchCart();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Gap(16),
        Container(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top,
            left: AppConstants.defaultPadding,
            right: AppConstants.defaultPadding,
            bottom: AppConstants.defaultPadding,
          ),
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Shopping Cart',
                style: AppConstants.headingStyle,
              ),
              IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              'CANCEL',
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              context.read<CartCubit>().clearCart();
                              Navigator.pop(context);
                            },
                            child: const Text(
                              'CLEAR',
                            ),
                          ),
                        ],
                        content: const Text(
                          'Are you sure you want to clear your cart?',
                        ),
                        title: const Text(
                          'Clear Cart',
                        ),
                      );
                    },
                  );
                },
                icon: const Icon(
                  Icons.delete_outline,
                ),
              )
            ],
          ),
        ),
        Expanded(
          child: !isLoggedInUser
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.shopping_cart_outlined,
                        color: Colors.grey[400],
                        size: 80,
                      ),
                      const Gap(16),
                      Text(
                        'Sign in to view your cart',
                        style: AppConstants.titleStyle
                            .copyWith(color: Colors.grey[600]),
                      ),
                      const Gap(8),
                      Text(
                        'Create an account to start shopping',
                        style: AppConstants.bodyStyle.copyWith(
                          color: Colors.grey,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const Gap(24),
                      ElevatedButton(
                        onPressed: () {
                          GoRouter.of(context).push(
                            AppRouter.kLoginView,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppConstants.primaryColor,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 32,
                            vertical: 12,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'SIGN IN',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : BlocBuilder<CartCubit, CartState>(
                  builder: (context, state) {
                    if (state is CartLoading) {
                      return const Center(
                        child: CupertinoActivityIndicator(),
                      );
                    } else if (state is CartFailure) {
                      return Center(
                        child: Text('Error: ${state.message}'),
                      );
                    } else if (state is CartSuccess) {
                      if (state.cartItems.isEmpty) {
                        return const EmptyCartWidget();
                      }
                      return ListView.builder(
                        padding: const EdgeInsets.all(
                          AppConstants.defaultPadding,
                        ),
                        itemCount: state.cartItems.length,
                        itemBuilder: (context, index) {
                          final cartItem = state.cartItems[index];
                          return CartItemCard(
                            cartItem: cartItem,
                            onUndo: (cartItem) {
                              context.read<CartCubit>().addToCart(cartItem);
                            },
                          );
                        },
                      );
                    }
                    return const EmptyCartWidget();
                  },
                ),
        ),
        BlocBuilder<CartCubit, CartState>(
          builder: (context, state) {
            /*
            Changed CartViewBody to use BlocBuilder<CartCubit, CartState> 
            around CartTotalItemsPrice
            The total now recalculates dynamically from state.cartItems.fold() 
            based on each item's totalPrice
            When quantity changes, the cart state updates → 
            BlocBuilder rebuilds → total price updates automatically
            */

            if (state is CartSuccess) {
              final total = state.cartItems.fold<double>(
                0,
                (sum, item) => sum + item.totalPrice,
              );
              return CartTotalItemsPrice(
                cartItems: state.cartItems,
                total: total,
              );
            }
            // Return empty total widget if not success state
            return const CartTotalItemsPrice(
              cartItems: [],
              total: 0,
            );
          },
        ),
      ],
    );
  }
}
