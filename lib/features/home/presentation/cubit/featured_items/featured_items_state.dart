import '../../../data/models/product_model.dart';

abstract class FeaturedItemsState {
  const FeaturedItemsState();
}

class FeaturedItemsInitial extends FeaturedItemsState {}

class FeaturedItemsLoading extends FeaturedItemsState {}

class FeaturedItemsSuccess extends FeaturedItemsState {
  final List<ProductModel> products;

  const FeaturedItemsSuccess(this.products);
}

class FeaturedItemsFailure extends FeaturedItemsState {
  final String message;

  const FeaturedItemsFailure(this.message);
}
