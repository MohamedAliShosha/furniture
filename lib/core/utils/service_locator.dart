import 'package:get_it/get_it.dart';
import '../../features/blog/presentation/cubit/blog_cubit.dart';
import '../../features/blog/services/blog_service.dart';
import '../../features/cart/presentation/cubit/cart_cubit.dart';
import '../../features/home/services/cart_service.dart';
import '../../features/wishlist/presentation/cubit/wishlist_cubit.dart';
import '../../features/home/services/wishlist_service.dart';
import '../../features/home/data/repositories/product_repo.dart';
import '../../features/home/data/repositories/product_repo_impl.dart';
import '../../features/home/data/repositories/category_repo.dart';
import '../../features/home/data/repositories/category_repo_impl.dart';
import '../../features/home/presentation/cubit/home_cubit.dart';
import '../../features/home/presentation/cubit/all_products/all_products_cubit.dart';
import '../../features/home/presentation/cubit/featured_items/featured_items_cubit.dart';
import '../../features/home/presentation/cubit/products_by_category/products_by_category_cubit.dart';
import '../../features/home/presentation/cubit/categories/categories_cubit.dart';
import '../../features/home/presentation/cubit/user/user_cubit.dart';
import '../../features/home/services/user_service.dart';
import '../../features/home/services/special_offers_service.dart';
import '../../features/special_offer/presentation/cubit/special_offer_cubit.dart';

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

  getIt.registerLazySingleton<CategoryRepo>(
    () => CategoryRepoImpl(),
  );

  getIt.registerFactory<CategoriesCubit>(
    () => CategoriesCubit(
      getIt<CategoryRepo>(),
    ),
  );

  getIt.registerFactory<HomeCubit>(
    () => HomeCubit(
      getIt<ProductRepo>(),
      getIt<CategoryRepo>(),
    ),
  );

  // User Service
  getIt.registerLazySingleton<UserService>(
    () => UserService(),
  );

  getIt.registerFactory<UserCubit>(
    () => UserCubit(
      getIt<UserService>(),
    ),
  );

  // Special Offers Feature
  getIt.registerLazySingleton<SpecialOffersService>(
    () => SpecialOffersService(),
  );

  getIt.registerFactory<SpecialOfferCubit>(
    () => SpecialOfferCubit(
      getIt<SpecialOffersService>(),
      getIt<ProductRepo>(),
    ),
  );
}
