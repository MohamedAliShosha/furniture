import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/constants.dart';
import '../../data/quick_search_item_model.dart';

class QuickHelpItem extends StatelessWidget {
  const QuickHelpItem({
    super.key,
    required this.item,
  });

  final QuickSearchItemModel item;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(
          AppConstants.defaultBorderRadius,
        ),
      ),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Icon(
          item.icon,
          color: AppColors.primary,
          size: 32,
        ),
        const Gap(8),
        Text(
          item.title,
          style: AppConstants.titleStyle.copyWith(
            fontSize: 14,
          ),
        ),
      ]),
    );
  }
}
