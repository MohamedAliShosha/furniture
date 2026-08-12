import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_texts.dart';

class StillNeedHelpWidgetContent extends StatelessWidget {
  const StillNeedHelpWidgetContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          AppTexts.supportTeamAvailable247,
          textAlign: TextAlign.center,
        ),
        const Gap(16),
        ElevatedButton.icon(
          onPressed: () {
            // Open live chat or support contact
          },
          icon: const Icon(
            Icons.chat_outlined,
          ),
          label: const Text(
            AppTexts.contactSupport,
            style: TextStyle(
              color: AppColors.primary,
            ),
          ),
        )
      ],
    );
  }
}
