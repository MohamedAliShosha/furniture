import 'package:flutter/material.dart';
import '../../../../core/utils/app_texts.dart';
import '../../../../core/utils/constants.dart';
import 'package:gap/gap.dart';

class EmptyWisListWidget extends StatelessWidget {
  const EmptyWisListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.favorite_border,
            size: 64,
            color: Colors.grey[400],
          ),
          const Gap(16),
          Text(
            AppTexts.yourWishlistIsEmpty,
            style: AppConstants.titleStyle.copyWith(
              color: Colors.grey[600],
            ),
          ),
          const Gap(8),
          Text(
            textAlign: TextAlign.center,
            AppTexts.saveItemsYouLikeByTappingTheHeartIcon,
            style: AppConstants.bodyStyle.copyWith(
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
