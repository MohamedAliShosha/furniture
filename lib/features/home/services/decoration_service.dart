import '../data/models/product_model.dart';
import '../../../core/utils/app_images.dart';

class DecorationService {
  static List<ProductModel> getDecorations() {
    return [
      ProductModel(
        colors: [
          '#ff0000',
          '#00ff00',
          '#0000ff',
        ],
        id: '13',
        name: 'Ceramic Vase Set',
        category: 'DECORATION',
        price: 349.99,
        rating: RatingModel(average: 4.5, count: 178),
        images: ImagesModel(
          main: AppImages.deco1,
          gallery: [
            AppImages.deco2,
            'assets/images/decoration/deco3.png',
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
          '#ff0000',
          '#00ff00',
          '#0000ff',
        ],
        id: '14',
        name: 'Wall Mirror Round',
        category: 'DECORATION',
        price: 569.99,
        rating: RatingModel(average: 4.6, count: 134),
        images: ImagesModel(
          main: 'assets/images/decoration/deco2.png',
          gallery: [
            'assets/images/decoration/deco3.png',
            'assets/images/decoration/deco4.png',
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
          '#ff0000',
          '#00ff00',
          '#0000ff',
        ],
        id: '15',
        name: 'Art Canvas Abstract',
        category: 'DECORATION',
        price: 299.99,
        rating: RatingModel(average: 4.3, count: 89),
        images: ImagesModel(
          main: AppImages.deco3,
          gallery: [
            AppImages.deco4,
            AppImages.deco5,
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
          '#ff0000',
          '#00ff00',
          '#0000ff',
        ],
        id: '16',
        name: 'Decorative Cushion Set',
        category: 'DECORATION',
        price: 229.99,
        rating: RatingModel(average: 4.4, count: 267),
        images: ImagesModel(
          main: AppImages.deco4,
          gallery: [
            AppImages.deco5,
            AppImages.deco6,
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
