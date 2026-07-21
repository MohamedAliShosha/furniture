import '../../../home/data/models/special_offer_model.dart';

abstract class SpecialOfferState {
  const SpecialOfferState();
}

class SpecialOfferInitial extends SpecialOfferState {}

class SpecialOfferLoading extends SpecialOfferState {}

class SpecialOfferSuccess extends SpecialOfferState {
  final List<SpecialOfferModel> offers;

  const SpecialOfferSuccess(this.offers);
}

class SpecialOfferFailure extends SpecialOfferState {
  final String message;

  const SpecialOfferFailure(this.message);
}
