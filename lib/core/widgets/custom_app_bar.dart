import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:furniture/core/utils/app_colors.dart';
import 'package:furniture/core/utils/constants.dart';
import 'package:furniture/core/utils/app_router.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;

  const CustomAppBar({super.key, required this.title, this.actions});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      scrolledUnderElevation: 0,
      backgroundColor: AppColors.white,
      elevation: 0,
      leading: IconButton(
        onPressed: () {
          if (GoRouter.of(context).canPop()) {
            GoRouter.of(context).pop();
          } else {
            GoRouter.of(context).go(AppRouter.kMainView);
          }
        },
        icon: const Icon(Icons.arrow_back_ios),
      ),
      title: Text(title, style: AppConstants.titleStyle),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
