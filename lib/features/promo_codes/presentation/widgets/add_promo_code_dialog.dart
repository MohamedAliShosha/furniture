import 'package:flutter/material.dart';
import 'package:furniture/core/utils/app_texts.dart';
import 'package:furniture/core/utils/constants.dart';
import 'apply_promo_button.dart';

class AddPromoCodeDialog extends StatefulWidget {
  const AddPromoCodeDialog({super.key});

  @override
  State<AddPromoCodeDialog> createState() => _AddPromoCodeDialogState();
}

class _AddPromoCodeDialogState extends State<AddPromoCodeDialog> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(AppTexts.addPromoCode, style: AppConstants.titleStyle),
      content: TextField(
        controller: _controller,
        decoration: InputDecoration(
          labelText: AppTexts.codeLabel,
          hintText: AppTexts.enterPromoCodeHint,
          border: OutlineInputBorder(
            borderRadius:
                BorderRadius.circular(AppConstants.defaultBorderRadius),
          ),
        ),
        textCapitalization: TextCapitalization.characters,
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text(AppTexts.cancel),
        ),
        ApplyPromoButton(controller: _controller),
      ],
    );
  }
}
