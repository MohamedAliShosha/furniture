import 'category_repo.dart';
import '../../../../features/home/services/category_service.dart';
import '../../../../features/home/data/models/category_model.dart';

class CategoryRepoImpl implements CategoryRepo {
  @override
  List<CategoryModel> getCategories() {
    return CategoryService.getCategories();
  }
}
