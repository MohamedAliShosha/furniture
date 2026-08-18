import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_texts.dart';
import '../../../../core/utils/constants.dart';
import '../../data/models/section_model.dart';
import 'section_tile.dart';

class PrivacyPolicyViewBody extends StatelessWidget {
  const PrivacyPolicyViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildHeader(),
          _buildContent(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppColors.primary.withOpacity(0.1),
      ),
      width: double.infinity,
      padding: const EdgeInsets.all(AppConstants.defaultPadding),
      margin: const EdgeInsets.all(AppConstants.defaultPadding),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.privacy_tip_outlined,
              size: 40,
              color: AppColors.primary,
            ),
          ),
          const Gap(16),
          Text(
            AppTexts.yourPrivacyMatters,
            style: AppConstants.headingStyle.copyWith(
              fontSize: 24,
              color: AppColors.primary,
            ),
          ),
          const Gap(8),
          Text(
            AppTexts.lastUpdated,
            style: AppConstants.bodyStyle.copyWith(
              color: Colors.grey[600],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildContent() {
    final sections = [
      Section(
        title: AppTexts.informationWeCollect,
        content: AppTexts.informationWeCollectContent,
        icon: Icons.info_outline,
      ),
      Section(
        title: AppTexts.howWeUseYourInformation,
        content: AppTexts.howWeUseYourInformationContent,
        icon: Icons.how_to_reg_outlined,
      ),
      Section(
        title: AppTexts.dataSecurity,
        content: AppTexts.dataSecurityContent,
        icon: Icons.security_outlined,
      ),
      Section(
        title: AppTexts.yourRights,
        content: AppTexts.yourRightsContent,
        icon: Icons.verified_user_outlined,
      ),
      Section(
        title: AppTexts.informationSharing,
        content: AppTexts.informationSharingContent,
        icon: Icons.share_outlined,
      ),
      Section(
        title: AppTexts.contactUs,
        content: AppTexts.contactUsContent,
        icon: Icons.contact_support_outlined,
      ),
    ];
    return Padding(
      padding: const EdgeInsets.all(
        AppConstants.defaultPadding,
      ),
      child: Column(
        children:
            sections.map((section) => SectionTile(section: section)).toList(),
      ),
    );
  }
}
