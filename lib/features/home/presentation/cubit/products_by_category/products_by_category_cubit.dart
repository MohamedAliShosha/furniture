import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/repositories/product_repo.dart';
import 'products_by_category_state.dart';

class ProductsByCategoryCubit extends Cubit<ProductsByCategoryState> {
  final ProductRepo _productRepository;

  ProductsByCategoryCubit(this._productRepository)
      : super(ProductsByCategoryInitial());

  Future<void> fetchProductsByCategory(String category) async {
    emit(ProductsByCategoryLoading());
    try {
      final products = await _productRepository.getProductsByCategory(category);
      emit(ProductsByCategorySuccess(products));
    } catch (e) {
      emit(ProductsByCategoryFailure(e.toString()));
    }
  }
}
