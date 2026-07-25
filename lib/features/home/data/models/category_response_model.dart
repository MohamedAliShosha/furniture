import 'product_model.dart';

/// Contains success or not, totalCategories, and productData
class CategoryResponseModel {
  final bool? success;
  final int? totalCategories;
  final Map<String, List<ProductModel>>? productData;

  CategoryResponseModel({
    this.success,
    this.totalCategories,
    this.productData,
  });

  factory CategoryResponseModel.fromJson(Map<String, dynamic> json) {
    Map<String, List<ProductModel>> parsedData = {};

    if (json['data'] != null) {
      json['data'].forEach((key, value) {
        parsedData[key] = value != null
            ? List<ProductModel>.from(
                value.map((e) => ProductModel.fromJson(e)))
            : [];
      });
    }

    return CategoryResponseModel(
      success: json['success'],
      totalCategories: json['total_categories'],
      productData: parsedData,
    );
  }
}
