import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';

import '../../../../core/utils/constants.dart';
import '../../data/models/onboarding_page_model.dart';

class PageViewItem extends StatelessWidget {
  const PageViewItem({
    super.key,
    required this.page,
  });

  final OnboardingPage page;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xffFFF3D9),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          // image
          Image.asset(
            fit: BoxFit.contain,
            page.image,
            height: MediaQuery.of(context).size.height * 0.4,
          ),
          const Spacer(),
          // content
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                Text(
                  page.title,
                  textAlign: TextAlign.center,
                  style: AppConstants.headingStyle.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
                  ),
                ),
                const Gap(16),
                Text(
                  page.description,
                  textAlign: TextAlign.center,
                  style: AppConstants.bodyStyle.copyWith(
                    color: Colors.grey.shade600,
                    fontSize: 16,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
