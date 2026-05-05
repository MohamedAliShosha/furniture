import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/utils/constants.dart';

class AlreadyHaveAccount extends StatelessWidget {
  const AlreadyHaveAccount({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Already have an account ? ',
          style: AppConstants.bodyStyle.copyWith(
            color: Colors.grey.shade600,
          ),
        ),
        TextButton(
          onPressed: () {
            // navigate to login screen
            GoRouter.of(context).pop();
          },
          child: const Text(
            'Sign In',
            style: TextStyle(
              color: AppConstants.primaryColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        )
      ],
    );
  }
}
