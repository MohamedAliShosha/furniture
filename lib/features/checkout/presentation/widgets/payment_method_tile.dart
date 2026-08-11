import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_texts.dart';
import '../../../../core/utils/constants.dart';
import '../../../payment_methods/data/models/payment_method_model.dart';

class PaymentMethodTile extends StatelessWidget {
  const PaymentMethodTile({
    super.key,
    required this.method,
    required this.isSelected,
    required this.onSelected,
  });

  final PaymentMethodModel method;
  final bool isSelected;
  final VoidCallback onSelected;

  @override
  Widget build(BuildContext context) {
    final cardColor = Color(
      int.parse(method.cardColors),
    );
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          width: isSelected ? 2 : 1,
          color: isSelected ? AppConstants.primaryColor : Colors.grey[300]!,
        ),
      ),
      child: ListTile(
        onTap: onSelected,
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: cardColor,
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.credit_card,
            color: AppColors.white,
          ),
        ),
        title: Text(
          '${method.cardType} **** ${method.cardNumber.substring(
            method.cardNumber.length - 4,
          )}',
          style: AppConstants.bodyStyle.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(
          '${AppTexts.expiresPrefix} ${method.expireDate}',
          style: AppConstants.bodyStyle.copyWith(
            color: Colors.grey[600],
            fontSize: 12,
          ),
        ),
        trailing: isSelected
            ? const Icon(
                Icons.check_circle,
                color: AppColors.primary,
              )
            : null,
      ),
    );
  }
}
