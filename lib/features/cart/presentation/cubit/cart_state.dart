import '../../../home/data/models/cart_item.dart';

abstract class CartState {
  const CartState();
}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartSuccess extends CartState {
  final List<CartItemModel> cartItems;

  const CartSuccess(this.cartItems);
}

class CartFailure extends CartState {
  final String message;

  const CartFailure(this.message);
}
