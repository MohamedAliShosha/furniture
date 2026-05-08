import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';

import 'core/utils/constants.dart';
import 'features/blog/presentation/views/blog_view.dart';
import 'features/cart/presentation/views/cart_view.dart';
import 'features/home/presentation/views/home_view.dart';
import 'features/profile/presentation/views/profile_view.dart';
import 'features/wishlist/presentation/views/wishlist_view.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int currentViewIndex = 0;
  final pageController = PageController(initialPage: 0);
  final List<Widget> views = [
    const HomeView(),
    const CartView(),
    const WishlistView(),
    const BlogView(),
    const ProfileView(),
  ];

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // widget configures the system UI appearance for the entire app:
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        // Sets status bar background to white
        statusBarColor: Colors.white,
        // Makes status bar icons dark (time, battery, etc.) for visibility on white background
        statusBarIconBrightness: Brightness.dark,
        // Sets system navigation bar icons to dark
        systemNavigationBarIconBrightness: Brightness.dark,
        // Sets system navigation bar background to white (Android)
        systemNavigationBarColor: Colors.white,
      ),
      child: Scaffold(
        body: PageView.builder(
          onPageChanged: (index) {
            setState(() {
              currentViewIndex = index;
            });
          },
          controller: pageController,
          itemCount: views.length,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) => views[index],
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                blurRadius: 10,
                spreadRadius: 1,
              ),
            ],
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  buildNavItem(
                    index: 0,
                    icon: Icons.home,
                    activeIcon: Icons.home_outlined,
                    label: 'Home',
                  ),
                  buildNavItem(
                    index: 1,
                    icon: Icons.shopping_cart,
                    activeIcon: Icons.shopping_cart_outlined,
                    label: 'Cart',
                  ),
                  buildNavItem(
                    index: 2,
                    icon: Icons.favorite_border,
                    activeIcon: Icons.favorite,
                    label: 'Wishlist',
                  ),
                  buildNavItem(
                    index: 3,
                    icon: Icons.article_outlined,
                    activeIcon: Icons.article,
                    label: 'Blog',
                  ),
                  buildNavItem(
                    index: 4,
                    icon: Icons.person_outline,
                    activeIcon: Icons.person,
                    label: 'Profile',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildNavItem({
    required int index,
    required IconData icon,
    required IconData activeIcon,
    required String label,
  }) {
    final isSelected = currentViewIndex == index;
    return InkWell(
      onTap: () {
        setState(() {
          currentViewIndex = index;
          pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 8,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? AppConstants.primaryColor.withOpacity(0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isSelected ? activeIcon : icon,
              color: isSelected ? AppConstants.primaryColor : Colors.grey,
              size: 24,
            ),
            const Gap(4),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? AppConstants.primaryColor : Colors.grey,
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
