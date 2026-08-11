// ============================================================================
// PRICE ROW
// ============================================================================

import 'package:flutter/material.dart';
import 'package:furniture/core/utils/constants.dart';

import '../../../../core/utils/app_colors.dart';

class PriceRow extends StatelessWidget {
  const PriceRow({
    super.key,
    required this.label,
    required this.amount,
    this.isTotal = false,
  });

  final String label;
  final double amount;
  final bool isTotal;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: isTotal
              ? AppConstants.titleStyle
              : AppConstants.bodyStyle.copyWith(
                  color: Colors.grey[600],
                ),
        ),
        Text(
          '\$${amount.toStringAsFixed(2)}',
          style: isTotal
              ? AppConstants.titleStyle.copyWith(
                  color: AppColors.primary,
                  fontSize: 20,
                )
              : AppConstants.bodyStyle.copyWith(
                  fontWeight: FontWeight.w600,
                ),
        ),
      ],
    );
  }
}
