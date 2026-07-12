import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../home/data/models/product_model.dart';
import '../../../home/services/wishlist_service.dart';
import '../../../home/services/get_all_products_service.dart';
import 'wishlist_state.dart';

class WishlistCubit extends Cubit<WishlistState> {
  final WishListService wishlistService;
  late List<ProductModel> availableProducts;

  WishlistCubit(this.wishlistService, {List<ProductModel>? availableProducts})
      : super(WishlistInitial()) {
    this.availableProducts = availableProducts ?? [];
  }

  /// This method is used to set the available products in the cubit. It can be called when the products are fetched from the API or when the app is initialized.
  void setAvailableProducts(List<ProductModel> products) {
    availableProducts = products;
  }

  /// This method updates the wishlist and emits the new state. It fetches all products, filters them based on the wishlist ids, and emits the success state with the featured items. If there's an error, it emits the failure state with the error message.
  Future<void> _updateAndEmitWishlist() async {
    try {
      final allProducts = AllProductsService.getAllProducts();
      availableProducts = allProducts;
      final wishlistIds = wishlistService.getWishlistIds();
      final wishlistItems = allProducts
          .where((product) => wishlistIds.contains(product.id))
          .toList();
      emit(WishlistSuccess(wishlistItems));
    } catch (e) {
      emit(WishlistFailure(e.toString()));
    }
  }

  Future<void> fetchWishlist() async {
    emit(WishlistLoading());
    await _updateAndEmitWishlist();
  }

  Future<void> addToWishlist(ProductModel product) async {
    wishlistService.toggleWishlist(product.id);
    await _updateAndEmitWishlist();
  }

  Future<void> removeFromWishlist(String productId) async {
    wishlistService.removeFromWishlist(productId);
    await _updateAndEmitWishlist();
  }

  Future<void> toggleWishlistById(String productId) async {
    wishlistService.toggleWishlist(productId);
    await _updateAndEmitWishlist();
  }

  Future<void> clearWishlist() async {
    try {
      wishlistService.clearWishlist();
      emit(const WishlistSuccess([]));
    } catch (e) {
      emit(WishlistFailure(e.toString()));
    }
  }

  List<ProductModel> getWishlistItems() {
    final wishlistIds = wishlistService.getWishlistIds();
    return availableProducts
        .where((product) => wishlistIds.contains(product.id))
        .toList();
  }
  
  int get wishlistCount => wishlistService.getWishlistIds().length;

  bool isProductInWishlist(String productId) =>
      wishlistService.isProductInWishlist(productId);
}
