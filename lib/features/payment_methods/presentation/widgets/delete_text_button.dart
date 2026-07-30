import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furniture/features/payment_methods/presentation/cubit/payment_method_cubit.dart';

import '../../../../core/utils/app_texts.dart';
import '../../data/models/payment_method_model.dart';
import 'delete_confirmation_alert_dialog.dart';

class DeleteTextButton extends StatelessWidget {
  const DeleteTextButton({
    super.key,
    required this.paymentMethod,
  });

  final PaymentMethodModel paymentMethod;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () async {
        final cubit = context.read<PaymentMethodCubit>();
        final shouldDelete = await showDialog<bool>(
          context: context,
          builder: (context) => const DeleteConfirmationAlertDialog(),
        );
        if (shouldDelete == true) {
          await cubit.deletePaymentMethod(paymentMethod.id);
        }
      },
      style: TextButton.styleFrom(
          foregroundColor: Colors.red,
          padding: const EdgeInsets.symmetric(vertical: 16)),
      child: const Text(
        AppTexts.delete,
      ),
    );
  }
}
