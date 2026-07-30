import 'package:flutter/material.dart';

import '../../../../core/utils/app_texts.dart';

class DeleteConfirmationAlertDialog extends StatelessWidget {
  const DeleteConfirmationAlertDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(AppTexts.deleteCard),
      content: const Text(AppTexts.deletePaymentMethodConfirmation),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: const Text(AppTexts.cancel),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, true),
          style: TextButton.styleFrom(foregroundColor: Colors.red),
          child: const Text(AppTexts.delete),
        ),
      ],
    );
  }
}
