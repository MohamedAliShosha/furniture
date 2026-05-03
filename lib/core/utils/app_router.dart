import 'package:furniture/features/onboarding/presentation/views/onboarding_view.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/login/presentation/views/login_view.dart';
import '../../features/splash/presentation/views/splash_view.dart';

class AppRouter {
  static const kOnboardingView = '/onboardingView';
  static const kLoginView = '/loginView';
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
        path: kLoginView,
        builder: (context, state) => const LoginView(),
      ),
    ],
  );
}
