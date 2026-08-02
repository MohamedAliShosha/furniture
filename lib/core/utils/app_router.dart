import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furniture/features/blog/data/models/blog_model.dart';
import 'package:furniture/features/blog/presentation/views/blog_details_view.dart';
import 'package:furniture/features/orders/presentation/views/orders_history_view.dart';
import '../../features/category/presentation/views/category_view.dart';
import '../../features/featured_products/presentation/views/featured_products_view.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/forget_password/presentation/views/forget_password_view.dart';
import '../../features/auth/login/presentation/views/login_view.dart';
import '../../features/auth/sign_up/presentation/views/sign_up_view.dart';
import '../../features/home/data/models/product_model.dart';
import '../../features/onboarding/presentation/views/onboarding_view.dart';
import '../../features/product_details/presentation/views/product_details_view.dart';
import '../../features/search/presentation/views/search_view.dart';
import '../../features/shipping_address/presentation/views/shipping_address_view.dart';
import '../../features/special_offer/presentation/views/special_offer_view.dart';
import '../../features/splash/presentation/views/splash_view.dart';
import '../../features/payment_methods/presentation/views/payment_method_view.dart';
import '../../features/promo_codes/presentation/cubit/promo_code_cubit.dart';
import '../../features/promo_codes/presentation/views/promo_codes_view.dart';
import 'package:furniture/core/utils/service_locator.dart';
import '../../main_view.dart';

class AppRouter {
  static const kOnboardingView = '/onboardingView';
  static const kLoginView = '/loginView';
  static const kShippingAddressView = '/shippingAddressView';
  static const kOrdersHistoryView = '/ordersView';
  static const kBlogDetailsView = '/BlogDetailsView';
  static const kSpecialOfferView = '/specialOfferView';
  static const kCategoryView = '/categoryView';
  static const kSignUpView = '/signUpView';
  static const kMainView = '/mainView';
  static const kSearchView = '/searchView';
  static const kProductDetailsView = '/productDetailsView';
  static const kFeaturedProductsView = '/featuredProductsView';
  static const kForgetPasswordView = '/forgetPasswordView';
  static const kPaymentMethodView = '/paymentMethodView';
  static const kPromoCodesView = '/promoCodesView';

  static GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const SplashView(),
      ),
      GoRoute(
        path: kOnboardingView,
        builder: (context, state) => const OnboardingView(),
      ),
      GoRoute(
        path: kOrdersHistoryView,
        builder: (context, state) => const OrdersHistoryView(),
      ),
      GoRoute(
        path: kShippingAddressView,
        builder: (context, state) => const ShippingAddressView(),
      ),
      GoRoute(
        path: kSpecialOfferView,
        builder: (context, state) {
          final offerId = state.extra as String;
          return SpecialOffersView(offerId: offerId);
        },
      ),
      GoRoute(
        path: kCategoryView,
        builder: (context, state) {
          final category = state.extra as String;
          return CategoryView(
            // Pass the product data to the ProductDetailsView if needed
            category: category,
          );
        },
      ),
      GoRoute(
        path: kSearchView,
        builder: (context, state) => const SearchView(),
      ),
      GoRoute(
        path: kBlogDetailsView,
        builder: (context, state) {
          final blogModel = state.extra as BlogModel;
          return BlogDetailsView(
            title: blogModel.title,
            imageUrl: blogModel.imageUrl,
            date: blogModel.date,
            readTime: blogModel.readTime,
            blogId: blogModel.id,
          );
        },
      ),
      GoRoute(
        path: kLoginView,
        builder: (context, state) => const LoginView(),
      ),
      GoRoute(
        path: kSignUpView,
        builder: (context, state) => const SignUpView(),
      ),
      GoRoute(
        path: kForgetPasswordView,
        builder: (context, state) => const ForgetPasswordView(),
      ),
      GoRoute(
        path: kPaymentMethodView,
        builder: (context, state) => const PaymentMethodView(),
      ),
      GoRoute(
        path: kPromoCodesView,
        builder: (context, state) => BlocProvider(
          create: (_) => getIt<PromoCodeCubit>()..loadPromoCodes(),
          child: const PromoCodesView(),
        ),
      ),
      GoRoute(
        path: kMainView,
        builder: (context, state) => const MainView(),
      ),
      GoRoute(
        path: kFeaturedProductsView,
        builder: (context, state) => const FeaturedProductsView(),
      ),
      GoRoute(
        path: kProductDetailsView,
        builder: (context, state) {
          final product = state.extra as ProductModel;
          return ProductDetailsView(
            // Pass the product data to the ProductDetailsView if needed
            product: product,
          );
        },
      ),
    ],
  );
}
