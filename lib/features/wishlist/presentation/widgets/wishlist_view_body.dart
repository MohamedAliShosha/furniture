import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/utils/app_router.dart';
import '../../../../core/utils/app_texts.dart';
import '../../../../core/utils/constants.dart';
import '../../../home/presentation/cubit/user/user_cubit.dart';
import '../../../home/presentation/cubit/user/user_state.dart';
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
  bool _userInitialized = false;

  @override
  void initState() {
    super.initState();
    // Initialize user cubit using microtask to ensure context is ready
    Future.microtask(() {
      if (mounted) {
        context.read<UserCubit>().initializeUser();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserCubit, UserState>(
      listener: (context, userState) {
        // Fetch wishlist when user logs in
        if (userState is UserSuccess &&
            userState.isLoggedIn &&
            !_userInitialized) {
          _userInitialized = true;
          context.read<WishlistCubit>().fetchWishlist();
        }
      },
      child: BlocBuilder<UserCubit, UserState>(
        builder: (context, userState) {
          final isLoggedIn = userState is UserSuccess && userState.isLoggedIn;

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
                      AppTexts.wishlistTitle,
                      style: AppConstants.headingStyle,
                    ),
                    if (isLoggedIn)
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
                                      AppTexts.cancelButtonTitle,
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      context
                                          .read<WishlistCubit>()
                                          .clearWishlist();
                                      Navigator.pop(context);
                                    },
                                    child: const Text(
                                      AppTexts.clearButtonTitle,
                                    ),
                                  ),
                                ],
                                content: const Text(
                                  AppTexts.clearWishlistConfirmation,
                                ),
                                title: const Text(
                                  AppTexts.clearWishlistTitle,
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
                child: !isLoggedIn
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
                              AppTexts.signInToViewWishlist,
                              style: AppConstants.titleStyle.copyWith(
                                color: Colors.grey[600],
                              ),
                            ),
                            const Gap(8),
                            Text(
                              AppTexts.createAccountToShop,
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
                                AppTexts.signInButtonTitle,
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
        },
      ),
    );
  }
}
