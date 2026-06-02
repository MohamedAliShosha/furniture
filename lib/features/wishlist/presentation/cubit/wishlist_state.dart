import '../../../home/data/models/product_model.dart';

abstract class WishlistState {
  const WishlistState();
}

class WishlistInitial extends WishlistState {}

class WishlistLoading extends WishlistState {}

class WishlistSuccess extends WishlistState {
  final List<ProductModel> wishListedItems;

  const WishlistSuccess(this.wishListedItems);
}

class WishlistFailure extends WishlistState {
  final String message;

  const WishlistFailure(this.message);
}
