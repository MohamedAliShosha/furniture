import 'package:furniture/features/payment_methods/data/models/payment_method_model.dart';

abstract class PaymentMethodState {
  const PaymentMethodState();
}

class PaymentMethodInitial extends PaymentMethodState {}

class PaymentMethodLoading extends PaymentMethodState {}

class PaymentMethodSuccess extends PaymentMethodState {
  final List<PaymentMethodModel> paymentMethods;

  const PaymentMethodSuccess(this.paymentMethods);
}

class PaymentMethodFailure extends PaymentMethodState {
  final String message;

  const PaymentMethodFailure(this.message);
}
