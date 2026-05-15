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
            AppImages.diningTable2,
            AppImages.diningTable3,
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
            AppImages.diningTable3,
          ],
        ),
        details: DetailsModel(
          itemMeasureReferenceText: 'H: 75cm W: 180cm D: 90cm',
          designText: 'Natural Oak',
          isOnlineSellable: true,
          badge: 'Popular',
        ),
      ),
      // ProductModel(
      //   id: '6',
      //   name: 'Minimalist Coffee Table',
      //   typeName: 'TABLES',
      //   price: PriceModel(
      //     currency: '\$',
      //     currentPrice: 249.99,
      //     formattedPrice: '\$249.99',
      //   ),
      //   rating: RatingModel(average: 4.4, count: 145),
      //   images: ImagesModel(
      //      main: AppImages.coffeeTable1,
      //     gallery: [
      //        AppImages.coffeeTable,
      //       'assets/images/tables/table2.jpg',
      //     ],
      //   ),
      //   details: DetailsModel(
      //     itemMeasureReferenceText: 'H: 45cm W: 100cm D: 60cm',
      //     designText: 'Minimalist Modern',
      //     isOnlineSellable: true,
      //   ),
      // ),
      // ProductModel(
      //   id: '7',
      //   name: 'Glass Console Table',
      //   category: 'TABLES',
      //   price: PriceModel(
      //     currency: '\$',
      //     currentPrice: 399.99,
      //     formattedPrice: '\$399.99',
      //   ),
      //   rating: RatingModel(average: 4.3, count: 87),
      //   images: ImagesModel(
      //     main: 'assets/images/tables/table3.jpg',
      //     gallery: [
      //       'assets/images/tables/table4.jpg',
      //       'assets/images/tables/table5.jpg',
      //     ],
      //   ),
      //   details: DetailsModel(
      //     itemMeasureReferenceText: 'H: 80cm W: 120cm D: 35cm',
      //     designText: 'Contemporary Glass',
      //     isOnlineSellable: true,
      //   ),
      // ),
      // ProductModel(
      //   id: '8',
      //   name: 'Wooden Study Desk',
      //   category: 'TABLES',
      //   price: PriceModel(
      //     currency: '\$',
      //     currentPrice: 349.99,
      //     formattedPrice: '\$349.99',
      //   ),
      //   rating: RatingModel(average: 4.5, count: 234),
      //   images: ImagesModel(
      //     main: 'assets/images/tables/table6.jpg',
      //     gallery: [
      //       'assets/images/tables/table1.jpg',
      //       'assets/images/tables/table2.jpg',
      //     ],
      //   ),
      //   details: DetailsModel(
      //     itemMeasureReferenceText: 'H: 75cm W: 140cm D: 70cm',
      //     designText: 'Classic Wood',
      //     isOnlineSellable: true,
      //   ),
      // ),
    ];
  }
}
