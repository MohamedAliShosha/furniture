import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/utils/app_router.dart';
import '../../../../../core/utils/app_texts.dart';
import '../../../../home/presentation/cubit/user/user_cubit.dart';

class GuestButton extends StatelessWidget {
  const GuestButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        context.read<UserCubit>().continueAsGuest();
        GoRouter.of(context).pushReplacement(AppRouter.kMainView);
      },
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        side: BorderSide(
          width: 1,
          color: Colors.grey[300]!,
        ),
      ),
      child: const Text(AppTexts.continueAsGuest),
    );
  }
}
