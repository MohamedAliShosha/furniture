// ============================================================================
// STEP 3: PAYMENT METHOD STEP
// ============================================================================

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_router.dart';
import '../../../../core/utils/app_texts.dart';
import '../../../../core/utils/constants.dart';
import '../../../payment_methods/presentation/cubit/payment_method_cubit.dart';
import '../../../payment_methods/presentation/cubit/payment_method_state.dart';
import 'payment_method_tile.dart';

class PaymentMethodStepContent extends StatelessWidget {
  const PaymentMethodStepContent({
    super.key,
    required this.selectedPaymentMethod,
    required this.onPaymentMethodSelected,
  });

  final String? selectedPaymentMethod;
  final Function(String) onPaymentMethodSelected;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PaymentMethodCubit, PaymentMethodState>(
      builder: (BuildContext context, state) {
        final paymentMethods =
            state is PaymentMethodSuccess ? state.paymentMethods : [];

        if (paymentMethods.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.credit_card_outlined,
                  size: 64,
                  color: Colors.grey[400],
                ),
                const Gap(16),
                Text(
                  AppTexts.noPaymentMethodsAdded,
                  style: AppConstants.titleStyle.copyWith(
                    color: Colors.grey[600],
                  ),
                ),
                const Gap(16),
                ElevatedButton(
                  onPressed: () {
                    GoRouter.of(context).push(AppRouter.kPaymentMethodView);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 24,
                    ),
                  ),
                  child: const Text(
                    AppTexts.addPaymentMethod,
                    style: TextStyle(
                      color: AppColors.white,
                    ),
                  ),
                )
              ],
            ),
          );
        }
        return Column(
          children: [
            SizedBox(
              height: 220,
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: paymentMethods.length,
                itemBuilder: (context, index) => PaymentMethodTile(
                  method: paymentMethods[index],
                  isSelected: selectedPaymentMethod == paymentMethods[index].id,
                  onSelected: () {
                    onPaymentMethodSelected(paymentMethods[index].id);
                  },
                ),
              ),
            ),
            const Gap(16),
            OutlinedButton.icon(
              icon: const Icon(
                Icons.add,
              ),
              onPressed: () {
                GoRouter.of(context).push(
                  AppRouter.kPaymentMethodView,
                );
              },
              label: const Text(
                AppTexts.addNewCard,
              ),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.primary,
                side: const BorderSide(
                  color: AppColors.primary,
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 14,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    AppConstants.defaultBorderRadius,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
