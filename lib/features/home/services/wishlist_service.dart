class WishListService {
  // Will store the ids of the products that are added to the wishlist
  final Set<String> wishlistIds = {};

  // Singleton instance
  static final WishListService _instance = WishListService._internal();

  // Private constructor
  WishListService._internal();

  // Factory constructor
  factory WishListService() {
    return _instance;
  }

  // Returns the ids of the products that are added to the wishlist
  Set<String> getWishlistIds() => wishlistIds;

  bool isProductInWishlist(String? productId) {
    if (productId == null) return false;
    return wishlistIds.contains(productId);
  }

  void toggleWishlist(String productId) => wishlistIds.contains(productId)
      ? wishlistIds.remove(productId)
      : wishlistIds.add(productId);

  void removeFromWishlist(String? furnitureId) {
    if (furnitureId != null) {
      wishlistIds.remove(furnitureId);
    }
  }

  void clearWishlist() => wishlistIds.clear();
}
