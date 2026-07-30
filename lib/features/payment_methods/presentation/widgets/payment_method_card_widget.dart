import 'package:flutter/material.dart';
import 'package:furniture/features/shipping_address/presentation/widgets/default_badge.dart';
import 'package:gap/gap.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/constants.dart';
import '../../../../features/payment_methods/data/models/payment_method_model.dart';
import 'delete_text_button.dart';
import 'edit_text_button.dart';
import 'payment_card_expire_date.dart';
import 'payment_card_holder_name.dart';
import 'set_as_default_text_button.dart';

class PaymentMethodCardWidget extends StatelessWidget {
  const PaymentMethodCardWidget({
    super.key,
    required this.paymentMethod,
  });

  final PaymentMethodModel paymentMethod;
  @override
  Widget build(BuildContext context) {
    final cardColor = Color(int.parse(paymentMethod.cardColors));

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius),
        boxShadow: [
          BoxShadow(
            color: AppColors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                cardColor,
                cardColor.withOpacity(0.8),
              ], begin: Alignment.topLeft, end: Alignment.bottomRight),
              borderRadius: BorderRadius.circular(
                AppConstants.defaultBorderRadius,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      paymentMethod.cardType,
                      style: AppConstants.titleStyle.copyWith(
                        color: AppColors.white,
                        fontSize: 20,
                      ),
                    ),
                    if (paymentMethod.isDefault)
                      DefaultBadge(
                        textColor: AppColors.white,
                        boxDecorationColor: AppColors.white.withOpacity(0.2),
                      )
                  ],
                ),
                const Gap(20),
                Text(
                  paymentMethod.cardNumber,
                  style: AppConstants.titleStyle.copyWith(
                      color: AppColors.white, fontSize: 18, letterSpacing: 2),
                ),
                const Gap(20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    PaymentCardHolderName(paymentMethod: paymentMethod),
                    PaymentCardExpireDate(paymentMethod: paymentMethod)
                  ],
                )
              ],
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(
                  AppConstants.defaultBorderRadius,
                ),
                bottomRight: Radius.circular(
                  AppConstants.defaultBorderRadius,
                ),
              ),
            ),
            child: Row(
              children: [
                if (!paymentMethod.isDefault)
                  SetAsDefaultTextButton(paymentMethod: paymentMethod),
                EditTextButton(paymentMethod: paymentMethod),
                Expanded(
                  child: DeleteTextButton(paymentMethod: paymentMethod),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
