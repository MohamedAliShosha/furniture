import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/repositories/product_repo.dart';
import 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  final ProductRepo _productRepository;

  CategoriesCubit(this._productRepository) : super(CategoriesInitial());

  Future<void> fetchCategories() async {
    emit(
      CategoriesLoading(),
    );
    try {
      final categories = _productRepository.getCategories();
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
