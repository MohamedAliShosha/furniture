import 'package:furniture/features/auth/sign_up/presentation/views/sign_up_view.dart';
import 'package:furniture/features/onboarding/presentation/views/onboarding_view.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/forget_password/presentation/views/forget_password_view.dart';
import '../../features/auth/login/presentation/views/login_view.dart';
import '../../features/splash/presentation/views/splash_view.dart';

class AppRouter {
  static const kOnboardingView = '/onboardingView';
  static const kLoginView = '/loginView';
  static const kSignUpView = '/signUpView';
  static const kForgetPasswordView = '/forgetPasswordView';
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
      GoRoute(
        path: kSignUpView,
        builder: (context, state) => const SignUpView(),
      ),
      GoRoute(
        path: kForgetPasswordView,
        builder: (context, state) => const ForgetPasswordView(),
      ),
    ],
  );
}
