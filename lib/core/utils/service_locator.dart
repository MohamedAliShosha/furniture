import 'package:get_it/get_it.dart';
import '../../features/blog/presentation/cubit/blog_cubit.dart';
import '../../features/blog/services/blog_service.dart';
import '../../features/cart/presentation/cubit/cart_cubit.dart';
import '../../features/home/services/cart_service.dart';
import '../../features/wishlist/presentation/cubit/wishlist_cubit.dart';
import '../../features/home/services/wishlist_service.dart';
import '../../features/home/data/repositories/product_repo.dart';
import '../../features/home/data/repositories/product_repo_impl.dart';
import '../../features/home/presentation/cubit/all_products/all_products_cubit.dart';
import '../../features/home/presentation/cubit/featured_items/featured_items_cubit.dart';
import '../../features/home/presentation/cubit/products_by_category/products_by_category_cubit.dart';

final GetIt getIt = GetIt.instance;

void setupServiceLocator() {
  // Blog Feature
  getIt.registerLazySingleton<BlogService>(
    () => BlogService(),
  );

  getIt.registerFactory<BlogCubit>(
    () => BlogCubit(
      getIt<BlogService>(),
    ),
  );

  // Cart Feature
  getIt.registerLazySingleton<CartService>(
    () => CartService(),
  );

  getIt.registerFactory<CartCubit>(
    () => CartCubit(
      getIt<CartService>(),
    ),
  );

  // Wishlist Feature
  getIt.registerLazySingleton<WishListService>(
    () => WishListService(),
  );

  getIt.registerFactory<WishlistCubit>(
    () => WishlistCubit(
      getIt<WishListService>(),
    ),
  );

  // Home Feature
  getIt.registerLazySingleton<ProductRepo>(
    () => ProductRepoImpl(),
  );

  getIt.registerFactory<AllProductsCubit>(
    () => AllProductsCubit(
      getIt<ProductRepo>(),
    ),
  );

  getIt.registerFactory<FeaturedItemsCubit>(
    () => FeaturedItemsCubit(
      getIt<ProductRepo>(),
    ),
  );

  getIt.registerFactory<ProductsByCategoryCubit>(
    () => ProductsByCategoryCubit(
      getIt<ProductRepo>(),
    ),
  );
}
