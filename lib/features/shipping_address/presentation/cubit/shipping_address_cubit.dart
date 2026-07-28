import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../features/orders/data/models/shipping_address_model.dart';
import '../../service/shipping_address_service.dart';
import 'shipping_address_state.dart';

class ShippingAddressCubit extends Cubit<ShippingAddressState> {
  final ShippingAddressService shippingAddressService;

  ShippingAddressCubit(this.shippingAddressService)
      : super(ShippingAddressInitial());

  Future<void> loadAddresses() async {
    emit(ShippingAddressLoading());
    try {
      await shippingAddressService.loadAddresses();
      final addresses = shippingAddressService.getAddresses();
      if (!isClosed) {
        emit(
          ShippingAddressSuccess(addresses),
        );
      }
    } catch (e) {
      if (!isClosed) {
        emit(
          ShippingAddressFailure(
            e.toString(),
          ),
        );
      }
    }
  }

  Future<void> addAddress(ShippingAddressModel address) async {
    try {
      await shippingAddressService.addAddress(address);
      final addresses = shippingAddressService.getAddresses();
      if (!isClosed) {
        emit(
          ShippingAddressSuccess(addresses),
        );
      }
    } catch (e) {
      if (!isClosed) {
        emit(
          ShippingAddressFailure(
            e.toString(),
          ),
        );
      }
    }
  }

  Future<void> updateAddress(ShippingAddressModel newAddress) async {
    try {
      await shippingAddressService.updateAddress(newAddress);
      final addresses = shippingAddressService.getAddresses();
      if (!isClosed) {
        emit(
          ShippingAddressSuccess(addresses),
        );
      }
    } catch (e) {
      if (!isClosed) {
        emit(
          ShippingAddressFailure(
            e.toString(),
          ),
        );
      }
    }
  }

  Future<void> deleteAddress(String id) async {
    try {
      await shippingAddressService.deleteAddress(id);
      final addresses = shippingAddressService.getAddresses();
      if (!isClosed) {
        emit(
          ShippingAddressSuccess(addresses),
        );
      }
    } catch (e) {
      if (!isClosed) {
        emit(
          ShippingAddressFailure(
            e.toString(),
          ),
        );
      }
    }
  }

  Future<void> setDefaultAddress(String id) async {
    try {
      await shippingAddressService.setDefaultAddress(id);
      final addresses = shippingAddressService.getAddresses();
      if (!isClosed) {
        emit(
          ShippingAddressSuccess(addresses),
        );
      }
    } catch (e) {
      if (!isClosed) {
        emit(
          ShippingAddressFailure(
            e.toString(),
          ),
        );
      }
    }
  }
}
