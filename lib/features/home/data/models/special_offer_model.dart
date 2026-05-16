class SpecialOfferModel {
  final String id;
  final String title;
  final String description;
  final int discountPercentage;
  final DateTime startDate;
  final DateTime endDate;
  final List<String>? applicableCategories;
  final List<String>? applicableProductsIds;
  final double? minimumPurchaseAmount;
  final bool isActive;

  SpecialOfferModel({
    required this.id,
    required this.title,
    required this.description,
    required this.discountPercentage,
    required this.startDate,
    required this.endDate,
    this.applicableCategories,
    this.applicableProductsIds,
    this.minimumPurchaseAmount,
    this.isActive = true,
  });

  bool isApplicableToProduct(String productId, String productCategory,
      double productPrice, List<String> productSpecialOfferIds) {
    if (!isActive) {
      return false;
    }
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final start = DateTime(startDate.year, startDate.month, startDate.day);
    final end = DateTime(endDate.year, endDate.month, endDate.day);
    if (today.isBefore(start) || today.isAfter(end)) {
      return false;
    }
    
    // Check minimum purchase amount
    if (minimumPurchaseAmount != null && productPrice < minimumPurchaseAmount!) {
      return false;
    }
    
    // Check if product is explicitly applicable by ID
    if (applicableProductsIds != null && applicableProductsIds!.isNotEmpty) {
      if (applicableProductsIds!.contains(productId)) {
        return true;
      }
    }
    
    // Check if product category is applicable
    if (applicableCategories != null && applicableCategories!.isNotEmpty) {
      if (applicableCategories!.contains(productCategory)) {
        return true;
      }
    }
    
    // If neither applicableCategories nor applicableProductsIds are set, offer applies to all products
    if ((applicableCategories == null || applicableCategories!.isEmpty) &&
        (applicableProductsIds == null || applicableProductsIds!.isEmpty)) {
      return true;
    }
    
    return false;
  }
}
