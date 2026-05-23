import 'product_model.dart';

class CartItemModel {
  final ProductModel product;
  int quantity;
  final String selectedColor;

  CartItemModel({
    required this.product,
    required this.quantity,
    required this.selectedColor,
  });

  double get totalPrice {
    if (product.hasSpecialOffer) {
      return product.getDisCountPrice(20) * quantity;
    }
    return product.price * quantity;
  }

  double get unitPrice {
    if (product.hasSpecialOffer) {
      return product.getDisCountPrice(20);
    }
    return product.price;
  }
}
