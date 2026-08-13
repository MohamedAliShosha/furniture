import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_texts.dart';
import '../../../../core/utils/constants.dart';
import '../../data/models/social_link_model.dart';
import '../../data/models/value_model.dart';

class AboutUsViewBody extends StatelessWidget {
  const AboutUsViewBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildHeader(),
          _buildMission(),
          _buildValues(),
          _buildTeam(),
          _buildSocialMedia(),
          _buildAppInfo(context),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(
        AppConstants.defaultPadding,
      ),
      child: Column(
        children: [
          Container(
            height: 120,
            width: 120,
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.chair_outlined,
              size: 60,
              color: AppColors.primary,
            ),
          ),
          const Gap(24),
          Text(
            AppTexts.furnitureShop,
            style: AppConstants.headingStyle.copyWith(
              color: AppColors.primary,
            ),
          ),
          const Gap(8),
          Text(
            AppTexts.furnitureShopTagline,
            textAlign: TextAlign.center,
            style: AppConstants.headingStyle.copyWith(
              color: Colors.grey[600],
              fontSize: 16,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildMission() {
    return Container(
      padding: const EdgeInsets.all(
        AppConstants.defaultPadding,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppTexts.ourMission,
            style: AppConstants.titleStyle.copyWith(
              fontSize: 20,
            ),
          ),
          const Gap(16),
          Text(
            AppTexts.missionDescription,
            style: AppConstants.bodyStyle.copyWith(
              height: 1.5,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildValues() {
    final values = [
      ValueModel(
        icon: Icons.verified_outlined,
        title: AppTexts.qualityTitle,
        desc: AppTexts.qualityDescription,
      ),
      ValueModel(
        icon: Icons.design_services_outlined,
        title: AppTexts.designTitle,
        desc: AppTexts.designDescription,
      ),
      ValueModel(
        icon: Icons.eco_outlined,
        title: AppTexts.sustainabilityTitle,
        desc: AppTexts.sustainabilityDescription,
      ),
      ValueModel(
        icon: Icons.support_agent_outlined,
        title: AppTexts.serviceTitle,
        desc: AppTexts.serviceDescription,
      ),
    ];
    return Container(
      padding: const EdgeInsets.all(
        AppConstants.defaultPadding,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppTexts.ourValues,
            style: AppConstants.titleStyle.copyWith(
              fontSize: 20,
            ),
          ),
          const Gap(16),
          GridView.builder(
            shrinkWrap: true,
            itemCount: values.length,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 1.15,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              crossAxisCount: 2,
            ),
            itemBuilder: (context, index) {
              final value = values[index];
              return Container(
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(
                    AppConstants.defaultBorderRadius,
                  ),
                ),
                padding: const EdgeInsets.all(
                  16,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      value.icon,
                      color: AppColors.primary,
                      size: 32,
                    ),
                    const Gap(12),
                    Text(
                      value.title,
                      style: AppConstants.titleStyle.copyWith(
                        fontSize: 16,
                      ),
                    ),
                    const Gap(8),
                    Text(
                      textAlign: TextAlign.center,
                      value.desc,
                      style: AppConstants.bodyStyle.copyWith(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              );
            },
          )
        ],
      ),
    );
  }

  Widget _buildTeam() {
    return Container(
      padding: const EdgeInsets.all(
        AppConstants.defaultPadding,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppTexts.ourTeam,
            style: AppConstants.titleStyle.copyWith(
              fontSize: 20,
            ),
          ),
          const Gap(16),
          Text(
            AppTexts.teamDescription,
            style: AppConstants.bodyStyle.copyWith(
              height: 1.5,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialMedia() {
    final socialLinks = [
      SocialLinkModel(
        icon: Icons.facebook_outlined,
        name: AppTexts.facebook,
        url: AppTexts.facebookUrl,
      ),
      SocialLinkModel(
        icon: Icons.camera_alt_outlined,
        name: AppTexts.instagram,
        url: AppTexts.instagramUrl,
      ),
      SocialLinkModel(
        icon: Icons.phone_outlined,
        name: AppTexts.contact,
        url: AppTexts.contactUrl,
      ),
      SocialLinkModel(
        icon: Icons.email_outlined,
        name: AppTexts.email,
        url: AppTexts.emailUrl,
      ),
    ];
    return Container(
      padding: const EdgeInsets.all(
        AppConstants.defaultPadding,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppTexts.connectWithUs,
            style: AppConstants.titleStyle.copyWith(
              fontSize: 20,
            ),
          ),
          const Gap(16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: socialLinks
                .map(
                  (link) => Column(
                    children: [
                      IconButton(
                        onPressed: () {
                          // open social media link
                        },
                        icon: Icon(link.icon),
                        color: AppColors.primary,
                        iconSize: 32,
                      ),
                      const Gap(4),
                      Text(
                        link.name,
                        style: AppConstants.bodyStyle.copyWith(
                          fontSize: 12,
                        ),
                      )
                    ],
                  ),
                )
                .toList(),
          )
        ],
      ),
    );
  }

  Widget _buildAppInfo(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(
        AppConstants.defaultPadding,
      ),
      child: Column(
        children: [
          Divider(
            color: Colors.grey[200],
          ),
          const Gap(16),
          Text(
            AppTexts.version,
            style: AppConstants.bodyStyle.copyWith(
              color: Colors.grey[600],
              fontSize: 14,
            ),
          ),
          const Gap(8),
          Text(
            AppTexts.copyright,
            style: AppConstants.bodyStyle.copyWith(
              color: Colors.grey[600],
              fontSize: 14,
            ),
          ),
          const Gap(16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
               TextButton(
                 onPressed: () {
                   // Navigate to PP view
                 },
                 child: const Text(
                   AppTexts.privacyPolicy,
                 ),
               ),
               const Text(
                 AppTexts.dotSeparator,
                 style: TextStyle(fontSize: 20),
               ),
               TextButton(
                 onPressed: () {
                   // Navigate to TS view
                 },
                 child: const Text(
                   AppTexts.termsOfService,
                 ),
               )
            ],
          )
        ],
      ),
    );
  }
}
