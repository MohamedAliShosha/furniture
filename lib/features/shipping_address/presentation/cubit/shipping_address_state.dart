import 'package:furniture/features/orders/data/models/shipping_address_model.dart';

abstract class ShippingAddressState {
  const ShippingAddressState();
}

class ShippingAddressInitial extends ShippingAddressState {}

class ShippingAddressLoading extends ShippingAddressState {}

class ShippingAddressSuccess extends ShippingAddressState {
  final List<ShippingAddressModel> addresses;

  const ShippingAddressSuccess(this.addresses);
}

class ShippingAddressFailure extends ShippingAddressState {
  final String message;

  const ShippingAddressFailure(this.message);
}
