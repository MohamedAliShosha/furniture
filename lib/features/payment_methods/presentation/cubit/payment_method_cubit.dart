import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../features/payment_methods/data/models/payment_method_model.dart';
import '../../service/payment_method_service.dart';
import 'payment_method_state.dart';

class PaymentMethodCubit extends Cubit<PaymentMethodState> {
  final PaymentMethodService paymentMethodService;

  PaymentMethodCubit(this.paymentMethodService) : super(PaymentMethodInitial());

  Future<void> loadPaymentMethods() async {
    if (isClosed) return;
    emit(PaymentMethodLoading());
    try {
      await paymentMethodService.loadPaymentMethods();
      final methods = paymentMethodService.getPaymentMethods();
      if (!isClosed) {
        emit(PaymentMethodSuccess(methods));
      }
    } catch (e) {
      if (!isClosed) {
        emit(PaymentMethodFailure(e.toString()));
      }
    }
  }

  Future<void> addPaymentMethod(PaymentMethodModel method) async {
    // prevents any emit attempts on a closed cubit.
    if (isClosed) return;
    try {
      await paymentMethodService.addPaymentMethod(method);
      final methods = paymentMethodService.getPaymentMethods();
      if (!isClosed) {
        emit(PaymentMethodSuccess(methods));
      }
    } catch (e) {
      if (!isClosed) {
        emit(PaymentMethodFailure(e.toString()));
      }
    }
  }

  Future<void> updatePaymentMethod(PaymentMethodModel method) async {
    if (isClosed) return;
    try {
      await paymentMethodService.updatePaymentMethod(method);
      final methods = paymentMethodService.getPaymentMethods();
      if (!isClosed) {
        emit(PaymentMethodSuccess(methods));
      }
    } catch (e) {
      if (!isClosed) {
        emit(PaymentMethodFailure(e.toString()));
      }
    }
  }

  Future<void> deletePaymentMethod(String id) async {
    if (isClosed) return;
    try {
      await paymentMethodService.deletePaymentMethod(id);
      final methods = paymentMethodService.getPaymentMethods();
      if (!isClosed) {
        emit(PaymentMethodSuccess(methods));
      }
    } catch (e) {
      if (!isClosed) {
        emit(PaymentMethodFailure(e.toString()));
      }
    }
  }

  Future<void> setDefaultPaymentMethod(String id) async {
    if (isClosed) return;
    try {
      await paymentMethodService.setDefaultPaymentMethod(id);
      final methods = paymentMethodService.getPaymentMethods();
      if (!isClosed) {
        emit(PaymentMethodSuccess(methods));
      }
    } catch (e) {
      if (!isClosed) {
        emit(PaymentMethodFailure(e.toString()));
      }
    }
  }
}
