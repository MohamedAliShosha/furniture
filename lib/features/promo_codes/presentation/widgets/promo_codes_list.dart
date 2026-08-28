import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furniture/core/widgets/custom_empty_state.dart';
import '../cubit/promo_code_cubit.dart';
import '../cubit/promo_code_state.dart';
import 'promo_code_tile.dart';
import 'package:furniture/core/utils/app_texts.dart';

class PromoCodesList extends StatelessWidget {
  final bool isAvailable;

  const PromoCodesList({super.key, required this.isAvailable});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PromoCodeCubit, PromoCodeState>(
      builder: (context, state) {
        final promoCodes = state is PromoCodeSuccess && isAvailable
            ? state.availablePromoCodes
            : state is PromoCodeSuccess && !isAvailable
                ? state.usedPromoCodes
                : [];

        if (promoCodes.isEmpty) {
          return CustomEmptyState(
            icon:
                Icon(isAvailable ? Icons.local_offer_outlined : Icons.history),
            message: isAvailable
                ? AppTexts.noPromoCodesAvailable
                : AppTexts.noUsedPromoCodes,
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: promoCodes.length,
          itemBuilder: (context, index) {
            final promoCode = promoCodes[index];
            return PromoCodeTile(
              promoCode: promoCode,
              onCopied: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    behavior: SnackBarBehavior.floating,
                    content: Center(
                      child: Text(AppTexts.promoCodeCopiedToClipboard),
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
