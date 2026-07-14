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
        specialOffersIds: const ['summer_sale'],
        colors: [
          '#2F4F4F',
          '#696969',
          '#778899',
        ],
        rating: RatingModel(average: 4.5, count: 128),
        images: ImagesModel(
          main: AppImages.chair1,
          gallery: [
            AppImages.chair1,
          ],
        ),
        details: DetailsModel(
          itemMeasureReferenceText: 'H: 85cm W: 75cm D: 80cm',
          designText: 'Modern Scandinavian',
          isOnlineSellable: true,
          badge: 'Best Seller',
          description:
              'A stylish lounge chair with a sculpted silhouette and plush cushioning for comfortable, relaxed lounging.',
        ),
      ),
      ProductModel(
        colors: [
          '#2F4F4F',
          '#696969',
          '#778899',
        ],
        id: '2',
        name: 'Classic Dining Chair',
        category: 'CHAIRS',
        price: 199.99,
        specialOffersIds: const ['summer_sale'],
        rating: RatingModel(average: 4.2, count: 89),
        images: ImagesModel(
          main: AppImages.chair2,
          gallery: [
            AppImages.chair2,
          ],
        ),
        details: DetailsModel(
          itemMeasureReferenceText: 'H: 90cm W: 45cm D: 50cm',
          designText: 'Classic Traditional',
          isOnlineSellable: true,
          description:
              'A timeless dining chair that blends comfort, durability, and classic detail for everyday meals.',
        ),
      ),
      ProductModel(
        colors: [
          '#2F4F4F',
          '#696969',
          '#778899',
        ],
        id: '3',
        name: 'Ergonomic Office Chair',
        category: 'CHAIRS',
        price: 379.99,
        specialOffersIds: const ['summer_sale'],
        rating: RatingModel(average: 4.8, count: 256),
        images: ImagesModel(
          main: AppImages.chair3,
          gallery: [
            AppImages.chair3,
          ],
        ),
        details: DetailsModel(
          itemMeasureReferenceText: 'H: 110-120cm W: 65cm D: 65cm',
          designText: 'Ergonomic Premium',
          isOnlineSellable: true,
          badge: 'New',
          description:
              'A high-support office chair engineered for posture comfort, long hours of work, and all-day focus.',
        ),
      ),
      ProductModel(
        colors: [
          '#2F4F4F',
          '#696969',
          '#778899',
        ],
        id: '4',
        name: 'Velvet Accent Chair',
        category: 'CHAIRS',
        price: 399.99,
        specialOffersIds: const ['summer_sale'],
        rating: RatingModel(average: 4.6, count: 167),
        images: ImagesModel(
          main: AppImages.chair4,
          gallery: [
            AppImages.chair4,
          ],
        ),
        details: DetailsModel(
          itemMeasureReferenceText: 'H: 82cm W: 78cm D: 75cm',
          designText: 'Luxury Velvet',
          isOnlineSellable: true,
          description:
              'An elegant accent chair in rich velvet upholstery that adds warmth and sophistication to any room.',
        ),
      ),
    ];
  }
}
