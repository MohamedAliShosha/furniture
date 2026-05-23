import 'package:flutter/material.dart';
import '../data/models/product_model.dart';
import '../data/models/special_offer_model.dart';

class SpecialOffersService {
  final List<SpecialOfferModel> specialOffers = [
    SpecialOfferModel(
      id: 'summer_sale',
      title: 'Summer Sale',
      description: 'Get 20% off on all summer collection items.',
      discountPercentage: 20,
      startDate: DateTime.now().subtract(
        const Duration(days: 1),
      ),
      endDate: DateTime.now().add(
        const Duration(days: 30),
      ),
      applicableCategories: ['CHAIRS', 'SOFAS'],
    ),
    SpecialOfferModel(
        id: 'premium_discount',
        title: 'Premium furniture Deal',
        description: '30% off on all premium furniture.',
        discountPercentage: 30,
        startDate: DateTime.now().subtract(
          const Duration(days: 1),
        ),
        endDate: DateTime.now().add(
          const Duration(days: 30),
        ),
        minimumPurchaseAmount: 599.0),
    SpecialOfferModel(
      id: 'storage_special',
      title: 'Storage Solutions',
      description: '25% off on all storage items.',
      discountPercentage: 25,
      startDate: DateTime.now().subtract(
        const Duration(days: 1),
      ),
      endDate: DateTime.now().add(
        const Duration(days: 30),
      ),
      applicableCategories: ['Storage'],
    ),
  ];

  List<SpecialOfferModel> get specialOffersList {
    final offers = [...specialOffers];
    debugPrint('${offers.length}');
    for (final offer in offers) {
      debugPrint(offer.title);
    }
    return offers;
  }

  SpecialOfferModel? getOfferById(String id) {
    try {
      return specialOffers.firstWhere((offer) => offer.id == id);
    } catch (e) {
      debugPrint('Offer with id $id not found');
      return null;
    }
  }

  List<SpecialOfferModel> getApplicableOffers(ProductModel product) {
    final offers = specialOffers.where((offer) {
      final isApplicable = offer.isApplicableToProduct(product.id,
          product.category!, product.price, product.specialOffersIds!);
      debugPrint(
          'Offer ${offer.id} applicable to ${product.id}: $isApplicable');
      return isApplicable;
    }).toList();
    debugPrint(
        'Found ${offers.length} applicable offers for product ${product.id}');
    return offers;
  }

  SpecialOfferModel? getBestOffer(ProductModel product) {
    final applicableOffers = getApplicableOffers(product);
    if (applicableOffers.isEmpty) {
      return null;
    }
    return applicableOffers.reduce((current, next) =>
        current.discountPercentage > next.discountPercentage ? current : next);
  }

  double getDiscountedPrice(ProductModel product) {
    final bestOffer = getBestOffer(product);
    if (bestOffer == null) {
      return product.price;
    }
    return product.price -
        ((product.price * bestOffer.discountPercentage) / 100);
  }
}
