import 'package:flutter/material.dart';
import '../../../../../core/utils/app_router.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/utils/constants.dart';

class DontHaveAccount extends StatelessWidget {
  const DontHaveAccount({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don't have an account ? ",
          style: AppConstants.bodyStyle.copyWith(
            color: Colors.grey.shade600,
          ),
        ),
        TextButton(
          onPressed: () {
            // navigate to sign up screen
            GoRouter.of(context).push(AppRouter.kSignUpView);
          },
          child: const Text(
            'Sign Up',
            style: TextStyle(
              color: AppConstants.primaryColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
