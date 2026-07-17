import '../../../core/utils/app_images.dart';
import '../data/models/category_model.dart';
import '../services/chair_service.dart';
import '../services/table_service.dart';
import '../services/light_service.dart';
import '../services/decoration_service.dart';
import '../services/sofa_service.dart';
import '../services/bed_service.dart';

class CategoryService {
  static List<CategoryModel> getCategories() {
    return [
      CategoryModel(
        id: 'chairs',
        name: 'Chairs',
        image: AppImages.chair1,
        productCount: ChairService.getChairs().length,
        badge: 'Best Seller',
        applicableOffersIds: const ['summer_sale'],
      ),
      CategoryModel(
        id: 'tables',
        name: 'Tables',
        image: AppImages.diningTable1,
        productCount: TableService.getTables().length,
        badge: 'Popular',
        applicableOffersIds: const ['premium_discount'],
      ),
      CategoryModel(
        id: 'lightings',
        name: 'Lightings',
        image: AppImages.light1,
        productCount: LightService.getLightings().length,
        applicableOffersIds: const ['premium_discount'],
      ),
      CategoryModel(
        id: 'decorations',
        name: 'Decorations',
        image: AppImages.deco1,
        productCount: DecorationService.getDecorations().length,
      ),
      CategoryModel(
        id: 'sofas',
        name: 'Sofas',
        image: AppImages.sofa1,
        productCount: SofaService.getSofas().length,
        badge: 'Best Seller',
        applicableOffersIds: const ['summer_sale', 'premium_discount'],
      ),
      CategoryModel(
        id: 'beds',
        name: 'Beds',
        image: AppImages.bed1,
        productCount: BedService.getBeds().length,
        badge: 'New Arrival',
        applicableOffersIds: const ['premium_discount'],
      ),
    ];
  }
}
