import '../data/models/product_model.dart';
import '../../../core/utils/app_images.dart';

class DecorationService {
  static List<ProductModel> getDecorations() {
    return [
      ProductModel(
        colors: [
           '#9370DB',
           '#8A2BE2',
           '#9400D3',
         ],
        id: '13',
        name: 'Ceramic Vase Set',
        category: 'DECORATION',
        price: 349.99,
        rating: RatingModel(average: 4.5, count: 178),
        images: ImagesModel(
          main: AppImages.deco1,
          gallery: [
            AppImages.deco1,
          ],
        ),
        details: DetailsModel(
          itemMeasureReferenceText: 'H: 30cm W: 15cm',
          designText: 'Ceramic Art',
          isOnlineSellable: true,
        ),
      ),
      ProductModel(
        colors: [
           '#9370DB',
           '#8A2BE2',
           '#9400D3',
         ],
        id: '14',
        name: 'Wall Mirror Round',
        category: 'DECORATION',
        price: 569.99,
        rating: RatingModel(average: 4.6, count: 134),
        images: ImagesModel(
          main: AppImages.deco2,
          gallery: [
            AppImages.deco2,
          ],
        ),
        details: DetailsModel(
          itemMeasureReferenceText: 'Diameter: 80cm',
          designText: 'Modern Mirror',
          isOnlineSellable: true,
        ),
      ),
      ProductModel(
        colors: [
           '#9370DB',
           '#8A2BE2',
           '#9400D3',
         ],
        id: '15',
        name: 'Art Canvas Abstract',
        category: 'DECORATION',
        price: 299.99,
        rating: RatingModel(average: 4.3, count: 89),
        images: ImagesModel(
          main: AppImages.deco3,
          gallery: [
            AppImages.deco3,
          ],
        ),
        details: DetailsModel(
          itemMeasureReferenceText: 'H: 60cm W: 90cm',
          designText: 'Abstract Art',
          isOnlineSellable: true,
        ),
      ),
      ProductModel(
        colors: [
           '#9370DB',
           '#8A2BE2',
           '#9400D3',
         ],
        id: '16',
        name: 'Decorative Cushion Set',
        category: 'DECORATION',
        price: 229.99,
        rating: RatingModel(average: 4.4, count: 267),
        images: ImagesModel(
          main: AppImages.deco4,
          gallery: [
            AppImages.deco4,
          ],
        ),
        details: DetailsModel(
          itemMeasureReferenceText: '45cm x 45cm',
          designText: 'Patterned Cotton',
          isOnlineSellable: true,
        ),
      ),
    ];
  }
}
