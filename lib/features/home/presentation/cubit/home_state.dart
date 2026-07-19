import '../../data/models/product_model.dart';
import '../../data/models/category_model.dart';

abstract class HomeState {
  const HomeState();
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeSuccess extends HomeState {
  final List<ProductModel> featuredProducts;
  final List<ProductModel> allProducts;
  final List<CategoryModel> categories;
  final List<ProductModel> productsByCategory;

  const HomeSuccess({
    required this.featuredProducts,
    required this.allProducts,
    required this.categories,
    required this.productsByCategory,
  });
}

class HomeFailure extends HomeState {
  final String message;

  const HomeFailure(this.message);
}
