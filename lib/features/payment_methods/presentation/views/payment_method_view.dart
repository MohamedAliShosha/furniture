import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_texts.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/utils/service_locator.dart';
import '../cubit/payment_method_cubit.dart';
import '../widgets/payment_method_view_body.dart';
import '../widgets/show_add_and_edit_card_dialog.dart';

class PaymentMethodView extends StatelessWidget {
  const PaymentMethodView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<PaymentMethodCubit>()..loadPaymentMethods(),
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          backgroundColor: AppColors.white,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back_ios,
            ),
          ),
          title: Text(
            AppTexts.paymentMethods,
            style: AppConstants.titleStyle,
          ),
          actions: [
            IconButton(
              onPressed: () {
                showAddAndEditCardDialog(context);
              },
              icon: const Icon(
                color: AppColors.primary,
                Icons.add,
              ),
            )
          ],
        ),
        body: const PaymentMethodViewBody(),
      ),
    );
  }
}
