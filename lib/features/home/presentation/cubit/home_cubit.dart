import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furniture/core/utils/app_texts.dart';
import '../../data/repositories/product_repo.dart';
import '../../data/repositories/category_repo.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final ProductRepo _productRepository;
  final CategoryRepo _categoryRepository;

  HomeCubit(
    this._productRepository,
    this._categoryRepository,
  ) : super(
          HomeInitial(),
        );

  Future<void> fetchAllHomeData({String category = AppTexts.allCategory}) async {
    emit(
      HomeLoading(),
    );
    try {
      final featuredProducts = await _productRepository.getFeaturedItems();
      final allProducts = await _productRepository.getAllProducts();
      final categories = _categoryRepository.getCategories();
      final productsByCategory =
          await _productRepository.getProductsByCategory(category);

      emit(HomeSuccess(
        featuredProducts: featuredProducts,
        allProducts: allProducts,
        categories: categories,
        productsByCategory: productsByCategory,
      ));
    } catch (e) {
      emit(
        HomeFailure(
          e.toString(),
        ),
      );
    }
  }
}
