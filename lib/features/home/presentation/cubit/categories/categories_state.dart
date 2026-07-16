import '../../../data/models/category_model.dart';

abstract class CategoriesState {
  const CategoriesState();
}

class CategoriesInitial extends CategoriesState {}

class CategoriesLoading extends CategoriesState {}

class CategoriesSuccess extends CategoriesState {
  final List<CategoryModel> categories;

  const CategoriesSuccess(this.categories);
}

class CategoriesFailure extends CategoriesState {
  final String message;

  const CategoriesFailure(this.message);
}
