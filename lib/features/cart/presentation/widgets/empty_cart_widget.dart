import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../core/utils/app_texts.dart';

class EmptyCartWidget extends StatelessWidget {
  const EmptyCartWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.shopping_cart_outlined,
            size: 64,
            color: Colors.grey[400],
          ),
          const Gap(16),
          Text(
            AppTexts.yourCartIsEmpty,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 18,
            ),
          )
        ],
      ),
    );
  }
}
