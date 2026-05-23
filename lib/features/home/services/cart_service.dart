import '../data/models/cart_item.dart';

class CartService {
  // Will store the ids of the products that are added to the whishList
  final List<CartItemModel> cartItems = [];

  // Returns the the cart items
  List<CartItemModel> getCartItems() => cartItems;

  // Returns the total price of the cart
  double get totalPrice =>
      cartItems.fold(0, (sum, item) => sum + item.totalPrice);

  // Returns the number of items in the cart
  int get cartItemsCount => cartItems.length;

  // Adds a product to the cart
  void addToCart(CartItemModel cartItem) {
    // Getting the index of the product in the cart
    final existingIndex = cartItems.indexWhere(
      (item) =>
          item.product.id == cartItem.product.id &&
          item.selectedColor == cartItem.selectedColor,
    );
    // if the product is already in the cart
    if (existingIndex >= 0) {
      // update the quantity by adding the new quantity
      cartItems[existingIndex].quantity += cartItem.quantity;
    } else {
      // if the product is not in the cart then add it
      cartItems.add(cartItem);
    }
  }

  // Removes a product from the cart
  void removeFromCart(String productId, {String? selectedColor}) {
    if (selectedColor != null) {
      cartItems.removeWhere((item) =>
          item.product.id == productId && item.selectedColor == selectedColor);
    } else {
      cartItems.removeWhere((item) => item.product.id == productId);
    }
  }

  void updateQuantity(String productId, int quantity) {
    final index = cartItems.indexWhere((item) => item.product.id == productId);
    // if the product is in the cart
    if (index >= 0) {
      // if the quantity is less than or equal to 0 then remove the item
      if (quantity <= 0) {
        cartItems.removeAt(index);
      } else {
        // update the quantity if the quantity is greater than 0
        cartItems[index].quantity = quantity;
      }
    }
  }

  void clearCart() => {
        cartItems.clear(),
      };
}
