import 'package:flutter/material.dart';
import '../../../../core/utils/constants.dart';
import '../../data/models/special_offer_model.dart';
import 'package:gap/gap.dart';

import '../../../../core/utils/app_texts.dart';
import '../../../../core/utils/app_images.dart';

class OfferCardWidget extends StatelessWidget {
  final int index;
  final VoidCallback? onTap;
  final SpecialOfferModel? offer;

  const OfferCardWidget({
    super.key,
    required this.index,
    this.offer,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 210,
        margin:
            const EdgeInsets.fromLTRB(10, 0, 10, AppConstants.defaultPadding),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius),
          child: Stack(
            fit: StackFit.expand,
            children: [
              // background gradient
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppConstants.primaryColor,
                      AppConstants.primaryColor.withOpacity(0.8),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
              // background furniture image
              Positioned(
                right: -20,
                bottom: -20,
                child: Opacity(
                  opacity: 0.85,
                  child: Image.asset(
                    AppImages.chairImages[index],
                    fit: BoxFit.contain,
                    height: 200,
                  ),
                ),
              ),
              // decoration circle
              Positioned(
                top: -30,
                right: -30,
                child: CircleAvatar(
                  radius: 100,
                  backgroundColor: Colors.white.withOpacity(0.1),
                ),
              ),
              Positioned(
                top: -20,
                right: -20,
                child: CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.white.withOpacity(0.1),
                ),
              ),
              // Content
              Padding(
                // content padding
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              offer!.title,
                              style: const TextStyle(
                                color: AppConstants.primaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ),
                          const Gap(8),
                          Text(
                            // should be offer.discountPercent
                            '${offer!.discountPercentage.toStringAsFixed(0)} % OFF',
                            style: AppConstants.headingStyle.copyWith(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Gap(4),
                          Text(
                            // should be offer.title
                            offer!.description,
                            style: AppConstants.bodyStyle.copyWith(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                          const Gap(2),
                          ElevatedButton(
                            onPressed: () {
                              // Navigate to offer screen
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: AppConstants.primaryColor,
                              elevation: 0,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 6,
                              ),
                              minimumSize: const Size(0, 32),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  AppConstants.smallBorderRadius,
                                ),
                              ),
                            ),
                            child: const Text(
                              AppTexts.shopNowButton,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Gap(90),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
