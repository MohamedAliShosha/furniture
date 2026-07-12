import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_texts.dart';
import '../../../../core/utils/app_router.dart';
import '../../../home/presentation/cubit/user/user_cubit.dart';

class LogoutDialog {
  static Future<void> show(BuildContext context) async {
    final confirmed = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(AppTexts.signOutDialogTitle),
        content: const Text(AppTexts.signOutDialogMessage),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text(AppTexts.cancel),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.red,
            ),
            onPressed: () => Navigator.pop(context, true),
            child: const Text(
              AppTexts.signOut,
              style: TextStyle(
                color: AppColors.white,
              ),
            ),
          ),
        ],
      ),
    );

    if (confirmed == true && context.mounted) {
      context.read<UserCubit>().logout();
      GoRouter.of(context).pushReplacement(AppRouter.kLoginView);
    }
  }
}
