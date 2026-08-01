import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:furniture/core/utils/app_texts.dart';
import 'package:furniture/features/promo_codes/data/models/promo_code_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PromoCodeService {
  List<PromoCodeModel> _promoCodes = [];
  final String _promoCodesKey = AppTexts.promoCodesKey;

  List<PromoCodeModel> getPromoCodes() => _promoCodes;

  List<PromoCodeModel> getAvailablePromoCodes() =>
      _promoCodes.where((promo) => !promo.isUsed && !promo.isExpired).toList();

  List<PromoCodeModel> getUsedPromoCodes() =>
      _promoCodes.where((promo) => promo.isUsed || promo.isExpired).toList();

  Future<void> loadPromoCodes() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? storedCodes = prefs.getString(_promoCodesKey);

      if (storedCodes != null) {
        final List<dynamic> decodedPromos = jsonDecode(storedCodes);
        _promoCodes = decodedPromos
            .map<PromoCodeModel>((promo) => PromoCodeModel.fromJson(promo))
            .toList();
      }
      if (_promoCodes.isEmpty) {
        await _addSamplePromoCodes();
      }
    } on Exception catch (e) {
      debugPrint('Error loading promo codes: $e');
    }
  }

  Future<void> _addSamplePromoCodes() async {
    final now = DateTime.now();
    final samplePromos = [
      PromoCodeModel(
        code: 'WELCOME10',
        discount: AppTexts.welcome10Discount,
        description: AppTexts.welcome10Description,
        validateUntil: now.add(const Duration(days: 30)),
        isPercentage: true,
      ),
      PromoCodeModel(
        code: 'FREESHIP',
        discount: AppTexts.freeShipDiscount,
        description: AppTexts.freeShipDescription,
        validateUntil: now.add(const Duration(days: 45)),
        isPercentage: false,
      ),
      PromoCodeModel(
        code: 'FLAT50',
        discount: AppTexts.flat50Discount,
        description: AppTexts.flat50Description,
        validateUntil: now.add(const Duration(days: 15)),
        isPercentage: true,
      ),
      PromoCodeModel(
        code: 'SUMMER20',
        discount: AppTexts.summer20Discount,
        description: AppTexts.summer20Description,
        validateUntil: now.add(const Duration(days: 60)),
        isPercentage: true,
        isUsed: false,
      ),
    ];

    _promoCodes.addAll(samplePromos);
    await _savePromoCodes();
  }

  Future<void> _savePromoCodes() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String encodedPromos =
          jsonEncode(_promoCodes.map((promo) => promo.toJson()).toList());
      await prefs.setString(_promoCodesKey, encodedPromos);
    } on Exception catch (e) {
      debugPrint('Error saving promo codes: $e');
    }
  }

  Future<bool> addPromoCode(String code) async {
    // check if code already exists
    if (_promoCodes.any((promoCode) => promoCode.code == code.toUpperCase())) {
      return false;
    }
    // mock validation for specific promo code
    final validCodes = {
      'WELCOME10': PromoCodeModel(
        code: 'WELCOME10',
        discount: AppTexts.welcome10Discount,
        description: AppTexts.welcome10Description,
        validateUntil: DateTime.now().add(const Duration(days: 30)),
        isPercentage: true,
      ),
      'FREESHIP': PromoCodeModel(
        code: 'FREESHIP',
        discount: AppTexts.freeShipDiscount,
        description: AppTexts.freeShipDescription,
        validateUntil: DateTime.now().add(const Duration(days: 45)),
        isPercentage: false,
      ),
      'FLAT50': PromoCodeModel(
        code: 'FLAT50',
        discount: AppTexts.flat50Discount,
        description: AppTexts.flat50Description,
        validateUntil: DateTime.now().add(const Duration(days: 15)),
        isPercentage: true,
      ),
      'SUMMER20': PromoCodeModel(
        code: 'SUMMER20',
        discount: AppTexts.summer20Discount,
        description: AppTexts.summer20Description,
        validateUntil: DateTime.now().add(const Duration(days: 60)),
        isPercentage: true,
        isUsed: false,
      ),
    };

    final upperCode = code.toUpperCase();
    if (validCodes.containsKey(upperCode)) {
      _promoCodes.add(validCodes[upperCode]!);
      await _savePromoCodes();
      return true;
    }

    return false;
  }

  Future<void> usePromoCode(String code) async {
    final codeIndex =
        _promoCodes.indexWhere((promoCode) => promoCode.code == code);
    if (codeIndex != -1) {
      final updatedCode = PromoCodeModel(
        code: _promoCodes[codeIndex].code,
        discount: _promoCodes[codeIndex].discount,
        description: _promoCodes[codeIndex].description,
        validateUntil: _promoCodes[codeIndex].validateUntil,
        isPercentage: _promoCodes[codeIndex].isPercentage,
        isUsed: true,
      );
      _promoCodes[codeIndex] = updatedCode;
      await _savePromoCodes();
    }
  }

  double? calculateDiscount(String code, double amount) {
    final promoCode = _promoCodes.firstWhere(
      (promoCode) =>
          promoCode.code == code && !promoCode.isUsed && !promoCode.isExpired,
      orElse: () => throw Exception(AppTexts.invalidOrExpiredPromoCode),
    );
    if (promoCode.isPercentage) {
      final percentage =
          double.parse(promoCode.discount.replaceAll(RegExp(r'[^0-9.]'), ''));
      return (amount * percentage) / 100;
    } else {
      return double.parse(
          promoCode.discount.replaceAll(RegExp(r'[^0-9.]'), ''));
    }
  }
}
