/// Contains average, and count
class ProductRatingModel {
  final double? average;
  final int? count;

  ProductRatingModel({
    this.average,
    this.count,
  });

  factory ProductRatingModel.fromJson(Map<String, dynamic> json) {
    return ProductRatingModel(
      average:
          json['average'] != null ? (json['average'] as num).toDouble() : null,
      count: json['count'],
    );
  }
}
