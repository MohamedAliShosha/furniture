import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_texts.dart';
import '../../../../core/utils/constants.dart';
import '../../data/models/payment_method_model.dart';

class PaymentCardExpireDate extends StatelessWidget {
  const PaymentCardExpireDate({
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
          AppTexts.expires,
          style: AppConstants.bodyStyle.copyWith(
            fontSize: 12,
            color: AppColors.white,
          ),
        ),
        const Gap(4),
        Text(
          paymentMethod.expireDate,
          style: AppConstants.bodyStyle.copyWith(
            fontSize: 14,
            color: AppColors.white,
          ),
        ),
      ],
    );
  }
}
