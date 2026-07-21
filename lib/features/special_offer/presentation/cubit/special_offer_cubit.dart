import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../home/services/special_offers_service.dart';
import '../../../home/data/models/product_model.dart';
import '../../../home/data/models/special_offer_model.dart';
import '../../../home/data/repositories/product_repo.dart';
import 'special_offer_state.dart';

class SpecialOfferCubit extends Cubit<SpecialOfferState> {
  final SpecialOffersService _specialOffersService;
  final ProductRepo _productRepo;
  List<ProductModel> _allProducts = [];

  SpecialOfferCubit(this._specialOffersService, this._productRepo) : super(SpecialOfferInitial());

  List<SpecialOfferModel> getOffers() {
    return _specialOffersService.specialOffersList;
  }

  SpecialOfferModel? getOfferById(String id) {
    return _specialOffersService.getOfferById(id);
  }

  List<SpecialOfferModel> getApplicableOffers(ProductModel product) {
    return _specialOffersService.getApplicableOffers(product);
  }

  SpecialOfferModel? getBestOffer(ProductModel product) {
    return _specialOffersService.getBestOffer(product);
  }

  double getDiscountedPrice(ProductModel product) {
    return _specialOffersService.getDiscountedPrice(product);
  }

  List<ProductModel> getApplicableItems(SpecialOfferModel offer) {
    return _allProducts.where((item) {
      return offer.isApplicableToProduct(
        item.id,
        item.category ?? '',
        item.price,
        item.specialOffersIds ?? [],
      );
    }).toList();
  }

  Future<void> fetchOffers() async {
    emit(SpecialOfferLoading());
    try {
      final offers = _specialOffersService.specialOffersList;
      _allProducts = await _productRepo.getAllProducts();
      emit(SpecialOfferSuccess(offers));
    } catch (e) {
      emit(SpecialOfferFailure(e.toString()));
    }
  }
}
