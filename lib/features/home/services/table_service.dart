import '../data/models/product_model.dart';
import '../../../core/utils/app_images.dart';
import '../data/models/product_rating_model.dart';

class TableService {
  static List<ProductModel> getTables() {
    return [
      ProductModel(
        colors: [
          '#556B2F',
          '#6B8E23',
          '#808000',
        ],
        id: '5',
        name: 'Oak Dining Table',
        category: 'TABLES',
        price: 2499.99,
        specialOffersIds: const ['premium_discount'],
        rating: ProductRatingModel(average: 4.7, count: 198),
        images: ImagesModel(
          main: AppImages.diningTable1,
          gallery: [
            AppImages.diningTable1,
          ],
        ),
        details: DetailsModel(
          itemMeasureReferenceText: 'H: 75cm W: 180cm D: 90cm',
          designText: 'Natural Oak',
          isOnlineSellable: true,
          badge: 'Popular',
          description:
              'A warm natural oak dining table with generous seating space for family gatherings and everyday hosting.',
        ),
      ),
      ProductModel(
        colors: [
          '#556B2F',
          '#6B8E23',
          '#808000',
        ],
        id: '6',
        name: 'Oak Dining Table',
        category: 'TABLES',
        price: 1299.99,
        specialOffersIds: const ['premium_discount'],
        rating: ProductRatingModel(average: 4.7, count: 198),
        images: ImagesModel(
          main: AppImages.diningTable2,
          gallery: [
            AppImages.diningTable2,
          ],
        ),
        details: DetailsModel(
          itemMeasureReferenceText: 'H: 75cm W: 180cm D: 90cm',
          designText: 'Natural Oak',
          isOnlineSellable: true,
          badge: 'Popular',
          description:
              'A sturdy oak dining table with clean lines and practical durability for strong everyday use.',
        ),
      ),
      ProductModel(
        category: 'TABLES',
        price: 899.99,
        colors: [
          '#556B2F',
          '#6B8E23',
          '#808000',
        ],
        id: '7',
        name: 'Glass Console Table',
        specialOffersIds: const ['premium_discount'],
        rating: ProductRatingModel(average: 4.4, count: 145),
        images: ImagesModel(
          main: AppImages.diningTable3,
          gallery: [AppImages.diningTable3],
        ),
        details: DetailsModel(
          itemMeasureReferenceText: 'H: 45cm W: 100cm D: 60cm',
          designText: 'Minimalist Modern',
          isOnlineSellable: true,
          description:
              'A sleek glass console table that brings brightness, elegance, and modern edge to entryways or living spaces.',
        ),
      ),
      ProductModel(
        colors: [
          '#556B2F',
          '#6B8E23',
          '#808000',
        ],
        id: '8',
        name: 'Coffee Table Set',
        category: 'TABLES',
        price: 399.99,
        rating: ProductRatingModel(average: 4.3, count: 87),
        images: ImagesModel(
          main: AppImages.coffeeTable,
          gallery: [
            AppImages.coffeeTable,
          ],
        ),
        details: DetailsModel(
          itemMeasureReferenceText: 'H: 80cm W: 120cm D: 35cm',
          designText: 'Contemporary Set (2 pieces)',
          isOnlineSellable: true,
          description:
              'A contemporary coffee table set that pairs polished surfaces with a clean, social-friendly design.',
        ),
      ),
    ];
  }
}
