import 'package:flutter/material.dart';
import 'package:furniture/core/utils/constants.dart';

import '../../data/quick_search_item_model.dart';
import 'quick_help_item.dart';

class QuickHelpItemsGridView extends StatelessWidget {
  const QuickHelpItemsGridView({
    super.key,
    required this.quickHelp,
  });

  final List<QuickSearchItemModel> quickHelp;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      childAspectRatio: 1.5,
      children: quickHelp
          .map(
            (item) => InkWell(
              onTap: item.onTap,
              borderRadius:
                  BorderRadius.circular(AppConstants.defaultBorderRadius),
              child: QuickHelpItem(
                item: item,
              ),
            ),
          )
          .toList(),
    );
  }
}
