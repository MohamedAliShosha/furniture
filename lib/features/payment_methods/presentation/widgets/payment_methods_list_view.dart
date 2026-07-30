import 'package:flutter/material.dart';

import '../../../../core/utils/constants.dart';
import '../../../../features/payment_methods/data/models/payment_method_model.dart';
import 'payment_method_card_widget.dart';

class PaymentMethodsListView extends StatelessWidget {
  const PaymentMethodsListView({
    super.key,
    required this.paymentMethods,
  });

  final List<PaymentMethodModel> paymentMethods;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(AppConstants.defaultPadding),
      itemCount: paymentMethods.length,
      itemBuilder: (context, index) {
        final method = paymentMethods[index];
        return PaymentMethodCardWidget(paymentMethod: method);
      },
    );
  }
}
