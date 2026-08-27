import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/order_model.dart';
import '../../services/orders_service.dart';
import 'orders_state.dart';

class OrdersCubit extends Cubit<OrdersState> {
  final OrdersService orderService;

  OrdersCubit(this.orderService) : super(OrderInitial());

  Future<void> loadOrders() async {
    emit(OrderLoading());
    try {
      await orderService.loadOrders();
      final orders = orderService.getOrders();
      emit(
        OrderSuccess(orders),
      );
    } catch (e) {
      emit(
        OrderFailure(
          e.toString(),
        ),
      );
    }
  }

  Future<void> loadActiveOrders() async {
    emit(OrderLoading());
    try {
      await orderService.loadActiveOrders();
      final orders = orderService.activeOrders;
      emit(
        OrderSuccess(orders),
      );
    } catch (e) {
      emit(
        OrderFailure(
          e.toString(),
        ),
      );
    }
  }

  Future<void> loadCompletedOrders() async {
    emit(OrderLoading());
    try {
      await orderService.loadCompletedOrders();
      final orders = orderService.completedOrders;
      emit(
        OrderSuccess(orders),
      );
    } catch (e) {
      emit(
        OrderFailure(
          e.toString(),
        ),
      );
    }
  }

  Future<void> loadCancelledOrders() async {
    emit(OrderLoading());
    try {
      await orderService.loadCancelledOrders();
      final orders = orderService.cancelledOrders;
      emit(
        OrderSuccess(orders),
      );
    } catch (e) {
      emit(
        OrderFailure(
          e.toString(),
        ),
      );
    }
  }

  Future<void> addOrder(OrderModel order) async {
    try {
      await orderService.addOrder(order);
      final orders = orderService.getOrders();
      emit(
        OrderSuccess(orders),
      );
    } catch (e) {
      emit(
        OrderFailure(
          e.toString(),
        ),
      );
      rethrow;
    }
  }

  Future<void> completeOrder(String orderId) async {
    try {
      await orderService.completeOrder(orderId);
      final orders = orderService.getOrders();
      emit(
        OrderSuccess(orders),
      );
    } catch (e) {
      emit(
        OrderFailure(
          e.toString(),
        ),
      );
    }
  }

  Future<void> cancelOrder(String orderId) async {
    try {
      await orderService.cancelOrder(orderId);
      final orders = orderService.getOrders();
      emit(
        OrderSuccess(orders),
      );
    } catch (e) {
      emit(
        OrderFailure(
          e.toString(),
        ),
      );
    }
  }

  Future<void> clearOrders() async {
    try {
      await orderService.clearOrders();
      emit(
        const OrderSuccess([]),
      );
    } catch (e) {
      emit(
        OrderFailure(
          e.toString(),
        ),
      );
    }
  }

  OrderModel? getOrderById(String orderId) {
    return orderService.getOrderById(orderId);
  }
}
