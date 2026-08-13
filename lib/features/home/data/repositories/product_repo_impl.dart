import 'product_repo.dart';
import '../../services/bed_service.dart';
import '../../../../features/home/data/models/product_model.dart';
import '../../../../features/home/services/chair_service.dart';
import '../../../../features/home/services/decoration_service.dart';
import '../../../../features/home/services/light_service.dart';
import '../../../../features/home/services/sofa_service.dart';
import '../../../../features/home/services/table_service.dart';

class ProductRepoImpl implements ProductRepo {
  @override
  Future<List<ProductModel>> getFeaturedItems() async {
    final List<ProductModel> items = [
      ...ChairService.getChairs().sublist(0, 2),
      ...TableService.getTables().sublist(0, 2),
      ...LightService.getLightings().sublist(0, 2),
      ...DecorationService.getDecorations().sublist(0, 2),
      ...SofaService.getSofas().sublist(0, 2),
      ...BedService.getBeds().sublist(0, 2),
    ];
    return items;
  }

  @override
  Future<List<ProductModel>> getAllProducts() async {
    final List<ProductModel> items = [
      ...ChairService.getChairs(),
      ...TableService.getTables(),
      ...LightService.getLightings(),
      ...DecorationService.getDecorations(),
      ...SofaService.getSofas(),
      ...BedService.getBeds(),
    ];
    return items;
  }

  @override
  Future<List<ProductModel>> getProductsByCategory(String category) async {
    List<ProductModel> items;
    switch (category.toUpperCase()) {
      case 'ALL':
        items = await getAllProducts();
        break;
      case 'CHAIRS':
        items = ChairService.getChairs();
        break;
      case 'TABLES':
        items = TableService.getTables();
        break;
      case 'LIGHTINGS':
        items = LightService.getLightings();
        break;
      case 'DECORATION':
        items = DecorationService.getDecorations();
        break;
      case 'SOFAS':
        items = SofaService.getSofas();
        break;
      case 'BEDS':
        items = BedService.getBeds();
        break;
      default:
        items = await getAllProducts();
    }
    return items;
  }
}
