import '../data/models/product_model.dart';
import '../../../core/utils/app_images.dart';

class LightService {
  static List<ProductModel> getLightings() {
    return [
      ProductModel(
        colors: [
          '#FF0000',
          '#00FF00',
          '#0000FF',
        ],
        id: '9',
        name: 'Pendant Light Cluster',
        category: 'LIGHTINGS',
        price: 599.99,
        rating: RatingModel(average: 4.6, count: 156),
        images: ImagesModel(
          main: AppImages.light1,
          gallery: [
            'assets/images/lights/light2.png',
            'assets/images/lights/light3.png',
          ],
        ),
        details: DetailsModel(
          itemMeasureReferenceText: 'H: 30cm W: 40cm',
          designText: 'Modern Cluster',
          isOnlineSellable: true,
        ),
      ),
      ProductModel(
        colors: [
          '#FF0000',
          '#00FF00',
          '#0000FF',
        ],
        id: '10',
        name: 'Arc Floor Lamp',
        category: 'LIGHTINGS',
        price: 399.99,
        rating: RatingModel(average: 4.7, count: 203),
        images: ImagesModel(
          main: 'assets/images/lights/light2.png',
          gallery: [
            'assets/images/lights/light3.png',
            'assets/images/lights/light4.png',
          ],
        ),
        details: DetailsModel(
          itemMeasureReferenceText: 'H: 200cm W: 100cm',
          designText: 'Classic Arc',
          isOnlineSellable: true,
          badge: 'Trending',
        ),
      ),
      ProductModel(
        colors: [
          '#FF0000',
          '#00FF00',
          '#0000FF',
        ],
        id: '11',
        name: 'Table Lamp Vintage',
        category: 'LIGHTINGS',
        price: 299.99,
        rating: RatingModel(average: 4.2, count: 98),
        images: ImagesModel(
          main: 'assets/images/lights/light3.png',
          gallery: [
            'assets/images/lights/light4.png',
            'assets/images/lights/light5.png',
          ],
        ),
        details: DetailsModel(
          itemMeasureReferenceText: 'H: 45cm W: 25cm',
          designText: 'Vintage Classic',
          isOnlineSellable: true,
        ),
      ),
      ProductModel(
        colors: [
          '#FF0000',
          '#00FF00',
          '#0000FF',
        ],
        id: '12',
        name: 'LED Desk Lamp',
        category: 'LIGHTINGS',
        price: 499.99,
        rating: RatingModel(average: 4.4, count: 312),
        images: ImagesModel(
          main: 'assets/images/lights/light4.png',
          gallery: [
            'assets/images/lights/light5.png',
            'assets/images/lights/light6.png',
          ],
        ),
        details: DetailsModel(
          itemMeasureReferenceText: 'H: 40cm W: 15cm',
          designText: 'Modern LED',
          isOnlineSellable: true,
        ),
      ),
    ];
  }
}
