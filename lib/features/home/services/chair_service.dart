import '../data/models/product_model.dart';
import '../../../core/utils/app_images.dart';

class ChairService {
  static List<ProductModel> getChairs() {
    return [
      ProductModel(
        id: '1',
        name: 'Modern Lounge Chair',
        category: 'CHAIRS',
        price: 280.99,
        colors: [
          '#E5E5E5',
          '#C4C4C4',
          '#9B9B9B',
        ],
        rating: RatingModel(average: 4.5, count: 128),
        images: ImagesModel(
          main: AppImages.chair1,
          gallery: [
            'assets/images/chairs/chair2.png',
            'assets/images/chairs/chair3.png',
          ],
        ),
        details: DetailsModel(
          itemMeasureReferenceText: 'H: 85cm W: 75cm D: 80cm',
          designText: 'Modern Scandinavian',
          isOnlineSellable: true,
          badge: 'Best Seller',
        ),
      ),
      ProductModel(
        colors: [
          '#E5E5E5',
          '#C4C4C4',
          '#9B9B9B',
        ],
        id: '2',
        name: 'Classic Dining Chair',
        category: 'CHAIRS',
        price: 199.99,
        rating: RatingModel(average: 4.2, count: 89),
        images: ImagesModel(
          main: 'assets/images/chairs/chair2.png',
          gallery: [
            'assets/images/chairs/chair3.png',
            'assets/images/chairs/chair4.png',
          ],
        ),
        details: DetailsModel(
          itemMeasureReferenceText: 'H: 90cm W: 45cm D: 50cm',
          designText: 'Classic Traditional',
          isOnlineSellable: true,
        ),
      ),
      ProductModel(
        colors: [
          '#E5E5E5',
          '#C4C4C4',
          '#9B9B9B',
        ],
        id: '3',
        name: 'Ergonomic Office Chair',
        category: 'CHAIRS',
        price: 379.99,
        rating: RatingModel(average: 4.8, count: 256),
        images: ImagesModel(
          main: 'assets/images/chairs/chair3.png',
          gallery: [
            'assets/images/chairs/chair4.png',
            'assets/images/chairs/chair5.png',
          ],
        ),
        details: DetailsModel(
          itemMeasureReferenceText: 'H: 110-120cm W: 65cm D: 65cm',
          designText: 'Ergonomic Premium',
          isOnlineSellable: true,
          badge: 'New',
        ),
      ),
      ProductModel(
        colors: [
          '#E5E5E5',
          '#C4C4C4',
          '#9B9B9B',
        ],
        id: '4',
        name: 'Velvet Accent Chair',
        category: 'CHAIRS',
        price: 399.99,
        rating: RatingModel(average: 4.6, count: 167),
        images: ImagesModel(
          main: 'assets/images/chairs/chair4.png',
          gallery: [
            'assets/images/chairs/chair5.png',
            'assets/images/chairs/chair6.png',
          ],
        ),
        details: DetailsModel(
          itemMeasureReferenceText: 'H: 82cm W: 78cm D: 75cm',
          designText: 'Luxury Velvet',
          isOnlineSellable: true,
        ),
      ),
    ];
  }
}
