import '../data/models/product_model.dart';
import '../data/models/category_model.dart';
import 'category_service.dart';
import 'chair_service.dart';
import 'table_service.dart';
import 'light_service.dart';
import 'decoration_service.dart';
import 'sofa_service.dart';
import 'bed_service.dart';

class AllProductsService {
  String? searchQuery;
  static List<ProductModel> getFeaturedItems() {
    return [
      ...ChairService.getChairs().sublist(0, 2),
      ...TableService.getTables().sublist(0, 2),
      ...LightService.getLightings().sublist(0, 2),
      ...DecorationService.getDecorations().sublist(0, 2),
      ...SofaService.getSofas().sublist(0, 2),
      ...BedService.getBeds().sublist(0, 2),
    ];
  }

  static List<ProductModel> getAllProducts() {
    return [
      ...ChairService.getChairs(),
      ...TableService.getTables(),
      ...LightService.getLightings(),
      ...DecorationService.getDecorations(),
      ...SofaService.getSofas(),
      ...BedService.getBeds(),
    ];
  }

  static List<CategoryModel> getCategories() {
    return CategoryService.getCategories();
  }

  static List<ProductModel> getProductsByCategory(String category) {
    switch (category.toUpperCase()) {
      case 'ALL':
        return getAllProducts();
      case 'CHAIRS':
        return ChairService.getChairs();
      case 'TABLES':
        return TableService.getTables();
      case 'LIGHTINGS':
        return LightService.getLightings();
      case 'DECORATION':
        return DecorationService.getDecorations();
      case 'SOFAS':
        return SofaService.getSofas();
      case 'BEDS':
        return BedService.getBeds();
      default:
        return getAllProducts();
    }
  }

  void setSearchQuery(String query) {
    searchQuery = query;
  }

  void toggleFavorite(String id) {
    final productIndex =
        getAllProducts().indexWhere((element) => element.id == id);
    if (productIndex >= 0) {
      getAllProducts()[productIndex].isFavorite =
          !getAllProducts()[productIndex].isFavorite;
    }
  }
}
