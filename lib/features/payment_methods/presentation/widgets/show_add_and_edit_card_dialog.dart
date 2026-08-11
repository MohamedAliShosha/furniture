import 'package:flutter/material.dart';
import '../../../../features/payment_methods/data/models/payment_method_model.dart';
import '../../../../features/payment_methods/presentation/cubit/payment_method_cubit.dart';
import 'add_and_edit_card_dialog.dart';

void showAddAndEditCardDialog(BuildContext context,
    {PaymentMethodModel? method, required PaymentMethodCubit cubit}) {
  showDialog(
    context: context,
    builder: (context) {
      return AddAndEditCardDialog(
        paymentMethod: method,
        cubit: cubit,
      );
    },
  );
}
