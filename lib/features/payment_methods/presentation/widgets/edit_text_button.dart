import 'package:flutter/material.dart';

import '../../../../core/utils/app_texts.dart';
import '../../data/models/payment_method_model.dart';
import 'show_add_and_edit_card_dialog.dart';

class EditTextButton extends StatelessWidget {
  const EditTextButton({
    super.key,
    required this.paymentMethod,
  });

  final PaymentMethodModel paymentMethod;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextButton(
        onPressed: () => showAddAndEditCardDialog(
          context,
          method: paymentMethod,
        ),
        style: TextButton.styleFrom(
            foregroundColor: Colors.grey[700],
            padding: const EdgeInsets.symmetric(vertical: 16)),
        child: const Text(
          AppTexts.edit,
        ),
      ),
    );
  }
}
