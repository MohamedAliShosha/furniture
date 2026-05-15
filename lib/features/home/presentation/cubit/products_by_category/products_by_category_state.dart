import '../../../data/models/product_model.dart';

abstract class ProductsByCategoryState {
  const ProductsByCategoryState();
}

class ProductsByCategoryInitial extends ProductsByCategoryState {}

class ProductsByCategoryLoading extends ProductsByCategoryState {}

class ProductsByCategorySuccess extends ProductsByCategoryState {
  final List<ProductModel> products;

  const ProductsByCategorySuccess(this.products);
}

class ProductsByCategoryFailure extends ProductsByCategoryState {
  final String message;

  const ProductsByCategoryFailure(this.message);
}
