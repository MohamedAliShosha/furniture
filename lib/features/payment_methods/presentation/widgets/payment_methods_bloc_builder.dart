import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/app_texts.dart';
import '../../../../core/widgets/custom_empty_state.dart';
import '../../../../core/widgets/custom_error_state.dart';
import '../../../../core/widgets/custom_loading_state.dart';
import '../cubit/payment_method_cubit.dart';
import '../cubit/payment_method_state.dart';
import 'payment_methods_list_view.dart';

class PaymentMethodsBlocBuilder extends StatelessWidget {
  const PaymentMethodsBlocBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PaymentMethodCubit, PaymentMethodState>(
      builder: (context, state) {
        if (state is PaymentMethodLoading) {
          return const CustomLoadingState();
        }

        if (state is PaymentMethodFailure) {
          return CustomErrorState(
            message: state.message,
            onRetry: () {
              context.read<PaymentMethodCubit>().loadPaymentMethods();
            },
            retryLabel: AppTexts.retry,
          );
        }

        if (state is PaymentMethodSuccess) {
          final paymentMethods = state.paymentMethods;

          if (paymentMethods.isEmpty) {
            return CustomEmptyState(
              icon: Icon(
                Icons.credit_card_outlined,
                size: 64,
                color: Colors.grey[400],
              ),
              messageColor: Colors.grey[600],
              message: AppTexts.noPaymentMethodsAddedYet,
            );
          }

          return PaymentMethodsListView(paymentMethods: paymentMethods);
        }

        return const SizedBox.shrink();
      },
    );
  }
}
