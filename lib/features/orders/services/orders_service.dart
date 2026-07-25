import 'dart:convert';
import 'package:furniture/core/utils/app_images.dart';
import 'package:furniture/features/home/data/models/product_model.dart';
import 'package:furniture/features/orders/data/models/shipping_address_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import '../../../core/utils/app_texts.dart';
import '../data/enums/order_status_enum.dart';
import '../data/models/order_item_model.dart';
import '../data/models/order_model.dart';

class OrdersService {
  ///  Stores the orders placed by the user
  List<OrderModel> _orders = [];
  final String _ordersKey = AppTexts.ordersKey;
  final _uuid = const Uuid();

  ///  Returns all orders
  List<OrderModel> getOrders() => _orders;

  ///  Returns only active orders
  List<OrderModel> get activeOrders =>
      _orders.where((order) => order.isActive).toList();

  // Returns only completed orders
  List<OrderModel> get completedOrders =>
      _orders.where((order) => order.isCompleted).toList();

  // Returns only cancelled orders
  List<OrderModel> get cancelledOrders =>
      _orders.where((order) => order.isCancelled).toList();

  /// Loads persisted orders from local storage — call this once at startup
  /// (e.g. from your Cubit's constructor) since there's no init hook here
  Future<void> loadOrders() async {
    // get an instance of SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    // retrieve stored orders
    final storedOrders = prefs.getString(_ordersKey);

    if (storedOrders != null) {
      // if there are stored orders => decode and load them
      // Decoding means converting the JSON string back into a list of order objects
      final List<dynamic> decodedOrders = jsonDecode(storedOrders);
      // After decoding, convert to OrderModel objects using map then grouping them as a list
      _orders = decodedOrders
          .map<OrderModel>((order) => OrderModel.fromJson(order))
          .toList();
    } else {
      // add sample orders if no stored orders exists
      await _addSampleOrders();
    }
  }

  /// adds sample orders to local storage
  Future<void> _addSampleOrders() async {
    final sampleProduct = ProductModel(
      id: '1',
      name: 'Modern Sofa',
      price: 599.99,
      colors: ['Grey', 'Blue'],
      images: ImagesModel(
        gallery: [
          AppImages.sofa1,
          AppImages.sofa2,
          AppImages.sofa3,
          AppImages.sofa4,
          AppImages.sofa5,
          AppImages.sofa6
        ],
      ),
      details: DetailsModel(
        description: 'A comfortable modern sofa',
      ),
    );
    final sampleAddress = ShippingAddressModel(
      id: '1',
      name: 'Home',
      address: '123 Main Street',
      city: 'New York',
      status: 'NY',
      zipcode: '1001',
      phone: '+1 (123) 456-789',
      isDefault: true,
    );

    final now = DateTime.now();
    // Create a list that is called sampleOrders that contains a group of OrderModels
    final sampleOrders = [
      OrderModel(
        id: _uuid.v4(),
        orderItems: [
          OrderItemModel(
            productModel: sampleProduct,
            quantity: 1,
            price: 599.99,
          ),
        ],
        orderDate: now.subtract(
          const Duration(days: 2),
        ),
        status: OrderStatusEnum.processing,
        subTotal: 599.99,
        shippingCost: 0,
        discount: 0,
        total: 599.99,
        shippingAddressModel: sampleAddress,
        estimatedDelivery: now.add(
          const Duration(days: 5),
        ),
      ),
      OrderModel(
          id: _uuid.v4(),
          orderItems: [
            OrderItemModel(
              productModel: sampleProduct,
              quantity: 2,
              price: 599.99,
            ),
          ],
          orderDate: now.subtract(
            const Duration(days: 10),
          ),
          status: OrderStatusEnum.delivered,
          subTotal: 1199.98,
          shippingCost: 0,
          discount: 0,
          total: 1199.98,
          shippingAddressModel: sampleAddress,
          trackingNumber: 'TRX123456789'),
      OrderModel(
        id: _uuid.v4(),
        orderItems: [
          OrderItemModel(
            productModel: sampleProduct,
            quantity: 1,
            price: 599.99,
          ),
        ],
        orderDate: now.subtract(
          const Duration(days: 15),
        ),
        status: OrderStatusEnum.cancelled,
        subTotal: 599.99,
        shippingCost: 0,
        discount: 0,
        total: 599.99,
        shippingAddressModel: sampleAddress,
      )
    ];
    // Adding the orders to the list
    _orders.addAll(sampleOrders);
    // Then saving the orders to shared preferences
    await _saveOrders();
  }

  Future<void> _saveOrders() async {
    final prefs = await SharedPreferences.getInstance();
    // converting orders to JSON to be able to persist them in shared preferences
    final String encodedOrders =
        jsonEncode(_orders.map((order) => order.orderModelToJson()).toList());
    await prefs.setString(_ordersKey, encodedOrders);
  }

  /// Adds a new order to the list and persists it
  Future<void> addOrder(OrderModel order) async {
    // Here I used the copy of the orderModel to create a new instance with updated fields
    final newOrder = order.orderModelCopy(
      id: _uuid.v4(),
      orderDate: DateTime.now(),
      status: OrderStatusEnum.processing,
      estimatedDelivery: DateTime.now().add(
        const Duration(days: 5),
      ),
    );
    _orders.add(newOrder);
    await _saveOrders();
  }

  // Clears all orders
  Future<void> clearOrders() async {
    _orders.clear();
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_ordersKey);
  }

  // Marks an order as completed
  Future<void> completeOrder(String orderId) =>
      _updateOrderStatus(orderId, OrderStatusEnum.delivered);

  // Marks an order as cancelled
  Future<void> cancelOrder(String orderId) =>
      _updateOrderStatus(orderId, OrderStatusEnum.cancelled);

  /// Updates the status of an order
  Future<void> _updateOrderStatus(
      String orderId, OrderStatusEnum newStatus) async {
    // Getting the index of the order that will be updated
    final index = _orders.indexWhere((order) => order.id == orderId);
    // Check if order exists => -1 means that the order was not found
    if (index != -1) {
      // Update the order status
      _orders[index] = _orders[index].orderModelCopy(status: newStatus);

      // add tracking number if shipped
      if (newStatus == OrderStatusEnum.shipped) {
        _orders[index] = _orders[index].orderModelCopy(
          trackingNumber: 'TRK${DateTime.now().millisecondsSinceEpoch}',
        );
      }

      await _saveOrders();
    }
  }

  OrderModel? getOrderById(String orderId) {
    try {
      return _orders.firstWhere((order) => order.id == orderId);
    } catch (e) {
      return null;
    }
  }
}
