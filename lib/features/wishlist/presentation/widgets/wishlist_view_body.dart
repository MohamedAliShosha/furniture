import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/utils/app_router.dart';
import '../../../../core/utils/constants.dart';
import '../../../home/services/user_service.dart';
import '../cubit/wishlist_cubit.dart';
import 'wishlist_items_bloc_builder.dart';

class WishListViewBody extends StatefulWidget {
  const WishListViewBody({
    super.key,
  });

  @override
  State<WishListViewBody> createState() => _WishListViewBodyState();
}

class _WishListViewBodyState extends State<WishListViewBody> {
  @override
  void initState() {
    super.initState();
    if (isLoggedInUser) {
      context.read<WishlistCubit>().fetchWishlist();
    }
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
                'Wishlist',
                style: AppConstants.headingStyle,
              ),
              if (isLoggedInUser)
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
                                context.read<WishlistCubit>().clearWishlist();
                                Navigator.pop(context);
                              },
                              child: const Text(
                                'CLEAR',
                              ),
                            ),
                          ],
                          content: const Text(
                            'Are you sure you want to clear your wishlist?',
                          ),
                          title: const Text(
                            'Clear Wishlist',
                          ),
                        );
                      },
                    );
                  },
                  icon: const Icon(
                    Icons.delete_outline,
                  ),
                ),
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
                        Icons.favorite_border,
                        color: Colors.grey[400],
                        size: 80,
                      ),
                      const Gap(16),
                      Text(
                        'Sign in to view your wishlist',
                        style: AppConstants.titleStyle.copyWith(
                          color: Colors.grey[600],
                        ),
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
              : const WisListItemsBloBuilder(),
        )
      ],
    );
  }
}
