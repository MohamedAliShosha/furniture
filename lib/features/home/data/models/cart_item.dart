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
    return product.price * quantity;
  }

  double get unitPrice {
    return product.price;
  }
}
