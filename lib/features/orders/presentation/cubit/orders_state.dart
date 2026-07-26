import '../../data/models/order_model.dart';

abstract class OrdersState {
  const OrdersState();
}

class OrderInitial extends OrdersState {}

class OrderLoading extends OrdersState {}

class OrderSuccess extends OrdersState {
  final List<OrderModel> orders;

  const OrderSuccess(this.orders);
}

class OrderFailure extends OrdersState {
  final String message;

  const OrderFailure(this.message);
}
