import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furniture/core/utils/app_texts.dart';
import 'package:furniture/core/utils/app_colors.dart';
import '../cubit/promo_code_cubit.dart';

class ApplyPromoButton extends StatelessWidget {
  final TextEditingController controller;

  const ApplyPromoButton({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        final success = await context
            .read<PromoCodeCubit>()
            .addPromoCode(controller.text.trim());
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            behavior: SnackBarBehavior.floating,
            content: Text(success
                ? AppTexts.promoCodeAddedSuccessfully
                : AppTexts.invalidPromoCode),
          ),
        );
      },
      style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
      child: const Text(AppTexts.applyButton,
          style: TextStyle(color: AppColors.white)),
    );
  }
}
