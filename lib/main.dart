import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furniture/firebase_options.dart';
import 'core/utils/app_bloc_observer.dart';
import 'core/utils/theme.dart';
import 'core/utils/app_router.dart';
import 'core/utils/service_locator.dart';
import 'core/utils/shared_pref_service.dart';
import 'features/blog/presentation/cubit/blog_cubit.dart';
import 'features/cart/presentation/cubit/cart_cubit.dart';
import 'features/special_offer/presentation/cubit/special_offer_cubit.dart';
import 'features/wishlist/presentation/cubit/wishlist_cubit.dart';
import 'features/home/presentation/cubit/user/user_cubit.dart';
import 'features/notification/presentation/cubit/notification_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Prefs.init();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.dark,
        systemNavigationBarIconBrightness: Brightness.dark),
  );
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  // make the app only displayed on the phone
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  Bloc.observer = AppBlocObserver();
  setupServiceLocator();
  runApp(const Furniture());
}

class Furniture extends StatelessWidget {
  const Furniture({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<UserCubit>(),
        ),
        BlocProvider(
          create: (context) => getIt<BlogCubit>(),
        ),
        BlocProvider(
          create: (context) => getIt<CartCubit>(),
        ),
        BlocProvider(
          create: (context) => getIt<WishlistCubit>(),
        ),
        BlocProvider(
          create: (context) => getIt<SpecialOfferCubit>(),
        ),
        BlocProvider(
          create: (context) => getIt<NotificationCubit>()..loadNotifications(),
        ),
      ],
      child: MaterialApp.router(
        theme: AppTheme.lightTheme,
        debugShowCheckedModeBanner: false,
        routerConfig: AppRouter.router,
      ),
    );
  }
}
