import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../features/payment_methods/data/models/payment_method_model.dart';
import '../../../../features/payment_methods/presentation/cubit/payment_method_cubit.dart';
import 'add_and_edit_card_dialog.dart';

void showAddAndEditCardDialog(BuildContext context,
    {PaymentMethodModel? method}) {
  final cubit = context.read<PaymentMethodCubit>();

  showDialog(
    context: context,
    builder: (context) => AddAndEditCardDialog(
      paymentMethod: method,
      cubit: cubit,
    ),
  );
}
