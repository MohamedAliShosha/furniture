import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:furniture/core/utils/app_texts.dart';
import 'package:furniture/features/payment_methods/data/models/payment_method_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class PaymentMethodService {
  List<PaymentMethodModel> _paymentMethods = [];
  final String _paymentMethodsKey = AppTexts.paymentMethodsKey;
  final _uuid = const Uuid();

  List<PaymentMethodModel> getPaymentMethods() => _paymentMethods;

  PaymentMethodModel? get defaultPaymentMethod {
    if (_paymentMethods.isEmpty) return null;
    return _paymentMethods.firstWhere(
      (method) => method.isDefault,
      orElse: () => _paymentMethods.first,
    );
  }

  Future<void> loadPaymentMethods() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final storedMethods = prefs.getString(_paymentMethodsKey);

      if (storedMethods != null) {
        final List<dynamic> decodedMethods = jsonDecode(storedMethods);
        _paymentMethods = decodedMethods
            .map<PaymentMethodModel>(
                (method) => PaymentMethodModel.fromJson(method))
            .toList();
      } else {
        await _addSamplePaymentMethods();
      }
    } on Exception catch (e) {
      debugPrint('Error loading payment method: $e');
    }
  }

  Future<void> _addSamplePaymentMethods() async {
    final sampleMethod = PaymentMethodModel(
      id: _uuid.v4(),
      cardType: 'Visa',
      cardNumber: '**** **** **** 1234',
      expireDate: '12/26',
      cardHolderName: 'John Doe',
      isDefault: true,
      cardColors: '0XFF1A237E',
    );

    _paymentMethods.add(sampleMethod);
    await _savePaymentMethods();
  }

  Future<void> _savePaymentMethods() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String encodedMethods =
          jsonEncode(_paymentMethods.map((method) => method.toJson()).toList());
      await prefs.setString(_paymentMethodsKey, encodedMethods);
    } on Exception catch (e) {
      debugPrint('Error saving payment method: $e');
    }
  }

  Future<void> addPaymentMethod(PaymentMethodModel paymentMethodModel) async {
    final newPaymentMethod = paymentMethodModel.paymentMethodModelCopy(
      id: _uuid.v4(),
    );
    if (_paymentMethods.isEmpty || paymentMethodModel.isDefault) {
      _paymentMethods = _paymentMethods
          .map((m) => m.paymentMethodModelCopy(isDefault: false))
          .toList();
    }
    _paymentMethods.add(newPaymentMethod);
    await _savePaymentMethods();
  }

  Future<void> updatePaymentMethod(PaymentMethodModel method) async {
    final methodIndex = _paymentMethods.indexWhere((m) => m.id == method.id);
    if (methodIndex != -1) {
      if (method.isDefault) {
        // if this method is being set as default, update all other methods
        _paymentMethods = _paymentMethods
            .map(
              (m) => m.id == method.id
                  ? method
                  : m.paymentMethodModelCopy(isDefault: false),
            )
            .toList();
      } else {
        if (_paymentMethods[methodIndex].isDefault &&
            !method.isDefault &&
            _paymentMethods.length > 1) {
          final newDefault =
              _paymentMethods.firstWhere((m) => m.id != method.id);
          final newDefaultIndex = _paymentMethods.indexOf(newDefault);
          _paymentMethods[newDefaultIndex] =
              newDefault.paymentMethodModelCopy(isDefault: true);
        }
        _paymentMethods[methodIndex] = method;
      }
      await _savePaymentMethods();
    }
  }

  Future<void> deletePaymentMethod(String id) async {
    final index = _paymentMethods.indexWhere((m) => m.id == id);
    if (index != -1) {
      final wasDefault = _paymentMethods[index].isDefault;
      _paymentMethods.removeAt(index);

      // If we removed the default method and there are other methods
      // make the first one the default

      if (wasDefault && _paymentMethods.isNotEmpty) {
        _paymentMethods[0] =
            _paymentMethods[0].paymentMethodModelCopy(isDefault: true);
      }
      await _savePaymentMethods();
    }
  }

  Future<void> setDefaultPaymentMethod(String id) async {
    final index = _paymentMethods.indexWhere((m) => m.id == id);
    if (index != -1) {
      _paymentMethods = _paymentMethods
          .map(
            (m) => m.id == id
                ? m.paymentMethodModelCopy(isDefault: true)
                : m.paymentMethodModelCopy(isDefault: false),
          )
          .toList();
      await _savePaymentMethods();
    }
  }
}
