import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../home/data/models/cart_item.dart';
import '../../../home/services/cart_service.dart';
import 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final CartService cartService;

  CartCubit(this.cartService) : super(CartInitial());

  Future<void> fetchCart() async {
    emit(CartLoading());
    try {
      final cartItems = cartService.getCartItems();
      emit(CartSuccess(cartItems));
    } catch (e) {
      emit(CartFailure(e.toString()));
    }
  }

  Future<void> addToCart(CartItemModel cartItem) async {
    try {
      cartService.addToCart(cartItem);
      final updatedCart = cartService.getCartItems();
      emit(CartSuccess(updatedCart));
    } catch (e) {
      emit(CartFailure(e.toString()));
    }
  }

  Future<void> removeFromCart(String productId, {String? selectedColor}) async {
    try {
      cartService.removeFromCart(productId, selectedColor: selectedColor);
      final updatedCart = cartService.getCartItems();
      emit(CartSuccess(updatedCart));
    } catch (e) {
      emit(CartFailure(e.toString()));
    }
  }

  Future<void> updateQuantity(String productId, int quantity) async {
    try {
      cartService.updateQuantity(productId, quantity);
      final updatedCart = cartService.getCartItems();
      emit(CartSuccess(updatedCart));
    } catch (e) {
      emit(CartFailure(e.toString()));
    }
  }

  Future<void> clearCart() async {
    try {
      cartService.clearCart();
      final updatedCart = cartService.getCartItems();
      emit(CartSuccess(updatedCart));
    } catch (e) {
      emit(CartFailure(e.toString()));
    }
  }

  double getTotalPrice() => cartService.totalPrice;
  List<CartItemModel> getCartItems() => cartService.cartItems;
}
