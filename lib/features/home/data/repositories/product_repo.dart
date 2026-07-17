import '../../data/models/product_model.dart';
import '../../data/models/category_model.dart';

abstract class ProductRepo {
  Future<List<ProductModel>> getFeaturedItems();
  Future<List<ProductModel>> getAllProducts();
  Future<List<ProductModel>> getProductsByCategory(String category);
  List<CategoryModel> getCategories();
}
