import 'package:flutter/material.dart';

import '../../../../core/utils/constants.dart';
import '../../../../features/orders/data/models/shipping_address_model.dart';
import 'shipping_address_card_widget.dart';

class ShippingAddressesListView extends StatelessWidget {
  const ShippingAddressesListView({
    super.key,
    required this.addresses,
  });

  final List<ShippingAddressModel> addresses;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(AppConstants.defaultPadding),
      itemCount: addresses.length,
      itemBuilder: (context, index) {
        final address = addresses[index];
        return ShippingAddressCardWidget(
          address: address,
        );
      },
    );
  }
}
