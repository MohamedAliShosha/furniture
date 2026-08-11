import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/app_texts.dart';
import '../../data/models/payment_method_model.dart';
import '../cubit/payment_method_cubit.dart';
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
        onPressed: () {
          final cubit = context.read<PaymentMethodCubit>();
          showAddAndEditCardDialog(
            context,
            method: paymentMethod,
            cubit: cubit,
          );
        },
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
