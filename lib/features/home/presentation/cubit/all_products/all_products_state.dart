import '../../../data/models/product_model.dart';

abstract class AllProductsState {
  const AllProductsState();
}

class AllProductsInitial extends AllProductsState {}

class AllProductsLoading extends AllProductsState {}

class AllProductsSuccess extends AllProductsState {
  final List<ProductModel> products;

  const AllProductsSuccess(this.products);
}

class AllProductsFailure extends AllProductsState {
  final String message;

  const AllProductsFailure(this.message);
}
