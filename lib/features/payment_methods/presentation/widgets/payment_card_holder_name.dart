import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_texts.dart';
import '../../../../core/utils/constants.dart';
import '../../data/models/payment_method_model.dart';

class PaymentCardHolderName extends StatelessWidget {
  const PaymentCardHolderName({
    super.key,
    required this.paymentMethod,
  });

  final PaymentMethodModel paymentMethod;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppTexts.cardHolder,
          style: AppConstants.bodyStyle.copyWith(
            fontSize: 12,
            color: AppColors.white.withOpacity(0.8),
          ),
        ),
        const Gap(4),
        Text(
          paymentMethod.cardHolderName,
          style: AppConstants.bodyStyle.copyWith(
            fontSize: 14,
            color: AppColors.white,
          ),
        ),
      ],
    );
  }
}
