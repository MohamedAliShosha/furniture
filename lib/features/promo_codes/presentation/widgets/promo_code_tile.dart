import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:furniture/core/utils/app_colors.dart';
import 'package:furniture/core/utils/constants.dart';
import 'package:furniture/features/promo_codes/data/models/promo_code_model.dart';

import '../../../../core/utils/app_texts.dart';

class PromoCodeTile extends StatelessWidget {
  final PromoCodeModel promoCode;
  final VoidCallback? onCopied;

  const PromoCodeTile({super.key, required this.promoCode, this.onCopied});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppConstants.defaultPadding),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            contentPadding: const EdgeInsets.all(16),
            title: Row(
              children: [
                Text(
                  promoCode.code,
                  style: AppConstants.titleStyle.copyWith(
                    fontSize: 18,
                    color:
                        promoCode.isExpired ? AppColors.grey : AppColors.black,
                  ),
                ),
                const Spacer(),
                if (!promoCode.isExpired && !promoCode.isUsed)
                  IconButton(
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: promoCode.code));
                      if (onCopied != null) onCopied!();
                    },
                    icon: const Icon(Icons.copy_outlined),
                  ),
              ],
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  decoration: BoxDecoration(
                    color: promoCode.isExpired || promoCode.isUsed
                        ? Colors.grey[200]
                        : AppColors.primary.withOpacity(0.1),
                    borderRadius:
                        BorderRadius.circular(AppConstants.smallBorderRadius),
                  ),
                  child: Text(
                    promoCode.discount,
                    style: AppConstants.bodyStyle.copyWith(
                      color: promoCode.isExpired || promoCode.isUsed
                          ? AppColors.grey
                          : AppColors.primary,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  promoCode.description,
                  style: AppConstants.bodyStyle
                      .copyWith(color: Colors.grey[800], fontSize: 14),
                ),
                const SizedBox(height: 8),
                Text(
                  'Valid until: ${_formatDate(promoCode.validateUntil)}',
                  style: AppConstants.bodyStyle.copyWith(
                    color:
                        promoCode.isExpired ? AppColors.red : Colors.grey[600],
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    final monthNames = [
      AppTexts.january,
      AppTexts.february,
      AppTexts.march,
      AppTexts.april,
      AppTexts.may,
      AppTexts.june,
      AppTexts.july,
      AppTexts.august,
      AppTexts.september,
      AppTexts.october,
      AppTexts.november,
      AppTexts.december,
    ];
    return '${date.day} ${monthNames[date.month - 1]} ${date.year}';
  }
}
