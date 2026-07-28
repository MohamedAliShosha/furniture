import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/utils/app_router.dart';
import '../../../../core/utils/app_texts.dart';
import '../../../home/presentation/cubit/user/user_cubit.dart';
import '../../../home/presentation/cubit/user/user_state.dart';
import 'auth_bottom_sheet.dart';
import 'logout_dialog.dart';
import 'menu_item_widget.dart';

Widget buildMenuSection(BuildContext context) {
  return Column(
    children: [
      buildMenuItem(
        context,
        icon: Icons.shopping_bag_outlined,
        title: AppTexts.myOrders,
        subtitle: AppTexts.myOrdersSubtitle,
        onTap: () {
          _handleAuthRequiredSection(
            context,
            message: AppTexts.signInToViewOrderHistory,
            onAction: () {
              // Navigate to the order history page
              GoRouter.of(context).push(AppRouter.kOrdersHistoryView);
            },
          );
        },
      ),
      buildMenuItem(
        context,
        icon: Icons.location_on_outlined,
        title: AppTexts.shippingAddress,
        subtitle: AppTexts.manageDeliveryAddresses,
        onTap: () {
          _handleAuthRequiredSection(
            context,
            message: AppTexts.signInToManageShippingAddresses,
            onAction: () {
              // Navigate to the shipping address management page
              GoRouter.of(context).push(AppRouter.kShippingAddressView);
            },
          );
        },
      ),
      buildMenuItem(
        context,
        icon: Icons.payment_outlined,
        title: AppTexts.paymentMethods,
        subtitle: AppTexts.manageYourPaymentOptions,
        onTap: () {
          _handleAuthRequiredSection(
            context,
            message: AppTexts.signInToManageYourPaymentMethods,
            onAction: () {
              // Navigate to the payment methods management page
            },
          );
        },
      ),
      buildMenuItem(
        context,
        icon: Icons.local_offer_outlined,
        title: AppTexts.promoCodes,
        subtitle: AppTexts.viewAvailableDiscounts,
        onTap: () {
          _handleAuthRequiredSection(
            context,
            message: AppTexts.signInToAccessAvailableDiscounts,
            onAction: () {
              // Navigate to the promo codes page
            },
          );
        },
      ),
      buildMenuItem(
        context,
        icon: Icons.notifications_outlined,
        title: AppTexts.notifications,
        subtitle: AppTexts.customizeNotificationSettings,
        onTap: () {
          _handleAuthRequiredSection(
            context,
            message: AppTexts.signInToCustomizeNotificationSettings,
            onAction: () {
              // Navigate to the notification settings page
            },
          );
        },
      ),
      buildMenuItem(
        context,
        icon: Icons.help_outline,
        title: AppTexts.helpCenter,
        subtitle: AppTexts.getHelpAndSupport,
        onTap: () {
          _handleAuthRequiredSection(
            context,
            message: AppTexts.signInToAccessHelpAndSupport,
            onAction: () {
              // Navigate to the help center page
            },
          );
        },
      ),
      buildMenuItem(
        context,
        icon: Icons.info_outline,
        title: AppTexts.aboutUs,
        subtitle: AppTexts.learnMoreAboutCompany,
        onTap: () {
          _handleAuthRequiredSection(
            context,
            message: AppTexts.signInToAccessHelpAndSupport,
            onAction: () {
              // Navigate to the about us page
            },
          );
        },
      ),
      BlocBuilder<UserCubit, UserState>(
        builder: (context, userState) {
          final isLoggedIn = userState is UserSuccess && userState.isLoggedIn;

          return buildMenuItem(
            context,
            icon: isLoggedIn ? Icons.logout : Icons.login,
            title: isLoggedIn ? AppTexts.signout : AppTexts.signIn,
            subtitle: isLoggedIn
                ? AppTexts.signoutOfYourAccount
                : AppTexts.signInToAccessAllFeatures,
            onTap: () {
              if (isLoggedIn) {
                _handleSignOut(context);
              } else {
                GoRouter.of(context).push(AppRouter.kLoginView);
              }
            },
            isSignOut: isLoggedIn,
          );
        },
      ),
    ],
  );
}

void _handleSignOut(BuildContext context) {
  final userState = context.read<UserCubit>().state;
  final isLoggedIn = userState is UserSuccess && userState.isLoggedIn;

  if (isLoggedIn) {
    LogoutDialog.show(context);
  } else {
    GoRouter.of(context).push(AppRouter.kLoginView);
  }
}

void _handleAuthRequiredSection(
  BuildContext context, {
  required String message,
  required VoidCallback onAction,
}) {
  final userState = context.read<UserCubit>().state;
  final isLoggedIn = userState is UserSuccess && userState.isLoggedIn;

  if (!isLoggedIn) {
    AuthBottomSheet.show(
      context,
      message: message,
      onContinueAsGuest: () {
        context.read<UserCubit>().continueAsGuest();
      },
    );
    return;
  }
  onAction();
}
