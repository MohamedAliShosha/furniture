import '../../../home/data/models/product_model.dart';

/// Contains an object of the ProductModel class, quantity, and price
class OrderItemModel {
  final ProductModel productModel;
  final int quantity;
  final double price; // price at the time of order

  OrderItemModel({
    required this.productModel,
    required this.quantity,
    required this.price,
  });

  /// Gets the total price for this order item (price * quantity).
  double get total => price * quantity;

  Map<String, dynamic> orderItemModelToJson() {
    return {
      'productModel': {
        'id': productModel.id,
        'name': productModel.name,
        'price': productModel.price,
        'category': productModel.category,
        'imageUrl': productModel.images.gallery.first,
        'images': productModel.images.gallery,
        'description': productModel.details!.description,
        'colors': productModel.colors,
      },
      'quantity': quantity,
      'price': price,
    };
  }

  factory OrderItemModel.fromJson(Map<String, dynamic> jsonData) {
    return OrderItemModel(
      productModel: ProductModel(
        details: DetailsModel(
          description: jsonData['productModel']['description'],
        ),
        id: jsonData['productModel']['id'],
        name: jsonData['productModel']['name'],
        price: (jsonData['productModel']['price'] as num).toDouble(),
        colors: List<String>.from(jsonData['productModel']['colors'] ?? []),
        images: ImagesModel(
          gallery: List<String>.from(jsonData['productModel']['images'] ?? []),
        ),
      ),
      quantity: jsonData['quantity'],
      price: (jsonData['price'] as num).toDouble(),
    );
  }
}
