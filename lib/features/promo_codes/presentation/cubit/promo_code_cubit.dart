import 'package:flutter_bloc/flutter_bloc.dart';
import '../../service/promo_code_service.dart';
import 'promo_code_state.dart';

class PromoCodeCubit extends Cubit<PromoCodeState> {
  final PromoCodeService promoCodeService;

  PromoCodeCubit(this.promoCodeService) : super(PromoCodeInitial());

  Future<void> loadPromoCodes() async {
    if (isClosed) return;
    emit(PromoCodeLoading());
    try {
      await promoCodeService.loadPromoCodes();
      final availablePromos = promoCodeService.getAvailablePromoCodes();
      final usedPromos = promoCodeService.getUsedPromoCodes();
      if (!isClosed) {
        emit(PromoCodeSuccess(availablePromos, usedPromos));
      }
    } catch (e) {
      if (!isClosed) {
        emit(PromoCodeFailure(e.toString()));
      }
    }
  }

  Future<bool> addPromoCode(String code) async {
    if (isClosed) return false;
    try {
      final success = await promoCodeService.addPromoCode(code);
      if (success) {
        final availablePromos = promoCodeService.getAvailablePromoCodes();
        final usedPromos = promoCodeService.getUsedPromoCodes();
        if (!isClosed) {
          emit(
            PromoCodeSuccess(availablePromos, usedPromos),
          );
        }
      }
      return success;
    } catch (e) {
      if (!isClosed) {
        emit(
          PromoCodeFailure(
            e.toString(),
          ),
        );
      }
      return false;
    }
  }

  Future<void> usePromoCode(String code) async {
    if (isClosed) return;
    try {
      await promoCodeService.usePromoCode(code);
      final availablePromos = promoCodeService.getAvailablePromoCodes();
      final usedPromos = promoCodeService.getUsedPromoCodes();
      if (!isClosed) {
        emit(PromoCodeSuccess(availablePromos, usedPromos));
      }
    } catch (e) {
      if (!isClosed) {
        emit(PromoCodeFailure(e.toString()));
      }
    }
  }
}
