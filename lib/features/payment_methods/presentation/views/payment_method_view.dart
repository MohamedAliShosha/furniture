import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_texts.dart';
import '../../../../core/utils/service_locator.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../cubit/payment_method_cubit.dart';
import '../widgets/payment_method_view_body.dart';
import '../widgets/show_add_and_edit_card_dialog.dart';

class PaymentMethodView extends StatelessWidget {
  const PaymentMethodView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<PaymentMethodCubit>()..loadPaymentMethods(),
      child: Builder(
        builder: (context) {
          return Scaffold(
            backgroundColor: AppColors.white,
            appBar: CustomAppBar(
              title: AppTexts.paymentMethods,
              actions: [
                IconButton(
                  onPressed: () {
                    final cubit = context.read<PaymentMethodCubit>();
                    showAddAndEditCardDialog(
                      context,
                      cubit: cubit,
                    );
                  },
                  icon: const Icon(
                    color: AppColors.primary,
                    Icons.add,
                  ),
                )
              ],
            ),
            body: const PaymentMethodViewBody(),
          );
        },
      ),
    );
  }
}
