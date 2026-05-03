import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:furniture/core/utils/theme.dart';

import 'core/utils/app_router.dart';

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

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      routerConfig: AppRouter.router,
    );
  }
}
