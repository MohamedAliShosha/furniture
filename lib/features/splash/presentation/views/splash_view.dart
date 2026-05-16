import 'package:flutter/material.dart';
import '../../../../core/utils/app_router.dart';
import '../../../../core/utils/prefs_key.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/splash_view_body.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> with TickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> fadeAnimation;
  late Animation<double> scaleAnimation;
  late Animation<Offset> slideAnimation;

  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(microseconds: 2000),
    );
    fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
      ),
    );

    slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.3, 0.8, curve: Curves.easeOut),
      ),
    );

    scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.4, 1.0, curve: Curves.easeOut),
      ),
    );

    animationController.forward();
    // Navigate after splash animation
    executeNavigation();
    super.initState();
  }

  Future<void> executeNavigation() {
    return Future.delayed(const Duration(milliseconds: 2500), () async {
      // Creating an instance of SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      final bool hasSeenOnboarding =
          prefs.getBool(PrefsKeys.hasSeenOnboarding) ?? false;
      // Purpose: Determine initial route based on onboarding status at app launch
      if (mounted) {
        /*
        If true → LoginView (returning user)
        If false → OnboardingView (first-time user)
       */
        if (hasSeenOnboarding) {
          GoRouter.of(context).pushReplacement(AppRouter.kLoginView);
        } else {
          GoRouter.of(context).pushReplacement(AppRouter.kOnboardingView);
        }
      }
    });
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SplashViewBody(
          fadeAnimation: fadeAnimation,
          slideAnimation: slideAnimation,
          scaleAnimation: scaleAnimation),
    );
  }
}
