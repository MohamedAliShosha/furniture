import 'package:flutter/material.dart';
import '../../../../core/utils/service_locator.dart';
import '../../../../features/payment_methods/data/models/payment_method_model.dart';
import '../../../../features/payment_methods/presentation/cubit/payment_method_cubit.dart';
import 'add_and_edit_card_dialog.dart';

void showAddAndEditCardDialog(BuildContext context,
    {PaymentMethodModel? method}) {
  final cubit = getIt<PaymentMethodCubit>();

  showDialog(
    context: context,
    builder: (context) => AddAndEditCardDialog(
      paymentMethod: method,
      cubit: cubit,
    ),
  );
}
