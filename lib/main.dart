import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/utils/theme.dart';
import 'core/utils/app_router.dart';
import 'features/cart/presentation/cubit/cart_cubit.dart';
import 'features/home/services/cart_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
  runApp(const Furniture());
}

class Furniture extends StatelessWidget {
  const Furniture({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CartCubit(CartService()),
      child: MaterialApp.router(
        theme: AppTheme.lightTheme,
        debugShowCheckedModeBanner: false,
        routerConfig: AppRouter.router,
      ),
    );
  }
}
