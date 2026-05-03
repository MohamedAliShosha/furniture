import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/utils/app_router.dart';
import '../../../../core/utils/app_images.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/utils/prefs_key.dart';
import '../../data/models/onboarding_page_model.dart';
import '../widgets/page_view_item.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final PageController pageController = PageController();
  int currentView = 0;
  final List<OnboardingPage> pages = [
    OnboardingPage(
      image: AppImages.onboarding1,
      title: AppText.onboardingTitle1,
      description: AppText.onboardingDescription1,
    ),
    OnboardingPage(
      image: AppImages.onboarding2,
      title: AppText.onboardingTitle2,
      description: AppText.onboardingDescription2,
    ),
    OnboardingPage(
      image: AppImages.onboarding3,
      title: AppText.onboardingTitle3,
      description: AppText.onboardingDescription3,
    ),
  ];

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  Future<void> _markOnboardingAsSeen() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(PrefsKeys.hasSeenOnboarding, true);
  }

  // Making onboarding as seen then navigate to login
  Future<void> _navigateToLogin() async {
    await _markOnboardingAsSeen();
    if (mounted) {
      GoRouter.of(context).pushReplacement(AppRouter.kLoginView);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        // Page View
        children: [
          PageView.builder(
            controller: pageController,
            itemCount: pages.length,
            onPageChanged: (index) {
              setState(() {
                currentView = index;
              });
            },
            itemBuilder: (context, index) {
              final page = pages[index];
              return PageViewItem(page: page);
            },
          ),
          Positioned(
            top: MediaQuery.of(context).padding.top + 16,
            right: 16,
            child: TextButton(
              // When the user clicks skip => make onboarding seen then navigate to the login
              onPressed: _navigateToLogin,
               child: Text(
                 AppText.skip,
                 style: TextStyle(
                     fontSize: 16,
                     fontWeight: FontWeight.w500,
                     color: Colors.grey.shade600),
               ),
            ),
          ),

          // bottom control
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.all(24),
              // Page Indicator
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: List.generate(
                      pages.length,
                      (index) => Container(
                        margin: const EdgeInsets.only(right: 8),
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: currentView == index
                              ? AppConstants.primaryColor
                              : Colors.grey.shade300,
                        ),
                      ),
                    ),
                  ),
                  // Next Button
                  ElevatedButton(
                    /*
                      Pages 0-1: Normal page navigation
                      Page 2 (last): Calls _navigateToLogin()
                     */
                    onPressed: () {
                      if (currentView < pages.length - 1) {
                        pageController.nextPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                        );
                      } else {
                        _navigateToLogin();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppConstants.primaryColor,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 16,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          AppConstants.defaultBorderRadius,
                        ),
                      ),
                      minimumSize: const Size(120, 40),
                    ),
                     child: Text(
                       currentView == pages.length - 1 ? AppText.getStarted : AppText.next,
                       style: const TextStyle(
                         fontSize: 16,
                         fontWeight: FontWeight.w600,
                       ),
                     ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
