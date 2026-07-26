import 'package:furniture/features/orders/data/models/shipping_address_model.dart';
import '../enums/order_status_enum.dart';
import 'order_item_model.dart';

///  Contains the order data like id, date, total, subtotal, status, shippingCost, discount, total, promoCode, trackingNumber, estimatedDelivery, paymentMethod, object of the ShippingAddressModel, and a list of OrderItemModel
class OrderModel {
  final String id;
  final List<OrderItemModel> orderItems;
  final DateTime orderDate;
  final OrderStatusEnum status;
  final double subTotal;
  final double shippingCost;
  final double discount;
  final double total;
  final ShippingAddressModel shippingAddressModel;
  final String? promoCode;
  final String? trackingNumber;
  final DateTime? estimatedDelivery;
  final String? paymentMethod;

  OrderModel({
    required this.id,
    required this.orderItems,
    required this.orderDate,
    required this.status,
    required this.subTotal,
    required this.shippingCost,
    required this.discount,
    required this.total,
    required this.shippingAddressModel,
    this.promoCode,
    this.trackingNumber,
    this.estimatedDelivery,
    this.paymentMethod,
  });

  bool get isActive =>
      status != OrderStatusEnum.delivered &&
      status != OrderStatusEnum.cancelled;
  bool get isCompleted => status == OrderStatusEnum.delivered;
  bool get isCancelled => status == OrderStatusEnum.cancelled;

  // Creates a copy of the OrderModel with the given fields replaced that enables me to create new copies with new data
  OrderModel orderModelCopy({
    String? id,
    List<OrderItemModel>? orderItems,
    DateTime? orderDate,
    OrderStatusEnum? status,
    double? subTotal,
    double? shippingCost,
    double? discount,
    double? total,
    ShippingAddressModel? shippingAddressModel,
    String? promoCode,
    String? trackingNumber,
    DateTime? estimatedDelivery,
    String? paymentMethod,
  }) {
    return OrderModel(
      id: id ?? this.id,
      orderItems: orderItems ?? this.orderItems,
      orderDate: orderDate ?? this.orderDate,
      status: status ?? this.status,
      subTotal: subTotal ?? this.subTotal,
      shippingCost: shippingCost ?? this.shippingCost,
      discount: discount ?? this.discount,
      total: total ?? this.total,
      shippingAddressModel: shippingAddressModel ?? this.shippingAddressModel,
      promoCode: promoCode ?? this.promoCode,
      trackingNumber: trackingNumber ?? this.trackingNumber,
      estimatedDelivery: estimatedDelivery ?? this.estimatedDelivery,
      paymentMethod: paymentMethod ?? this.paymentMethod,
    );
  }

  Map<String, dynamic> orderModelToJson() {
    return {
      'id': id,
      'orderItems':
          orderItems.map((item) => item.orderItemModelToJson()).toList(),
      'orderDate': orderDate.toIso8601String(),
      'status': status.toString(),
      'subTotal': subTotal,
      'shippingCost': shippingCost,
      'discount': discount,
      'total': total,
      'shippingAddress': shippingAddressModel.toJson(),
      'promoCode': promoCode,
      'trackingNumber': trackingNumber,
      'estimatedDelivery': estimatedDelivery?.toIso8601String(),
      'paymentMethod': paymentMethod,
    };
  }

  factory OrderModel.fromJson(Map<String, dynamic> jsonData) {
    return OrderModel(
      id: jsonData['id'],
      orderItems: (jsonData['orderItems'] as List)
          .map<OrderItemModel>((item) => OrderItemModel.fromJson(item))
          .toList(),
      orderDate: DateTime.parse(jsonData['orderDate']),
      status: OrderStatusEnum.values.firstWhere(
        (status) => status.toString() == jsonData['status'],
      ),
      subTotal: jsonData['subTotal'],
      shippingCost: jsonData['shippingCost'],
      discount: jsonData['discount'],
      total: jsonData['total'],
      shippingAddressModel:
          ShippingAddressModel.fromJson(jsonData['shippingAddress']),
      promoCode: jsonData['promoCode'],
      trackingNumber: jsonData['trackingNumber'],
      estimatedDelivery: jsonData['estimatedDelivery'] != null
          ? DateTime.parse(jsonData['estimatedDelivery'])
          : null,
      paymentMethod: jsonData['paymentMethod'],
    );
  }
}
