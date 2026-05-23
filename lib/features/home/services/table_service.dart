import '../data/models/product_model.dart';
import '../../../core/utils/app_images.dart';

class TableService {
  static List<ProductModel> getTables() {
    return [
      ProductModel(
        colors: [
          '#f5f5f5',
          '#ffffff',
          '#fd4b4b',
        ],
        id: '5',
        name: 'Oak Dining Table',
        category: 'TABLES',
        price: 2499.99,
        rating: RatingModel(average: 4.7, count: 198),
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
        ),
      ),
      ProductModel(
        colors: [
          '#f5f5f5',
          '#ffffff',
          '#fd4b4b',
        ],
        id: '6',
        name: 'Oak Dining Table',
        category: 'TABLES',
        price: 1299.99,
        rating: RatingModel(average: 4.7, count: 198),
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
        ),
      ),
      ProductModel(
        price: 899.99,
        colors: [
          '#f5f5f5',
          '#ffffff',
          '#fd4b4b',
        ],
        id: '7',
        name: 'Glass Console Table',
        rating: RatingModel(average: 4.4, count: 145),
        images: ImagesModel(
          main: AppImages.diningTable3,
          gallery: [AppImages.diningTable3],
        ),
        details: DetailsModel(
          itemMeasureReferenceText: 'H: 45cm W: 100cm D: 60cm',
          designText: 'Minimalist Modern',
          isOnlineSellable: true,
        ),
      ),
      ProductModel(
        colors: [
          '#f5f5f5',
          '#ffffff',
          '#fd4b4b',
        ],
        id: '8',
        name: 'Coffee Table Set',
        category: 'TABLES',
        price: 399.99,
        rating: RatingModel(average: 4.3, count: 87),
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
        ),
      ),
    ];
  }
}
