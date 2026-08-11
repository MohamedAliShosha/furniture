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
      // Dialog title
      title: const Text(
        AppTexts.orderPlacedSuccess,
      ),
      // Dialog message
      content: const Text(
        AppTexts.thankYouOrder,
      ),
      // Action buttons for the dialog
      actions: [
        // OK button to close dialog and navigate away
        TextButton(
          onPressed: () {
            // Close the success dialog
            Navigator.of(context).pop();
            // Navigate to the home/main view and show orders tab (extra: 1)
            GoRouter.of(context).go(
              AppRouter.kMainView,
              extra: 1,
            );
          },
          // Button label
          child: const Text(
            AppTexts.okButton,
          ),
        ),
      ],
    );
  }
}
