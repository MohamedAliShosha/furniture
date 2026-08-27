import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:furniture/core/utils/app_images.dart';
import 'package:furniture/features/auth/services/database_service.dart';
import 'package:furniture/features/home/data/models/product_model.dart';
import 'package:furniture/features/orders/data/models/shipping_address_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import '../../../core/utils/app_texts.dart';
import '../data/enums/order_status_enum.dart';
import '../data/models/order_item_model.dart';
import '../data/models/order_model.dart';

class OrdersService {
  List<OrderModel> _orders = [];
  final String _ordersKey = AppTexts.ordersKey;
  final _uuid = const Uuid();
  final DatabaseService _databaseService;

  OrdersService(this._databaseService);

  String? get _userId => FirebaseAuth.instance.currentUser?.uid;

  List<OrderModel> getOrders() => _orders;

  List<OrderModel> get activeOrders =>
      _orders.where((order) => order.isActive).toList();

  List<OrderModel> get completedOrders =>
      _orders.where((order) => order.isCompleted).toList();

  List<OrderModel> get cancelledOrders =>
      _orders.where((order) => order.isCancelled).toList();

  Future<void> loadOrders() async {
    if (_userId != null) {
      try {
        final ordersData = await _databaseService.getData(
          path: 'users/$_userId/orders',
          query: {
            'orderBy': 'orderDate',
            'descending': true,
          },
        );

        if (ordersData is List) {
          _orders = ordersData
              .map<OrderModel>((data) => OrderModel.fromJson(data))
              .toList();
          await _saveOrders();
          return;
        }
      } catch (e) {
        debugPrint('Error loading orders from Firestore: $e');
      }
    }

    final prefs = await SharedPreferences.getInstance();
    final storedOrders = prefs.getString(_ordersKey);

    if (storedOrders != null) {
      final List<dynamic> decodedOrders = jsonDecode(storedOrders);
      _orders = decodedOrders
          .map<OrderModel>((order) => OrderModel.fromJson(order))
          .toList();
    } else {
      await _addSampleOrders();
    }
  }

  Future<void> loadActiveOrders() async {
    if (_userId != null) {
      try {
        final ordersData = await _databaseService.getData(
          path: 'users/$_userId/orders',
          query: {
            'orderBy': 'orderDate',
            'descending': true,
          },
          where: {
            'field': 'status',
            'whereIn': [
              OrderStatusEnum.confirmed.toString(),
              OrderStatusEnum.processing.toString(),
              OrderStatusEnum.shipped.toString(),
              OrderStatusEnum.outForDelivery.toString(),
            ],
          },
        );

        if (ordersData is List) {
          final activeOrders = ordersData
              .map<OrderModel>((data) => OrderModel.fromJson(data))
              .toList();
          for (final order in activeOrders) {
            if (!_orders.any((o) => o.id == order.id)) {
              _orders.add(order);
            }
          }
          await _saveOrders();
          return;
        }
      } catch (e) {
        debugPrint('Error loading active orders from Firestore: $e');
      }
    }

    _orders = _orders.where((order) => order.isActive).toList();
  }

  Future<void> loadCompletedOrders() async {
    if (_userId != null) {
      try {
        final ordersData = await _databaseService.getData(
          path: 'users/$_userId/orders',
          query: {
            'orderBy': 'orderDate',
            'descending': true,
          },
          where: {
            'field': 'status',
            'isEqualTo': OrderStatusEnum.delivered.toString(),
          },
        );

        if (ordersData is List) {
          final completedOrders = ordersData
              .map<OrderModel>((data) => OrderModel.fromJson(data))
              .toList();
          for (final order in completedOrders) {
            if (!_orders.any((o) => o.id == order.id)) {
              _orders.add(order);
            }
          }
          await _saveOrders();
          return;
        }
      } catch (e) {
        debugPrint('Error loading completed orders from Firestore: $e');
      }
    }

    _orders = _orders.where((order) => order.isCompleted).toList();
  }

  Future<void> loadCancelledOrders() async {
    if (_userId != null) {
      try {
        final ordersData = await _databaseService.getData(
          path: 'users/$_userId/orders',
          query: {
            'orderBy': 'orderDate',
            'descending': true,
          },
          where: {
            'field': 'status',
            'isEqualTo': OrderStatusEnum.cancelled.toString(),
          },
        );

        if (ordersData is List) {
          final cancelledOrders = ordersData
              .map<OrderModel>((data) => OrderModel.fromJson(data))
              .toList();
          for (final order in cancelledOrders) {
            if (!_orders.any((o) => o.id == order.id)) {
              _orders.add(order);
            }
          }
          await _saveOrders();
          return;
        }
      } catch (e) {
        debugPrint('Error loading cancelled orders from Firestore: $e');
      }
    }

    _orders = _orders.where((order) => order.isCancelled).toList();
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
      state: 'NY',
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

  Future<void> addOrder(OrderModel order) async {
    final newOrder = order.orderModelCopy(
      id: _uuid.v4(),
      orderDate: DateTime.now(),
      status: OrderStatusEnum.processing,
      estimatedDelivery: DateTime.now().add(
        const Duration(days: 5),
      ),
    );
    _orders.add(newOrder);

    if (_userId != null) {
      try {
        await _databaseService.addData(
          path: 'users/$_userId/orders',
          data: {
            'orderId': newOrder.id,
            ...newOrder.orderModelToJson(),
          },
          documentId: newOrder.id,
        );
      } catch (e) {
        debugPrint('Error saving order to Firestore: $e');
        rethrow;
      }
    } else {
      debugPrint('User is not logged in. Order saved locally only.');
    }

    await _saveOrders();
  }

  Future<void> clearOrders() async {
    _orders.clear();

    if (_userId != null) {
      try {
        final ordersData = await _databaseService.getData(
          path: 'users/$_userId/orders',
        );

        if (ordersData is List) {
          for (var orderData in ordersData) {
            final orderId = orderData['id'] as String;
            await _databaseService.deleteData(
              path: 'users/$_userId/orders',
              documentId: orderId,
            );
          }
        }
      } catch (e) {
        debugPrint('Error clearing orders from Firestore: $e');
      }
    }

    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_ordersKey);
  }

  Future<void> completeOrder(String orderId) async =>
      await _updateOrderStatus(orderId, OrderStatusEnum.delivered);

  Future<void> cancelOrder(String orderId) async =>
      await _updateOrderStatus(orderId, OrderStatusEnum.cancelled);

  Future<void> _updateOrderStatus(
      String orderId, OrderStatusEnum newStatus) async {
    final index = _orders.indexWhere((order) => order.id == orderId);
    if (index != -1) {
      _orders[index] = _orders[index].orderModelCopy(status: newStatus);

      if (newStatus == OrderStatusEnum.shipped) {
        _orders[index] = _orders[index].orderModelCopy(
          trackingNumber: 'TRK${DateTime.now().millisecondsSinceEpoch}',
        );
      }

      if (_userId != null) {
        try {
          await _databaseService.updateData(
            path: 'users/$_userId/orders',
            documentId: orderId,
            data: {
              'orderId': _orders[index].id,
              ..._orders[index].orderModelToJson(),
            },
          );
        } catch (e) {
          debugPrint('Error updating order in Firestore: $e');
        }
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
