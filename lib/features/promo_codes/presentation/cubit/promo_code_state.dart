import 'package:furniture/features/promo_codes/data/models/promo_code_model.dart';

abstract class PromoCodeState {
  const PromoCodeState();
}

class PromoCodeInitial extends PromoCodeState {}

class PromoCodeLoading extends PromoCodeState {}

class PromoCodeSuccess extends PromoCodeState {
  final List<PromoCodeModel> availablePromoCodes;
  final List<PromoCodeModel> usedPromoCodes;

  const PromoCodeSuccess(this.availablePromoCodes, this.usedPromoCodes);
}

class PromoCodeFailure extends PromoCodeState {
  final String message;

  const PromoCodeFailure(this.message);
}
