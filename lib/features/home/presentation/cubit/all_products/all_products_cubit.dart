import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/repositories/product_repo.dart';
import 'all_products_state.dart';

class AllProductsCubit extends Cubit<AllProductsState> {
  final ProductRepo productRepo;

  AllProductsCubit(this.productRepo) : super(AllProductsInitial());

  Future<void> fetchAllProducts() async {
    emit(AllProductsLoading());
    try {
      final products = await productRepo.getAllProducts();
      emit(AllProductsSuccess(products));
    } catch (e) {
      emit(AllProductsFailure(e.toString()));
    }
  }
}
