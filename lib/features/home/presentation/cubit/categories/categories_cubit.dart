import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/repositories/category_repo.dart';
import 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  final CategoryRepo _categoryRepo;

  CategoriesCubit(this._categoryRepo) : super(CategoriesInitial());

  Future<void> fetchCategories() async {
    emit(
      CategoriesLoading(),
    );
    try {
      final categories = _categoryRepo.getCategories();
      emit(
        CategoriesSuccess(categories),
      );
    } catch (e) {
      emit(
        CategoriesFailure(
          e.toString(),
        ),
      );
    }
  }
}
