import '../../data/models/category_model.dart';

abstract class CategoryRepo {
  List<CategoryModel> getCategories();
}
