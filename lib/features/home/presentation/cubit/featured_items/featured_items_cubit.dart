import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/repositories/product_repo.dart';
import 'featured_items_state.dart';

class FeaturedItemsCubit extends Cubit<FeaturedItemsState> {
  final ProductRepo _productRepository;

  FeaturedItemsCubit(this._productRepository) : super(FeaturedItemsInitial());

  Future<void> fetchFeaturedItems() async {
    emit(FeaturedItemsLoading());
    try {
      final products = await _productRepository.getFeaturedItems();
      emit(FeaturedItemsSuccess(products));
    } catch (e) {
      emit(FeaturedItemsFailure(e.toString()));
    }
  }
}
