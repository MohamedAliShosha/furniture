import '../data/models/product_model.dart';
import '../../../core/utils/app_images.dart';

class SofaService {
  static List<ProductModel> getSofas() {
    return [
      ProductModel(
        colors: [
          '#FFFFFF',
          '#000000',
          '#FF0000',
          '#00FF00',
        ],
        id: '17',
        name: 'L-Shaped Sectional Sofa',
        category: 'SOFAS',
        price: 1299.99,
        rating: RatingModel(average: 4.8, count: 345),
        images: ImagesModel(
          main: AppImages.sofa1,
          gallery: [
            AppImages.sofa2,
            'assets/images/sofa/sofa3.png',
          ],
        ),
        details: DetailsModel(
          itemMeasureReferenceText: 'H: 85cm W: 280cm D: 180cm',
          designText: 'Modern Sectional',
          isOnlineSellable: true,
          badge: 'Best Seller',
        ),
      ),
      ProductModel(
        colors: [
          '#FFFFFF',
          '#000000',
          '#FF0000',
          '#00FF00',
        ],
        id: '18',
        name: 'Two-Seater Loveseat',
        category: 'SOFAS',
        price: 459.99,
        rating: RatingModel(average: 4.5, count: 189),
        images: ImagesModel(
          main: 'assets/images/sofa/sofa2.png',
          gallery: [
            'assets/images/sofa/sofa3.png',
            'assets/images/sofa/sofa4.png',
          ],
        ),
        details: DetailsModel(
          itemMeasureReferenceText: 'H: 80cm W: 160cm D: 85cm',
          designText: 'Classic Fabric',
          isOnlineSellable: true,
        ),
      ),
      ProductModel(
        colors: [
          '#FFFFFF',
          '#000000',
          '#FF0000',
          '#00FF00',
        ],
        id: '19',
        name: 'Leather Recliner',
        category: 'SOFAS',
        price: 699.99,
        rating: RatingModel(average: 4.6, count: 156),
        images: ImagesModel(
          main: 'assets/images/sofa/sofa3.png',
          gallery: [
            'assets/images/sofa/sofa4.png',
            'assets/images/sofa/sofa5.png',
          ],
        ),
        details: DetailsModel(
          itemMeasureReferenceText: 'H: 100cm W: 90cm D: 95cm',
          designText: 'Premium Leather',
          isOnlineSellable: true,
        ),
      ),
      ProductModel(
        colors: [
          '#FFFFFF',
          '#000000',
          '#FF0000',
          '#00FF00',
        ],
        id: '20',
        name: 'Velvet Sofa 3-Seater',
        category: 'SOFAS',
        price: 449.99,
        rating: RatingModel(average: 4.7, count: 223),
        images: ImagesModel(
          main: 'assets/images/sofa/sofa4.png',
          gallery: [
            'assets/images/sofa/sofa5.png',
            'assets/images/sofa/sofa6.png',
          ],
        ),
        details: DetailsModel(
          itemMeasureReferenceText: 'H: 82cm W: 220cm D: 90cm',
          designText: 'Luxury Velvet',
          isOnlineSellable: true,
          badge: 'New',
        ),
      ),
    ];
  }
}
