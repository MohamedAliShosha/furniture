class WishListService {
  // Will store the ids of the products that are added to the whishList
  final Set<String> whishListIds = {};

  // Returns the ids of the products that are added to the whishList
  Set<String> getWhishListIds() => whishListIds;

  bool isProductInWhishList(String? furnitureId) =>
      whishListIds.contains(furnitureId);

  void toggleWhishList(String furnitureId) => whishListIds.contains(furnitureId)
      ? whishListIds.remove(furnitureId)
      : whishListIds.add(furnitureId);

  void removeFromWhishList(String? furnitureId) =>
      whishListIds.remove(furnitureId);

  void clearWhishList() => whishListIds.clear();
}
