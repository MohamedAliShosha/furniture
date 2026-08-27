import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import '../../../../core/utils/app_images.dart';
import '../../../../core/utils/app_texts.dart';
import '../../../../core/utils/constants.dart';
import '../../../cart/presentation/cubit/cart_cubit.dart';
import '../../../cart/presentation/cubit/cart_state.dart';
import '../../../orders/presentation/cubit/orders_cubit.dart';
import '../../../orders/presentation/cubit/orders_state.dart';
import '../../../wishlist/presentation/cubit/wishlist_cubit.dart';
import '../../../wishlist/presentation/cubit/wishlist_state.dart';
import 'user_info_bloc_builder.dart';

class ProfileInfo extends StatelessWidget {
  const ProfileInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(horizontal: AppConstants.defaultPadding),
      child: Column(
        children: [
          Stack(
            children: [
              const CircleAvatar(
                radius: 50,
                backgroundColor: Colors.grey,
                backgroundImage: AssetImage(AppImages.profileImage),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: GestureDetector(
                  onTap: () {
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                      color: AppConstants.primaryColor,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.edit,
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
                ),
              )
            ],
          ),
          const Gap(16),
          const UserInfoBlocBuilder(),
          const Gap(24),
          BlocBuilder<CartCubit, CartState>(
            builder: (context, cartState) {
              return BlocBuilder<WishlistCubit, WishlistState>(
                builder: (context, wishlistState) {
                  return BlocBuilder<OrdersCubit, OrdersState>(
                    builder: (context, ordersState) {
                      final cartCount = cartState is CartSuccess
                          ? cartState.cartItems.length
                          : context.read<CartCubit>().getCartItems().length;

                      final wishlistCount = wishlistState is WishlistSuccess
                          ? wishlistState.wishListedItems.length
                          : context.read<WishlistCubit>().wishlistCount;

                      final ordersCount = ordersState is OrderSuccess
                          ? ordersState.orders.where((order) => order.isCompleted).length
                          : 0;

                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildStateItem(
                            AppTexts.ordersLabel,
                            ordersCount.toString(),
                          ),
                          _buildStateItem(
                            AppTexts.cartLabel,
                            cartCount.toString(),
                          ),
                          _buildStateItem(
                            AppTexts.wishlistLabel,
                            wishlistCount.toString(),
                          ),
                        ],
                      );
                    },
                  );
                },
              );
            },
          )
        ],
      ),
    );
  }

  Widget _buildStateItem(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: AppConstants.headingStyle.copyWith(
            fontSize: 20,
            color: AppConstants.primaryColor,
          ),
        ),
        const Gap(4),
        Text(
          label,
          style: AppConstants.bodyStyle.copyWith(color: Colors.grey),
        ),
      ],
    );
  }
}
