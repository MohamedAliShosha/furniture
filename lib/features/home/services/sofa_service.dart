import '../data/models/product_model.dart';
import '../../../core/utils/app_images.dart';

class SofaService {
  static List<ProductModel> getSofas() {
    return [
      ProductModel(
        colors: [
          '#4B0082',
          '#800080',
          '#9400D3',
        ],
        id: '17',
        name: 'L-Shaped Sectional Sofa',
        category: 'SOFAS',
        price: 1299.99,
        specialOffersIds: const ['summer_sale', 'premium_discount'],
        rating: RatingModel(average: 4.8, count: 345),
        images: ImagesModel(
          main: AppImages.sofa1,
          gallery: [
            AppImages.sofa1,
          ],
        ),
        details: DetailsModel(
          itemMeasureReferenceText: 'H: 85cm W: 280cm D: 180cm',
          designText: 'Modern Sectional',
          isOnlineSellable: true,
          badge: 'Best Seller',
          description:
              'A spacious L-shaped sectional sofa built for comfort, entertaining, and relaxed family lounging.',
        ),
      ),
      ProductModel(
        colors: [
          '#4B0082',
          '#800080',
          '#9400D3',
        ],
        id: '18',
        name: 'Two-Seater Loveseat',
        category: 'SOFAS',
        price: 459.99,
        specialOffersIds: const ['summer_sale'],
        rating: RatingModel(average: 4.5, count: 189),
        images: ImagesModel(
          main: AppImages.sofa2,
          gallery: [
            AppImages.sofa2,
          ],
        ),
        details: DetailsModel(
          itemMeasureReferenceText: 'H: 80cm W: 160cm D: 85cm',
          designText: 'Classic Fabric',
          isOnlineSellable: true,
          description:
              'A cozy two-seater loveseat with soft fabric upholstery and balanced proportions for compact spaces.',
        ),
      ),
      ProductModel(
        colors: [
          '#4B0082',
          '#800080',
          '#9400D3',
        ],
        id: '19',
        name: 'Leather Recliner',
        category: 'SOFAS',
        price: 699.99,
        specialOffersIds: const ['summer_sale', 'premium_discount'],
        rating: RatingModel(average: 4.6, count: 156),
        images: ImagesModel(
          main: AppImages.sofa3,
          gallery: [
            AppImages.sofa3,
          ],
        ),
        details: DetailsModel(
          itemMeasureReferenceText: 'H: 100cm W: 90cm D: 95cm',
          designText: 'Premium Leather',
          isOnlineSellable: true,
          description:
              'A premium leather recliner designed for comfort, support, and a refined lounging experience.',
        ),
      ),
      ProductModel(
        colors: [
          '#4B0082',
          '#800080',
          '#9400D3',
        ],
        id: '20',
        name: 'Velvet Sofa 3-Seater',
        category: 'SOFAS',
        price: 449.99,
        specialOffersIds: const ['summer_sale'],
        rating: RatingModel(average: 4.7, count: 223),
        images: ImagesModel(
          main: AppImages.sofa4,
          gallery: [
            AppImages.sofa4,
          ],
        ),
        details: DetailsModel(
          itemMeasureReferenceText: 'H: 82cm W: 220cm D: 90cm',
          designText: 'Luxury Velvet',
          isOnlineSellable: true,
          badge: 'New',
          description:
              'A plush three-seater velvet sofa that adds a luxe touch and welcoming feel to any living room.',
        ),
      ),
    ];
  }
}
