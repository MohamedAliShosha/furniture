class CategoryModel {
  final String id;
  final String name;
  final String image;
  final int productCount;
  final String? badge;
  final List<String>? applicableOffersIds;

  CategoryModel({
    required this.id,
    required this.name,
    required this.image,
    required this.productCount,
    this.badge,
    this.applicableOffersIds,
  });

  CategoryModel copyWith({
    String? id,
    String? name,
    String? image,
    int? productCount,
    String? badge,
    List<String>? applicableOffersIds,
  }) {
    return CategoryModel(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
      productCount: productCount ?? this.productCount,
      badge: badge ?? this.badge,
      applicableOffersIds: applicableOffersIds ?? this.applicableOffersIds,
    );
  }
}
