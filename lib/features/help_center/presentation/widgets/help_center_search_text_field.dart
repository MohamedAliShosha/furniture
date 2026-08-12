import 'package:flutter/material.dart';

import '../../../../core/utils/app_texts.dart';
import '../../../../core/utils/constants.dart';

class HelpCenterSearchTextField extends StatelessWidget {
  const HelpCenterSearchTextField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: AppTexts.searchForHelpHint,
        prefixIcon: const Icon(
          Icons.search,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            AppConstants.defaultBorderRadius,
          ),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: Colors.grey[100],
      ),
    );
  }
}
