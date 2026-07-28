import 'package:flutter/material.dart';
import '../../../../core/utils/service_locator.dart';
import '../../../orders/data/models/shipping_address_model.dart';
import '../cubit/shipping_address_cubit.dart';
import 'add_new_address_dialog.dart';

void addAndEditAddressDialog(BuildContext context,
    {ShippingAddressModel? address}) {
  final cubit =
      getIt<ShippingAddressCubit>(); // Get from service locator instead

  showDialog(
    context: context,
    builder: (context) => AddAndEditAddressDialog(
      shippingAddress: address,
      cubit: cubit,
    ),
  );
}
