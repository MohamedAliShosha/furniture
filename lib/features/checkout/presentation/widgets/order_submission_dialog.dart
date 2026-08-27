import 'package:flutter/material.dart';
import 'package:furniture/core/utils/app_router.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/utils/app_texts.dart';

class OrderSubmissionDialog extends StatelessWidget {
  const OrderSubmissionDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        AppTexts.orderPlacedSuccess,
      ),
      content: const Text(
        AppTexts.thankYouOrder,
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            GoRouter.of(context).go(AppRouter.kMainView);
          },
          child: const Text(
            AppTexts.okButton,
          ),
        ),
      ],
    );
  }
}
