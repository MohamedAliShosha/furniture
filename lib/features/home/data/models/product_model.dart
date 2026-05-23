class CategoryResponseModel {
  final bool? success;
  final int? totalCategories;
  final Map<String, List<ProductModel>>? data;

  CategoryResponseModel({
    this.success,
    this.totalCategories,
    this.data,
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
      data: parsedData,
    );
  }
}

class ProductModel {
  final String id;
  bool isFavorite;
  final String name;
  final String? category;
  final double price;
  final RatingModel? rating;
  final ImagesModel images;
  final DetailsModel? details;
  final List<String>? colors;
  final List<String>? specialOffersIds;

  ProductModel({
    required this.id,
    required this.name,
    this.category,
    this.isFavorite = false,
    required this.price,
    this.specialOffersIds = const [],
    this.rating,
    required this.colors,
    required this.images,
    this.details,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      colors: json['colors'] != null
          ? List<String>.from(json['colors'].map((e) => e))
          : [],
      id: json['id'],
      name: json['name'],
      category: json['typeName'],
      price: json['price'],
      rating:
          json['rating'] != null ? RatingModel.fromJson(json['rating']) : null,
      images: json['images'] = ImagesModel.fromJson(json['images']),
      details: json['details'] != null
          ? DetailsModel.fromJson(json['details'])
          : null,
    );
  }

  double getDisCountPrice(double discountPercentage) {
    return price - ((price * discountPercentage) / 100);
  }

  bool get hasSpecialOffer => specialOffersIds!.isNotEmpty;

  ProductModel copyWith({
    String? id,
    bool? isFavorite,
    String? name,
    String? category,
    double? price,
    RatingModel? rating,
    ImagesModel? images,
    DetailsModel? details,
    List<String>? colors,
    List<String>? specialOffersIds,
  }) {
    return ProductModel(
      id: id ?? this.id,
      isFavorite: isFavorite ?? this.isFavorite,
      name: name ?? this.name,
      category: category ?? this.category,
      price: price ?? this.price,
      rating: rating ?? this.rating,
      images: images ?? this.images,
      details: details ?? this.details,
      colors: colors ?? this.colors,
      specialOffersIds: specialOffersIds ?? this.specialOffersIds,
    );
  }
}

class RatingModel {
  final double? average;
  final int? count;

  RatingModel({
    this.average,
    this.count,
  });

  factory RatingModel.fromJson(Map<String, dynamic> json) {
    return RatingModel(
      average:
          json['average'] != null ? (json['average'] as num).toDouble() : null,
      count: json['count'],
    );
  }
}

class ImagesModel {
  final String? main;
  final List<String> gallery;

  ImagesModel({
    this.main,
    required this.gallery,
  });

  factory ImagesModel.fromJson(Map<String, dynamic> json) {
    return ImagesModel(
      main: json['main'],
      gallery:
          json['gallery'] != null ? List<String>.from(json['gallery']) : [],
    );
  }
}

class DetailsModel {
  final String? itemMeasureReferenceText;
  final String? designText;
  final bool? isOnlineSellable;
  final String? badge;

  DetailsModel({
    this.itemMeasureReferenceText,
    this.designText,
    this.isOnlineSellable,
    this.badge,
  });

  factory DetailsModel.fromJson(Map<String, dynamic> json) {
    return DetailsModel(
      itemMeasureReferenceText: json['itemMeasureReferenceText'],
      designText: json['designText'],
      isOnlineSellable: json['isOnlineSellable'],
      badge: json['badge'],
    );
  }
}
