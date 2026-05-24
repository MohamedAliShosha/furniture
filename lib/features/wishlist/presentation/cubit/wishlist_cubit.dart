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

  void setAvailableProducts(List<ProductModel> products) {
    availableProducts = products;
  }

  Future<void> fetchWishlist() async {
    emit(WishlistLoading());
    try {
      // fetch all products to make sure we have the latest data, and to be able to filter the wishlist items based on the latest products list
      final allProducts = AllProductsService.getAllProducts();
      // this line is to make sure that the availableProducts is always up to date with the latest products, in case there are any changes in the products list
      availableProducts = allProducts;
      // get the wishlist ids from the service, and then filter the products based on those ids to get the wishlist items
      final wishlistIds = wishlistService.getWhishListIds();
      // filter the products based on the wishlist ids to get the wishlist items, and then emit the success state with the wishlist items
      final featuredItems = allProducts
          .where((product) => wishlistIds.contains(product.id))
          .toList();
      emit(
        WishlistSuccess(
          featuredItems,
        ),
      );
    } catch (e) {
      emit(
        WishlistFailure(
          e.toString(),
        ),
      );
    }
  }

  Future<void> addToWishlist(ProductModel product) async {
    try {
      // Toggle wishlist through the service
      wishlistService.toggleWhishList(product.id);
      // fetch all products to make sure we have the latest data, and to be able to filter the wishlist items based on the latest products list
      final allProducts = AllProductsService.getAllProducts();
      // this line is to make sure that the availableProducts is always up to date with the latest products, in case there are any changes in the products list
      availableProducts = allProducts;
      // get the wishlist ids from the service, and then filter the products based on those ids to get the wishlist items
      final wishlistIds = wishlistService.getWhishListIds();
      final featuredItems =
          allProducts.where((p) => wishlistIds.contains(p.id)).toList();
      emit(
        WishlistSuccess(
          featuredItems,
        ),
      );
    } catch (e) {
      emit(
        WishlistFailure(
          e.toString(),
        ),
      );
    }
  }

  Future<void> removeFromWishlist(String productId) async {
    try {
      // Toggle wishlist through the service
      wishlistService.removeFromWhishList(productId);
      // fetch all products to make sure we have the latest data, and to be able to filter the wishlist items based on the latest products list
      final allProducts = AllProductsService.getAllProducts();
      // this line is to make sure that the availableProducts is always up to date with the latest products, in case there are any changes in the products list
      availableProducts = allProducts;
      // get the wishlist ids from the service, and then filter the products based on those ids to get the wishlist items, and then emit the success state with the wishlist items
      final wishlistIds = wishlistService.getWhishListIds();
      final featuredItems = allProducts
          .where((product) => wishlistIds.contains(product.id))
          .toList();
      emit(
        WishlistSuccess(
          featuredItems,
        ),
      );
    } catch (e) {
      emit(
        WishlistFailure(
          e.toString(),
        ),
      );
    }
  }

  Future<void> toggleWishlist(ProductModel product) async {
    await toggleWishlistById(product.id);
  }

  Future<void> toggleWishlistById(String productId) async {
    try {
      wishlistService.toggleWhishList(productId);
      final allProducts = AllProductsService.getAllProducts();
      availableProducts = allProducts;
      final wishlistIds = wishlistService.getWhishListIds();
      final featuredItems =
          allProducts.where((p) => wishlistIds.contains(p.id)).toList();
      emit(WishlistSuccess(featuredItems));
    } catch (e) {
      emit(WishlistFailure(e.toString()));
    }
  }

  Future<void> clearWishlist() async {
    try {
      wishlistService.clearWhishList();
      emit(const WishlistSuccess([]));
    } catch (e) {
      emit(WishlistFailure(e.toString()));
    }
  }

  List<ProductModel> getWishlistItems() {
    final wishlistIds = wishlistService.getWhishListIds();
    return availableProducts
        .where((product) => wishlistIds.contains(product.id))
        .toList();
  }

  bool isProductInWishlist(String productId) =>
      wishlistService.isProductInWhishList(productId);

  void refreshWishlist() {
    try {
      final allProducts = AllProductsService.getAllProducts();
      availableProducts = allProducts;
      final wishlistIds = wishlistService.getWhishListIds();
      final featuredItems = allProducts
          .where((product) => wishlistIds.contains(product.id))
          .toList();
      emit(WishlistSuccess(featuredItems));
    } catch (e) {
      emit(WishlistFailure(e.toString()));
    }
  }
}
