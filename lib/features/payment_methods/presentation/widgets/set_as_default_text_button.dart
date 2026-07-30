import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_texts.dart';
import '../../data/models/payment_method_model.dart';
import '../cubit/payment_method_cubit.dart';

class SetAsDefaultTextButton extends StatelessWidget {
  const SetAsDefaultTextButton({
    super.key,
    required this.paymentMethod,
  });

  final PaymentMethodModel paymentMethod;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextButton(
        onPressed: () {
          context
              .read<PaymentMethodCubit>()
              .setDefaultPaymentMethod(paymentMethod.id);
        },
        style: TextButton.styleFrom(
            foregroundColor: AppColors.primary,
            padding: const EdgeInsets.symmetric(vertical: 16)),
        child: const Text(
          AppTexts.setAsDefault,
        ),
      ),
    );
  }
}
