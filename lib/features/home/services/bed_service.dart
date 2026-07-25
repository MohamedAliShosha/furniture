import '../../../core/utils/app_images.dart';
import '../data/models/product_model.dart';
import '../data/models/product_rating_model.dart';

class BedService {
  static List<ProductModel> getBeds() {
    return [
      ProductModel(
        colors: [
          '#8B4513',
          '#A0522D',
          '#CD853F',
        ],
        id: '21',
        name: 'Queen Size Bed',
        category: 'BEDS',
        price: 1899.99,
        specialOffersIds: const ['premium_discount'],
        rating: ProductRatingModel(average: 4.8, count: 324),
        images: ImagesModel(
          main: AppImages.bed1,
          gallery: [
            AppImages.bed1,
          ],
        ),
        details: DetailsModel(
          itemMeasureReferenceText: 'H: 90cm W: 160cm D: 200cm',
          designText: 'Modern Wooden Frame',
          isOnlineSellable: true,
          badge: 'Best Seller',
          description:
              'A refined queen-size bed featuring a sleek wooden frame and restful, everyday comfort.',
        ),
      ),
      ProductModel(
        colors: [
          '#8B4513',
          '#A0522D',
          '#CD853F',
        ],
        id: '22',
        name: 'Single Size Bed',
        category: 'BEDS',
        price: 1299.99,
        specialOffersIds: const ['premium_discount'],
        rating: ProductRatingModel(average: 4.6, count: 187),
        images: ImagesModel(
          main: AppImages.bed2,
          gallery: [
            AppImages.bed2,
          ],
        ),
        details: DetailsModel(
          itemMeasureReferenceText: 'H: 90cm W: 90cm D: 200cm',
          designText: 'Simple Wooden Frame',
          isOnlineSellable: true,
          badge: 'New Arrival',
          description:
              'A compact single bed designed for practical comfort, space efficiency, and minimalist styling.',
        ),
      ),
      ProductModel(
        colors: [
          '#8B4513',
          '#A0522D',
          '#CD853F',
        ],
        id: '23',
        name: 'Luxury Queen Bed',
        category: 'BEDS',
        price: 2499.99,
        specialOffersIds: const ['premium_discount'],
        rating: ProductRatingModel(average: 4.9, count: 256),
        images: ImagesModel(
          main: AppImages.bed3,
          gallery: [
            AppImages.bed3,
          ],
        ),
        details: DetailsModel(
          itemMeasureReferenceText: 'H: 100cm W: 160cm D: 210cm',
          designText: 'Upholstered Headboard',
          isOnlineSellable: true,
          badge: 'Premium',
          description:
              'An elegant upholstered queen bed with a plush headboard and premium finish for a hotel-style feel.',
        ),
      ),
      ProductModel(
        colors: [
          '#8B4513',
          '#A0522D',
          '#CD853F',
        ],
        id: '24',
        name: 'King Size Bed',
        category: 'BEDS',
        price: 2999.99,
        specialOffersIds: const ['premium_discount'],
        rating: ProductRatingModel(average: 4.7, count: 156),
        images: ImagesModel(
          main: AppImages.bed4,
          gallery: [
            AppImages.bed4,
          ],
        ),
        details: DetailsModel(
          itemMeasureReferenceText: 'H: 110cm W: 180cm D: 220cm',
          designText: 'Luxury King',
          isOnlineSellable: true,
          description:
              'A statement king-size bed with a roomy silhouette, luxurious finish, and supportive, durable construction.',
        ),
      ),
    ];
  }
}
