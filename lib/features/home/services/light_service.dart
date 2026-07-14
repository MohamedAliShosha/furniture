import '../data/models/product_model.dart';
import '../../../core/utils/app_images.dart';

class LightService {
  static List<ProductModel> getLightings() {
    return [
      ProductModel(
        colors: [
          '#FFD700',
          '#FFA500',
          '#FF8C00',
        ],
        id: '9',
        name: 'Pendant Light Cluster',
        category: 'LIGHTINGS',
        price: 599.99,
        specialOffersIds: const ['premium_discount'],
        rating: RatingModel(average: 4.6, count: 156),
        images: ImagesModel(
          main: AppImages.light1,
          gallery: [
            AppImages.light1,
          ],
        ),
        details: DetailsModel(
          itemMeasureReferenceText: 'H: 30cm W: 40cm',
          designText: 'Modern Cluster',
          isOnlineSellable: true,
          description:
              'A layered pendant light cluster that adds ambient glow and designer character to dining and lounge areas.',
        ),
      ),
      ProductModel(
        colors: [
          '#FFD700',
          '#FFA500',
          '#FF8C00',
        ],
        id: '10',
        name: 'Arc Floor Lamp',
        category: 'LIGHTINGS',
        price: 399.99,
        rating: RatingModel(average: 4.7, count: 203),
        images: ImagesModel(
          main: AppImages.light2,
          gallery: [
            AppImages.light2,
          ],
        ),
        details: DetailsModel(
          itemMeasureReferenceText: 'H: 200cm W: 100cm',
          designText: 'Classic Arc',
          isOnlineSellable: true,
          badge: 'Trending',
          description:
              'A dramatic arc floor lamp that fills the room with warm light while making a bold visual statement.',
        ),
      ),
      ProductModel(
        colors: [
          '#FFD700',
          '#FFA500',
          '#FF8C00',
        ],
        id: '11',
        name: 'Table Lamp Vintage',
        category: 'LIGHTINGS',
        price: 299.99,
        rating: RatingModel(average: 4.2, count: 98),
        images: ImagesModel(
          main: AppImages.light3,
          gallery: [
            AppImages.light3,
          ],
        ),
        details: DetailsModel(
          itemMeasureReferenceText: 'H: 45cm W: 25cm',
          designText: 'Vintage Classic',
          isOnlineSellable: true,
          description:
              'A vintage-inspired table lamp with a classic silhouette that complements cozy, refined interiors.',
        ),
      ),
      ProductModel(
        colors: [
          '#FFD700',
          '#FFA500',
          '#FF8C00',
        ],
        id: '12',
        name: 'LED Desk Lamp',
        category: 'LIGHTINGS',
        price: 499.99,
        rating: RatingModel(average: 4.4, count: 312),
        images: ImagesModel(
          main: AppImages.light4,
          gallery: [
            AppImages.light4,
          ],
        ),
        details: DetailsModel(
          itemMeasureReferenceText: 'H: 40cm W: 15cm',
          designText: 'Modern LED',
          isOnlineSellable: true,
          description:
              'A modern LED desk lamp with adjustable illumination for focused reading, work, and evening comfort.',
        ),
      ),
    ];
  }
}
