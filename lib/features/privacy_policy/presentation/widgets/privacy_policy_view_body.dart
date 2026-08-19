import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_texts.dart';
import '../../../../core/utils/constants.dart';
import '../../data/models/section_model.dart';

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
            sections.map((section) => _buildSectionWidget(section)).toList(),
      ),
    );
  }

  Widget _buildSectionWidget(Section section) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ExpansionTile(
        shape: const RoundedRectangleBorder(
          side: BorderSide.none,
        ),
        childrenPadding: const EdgeInsets.all(16),
        leading: Container(
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.all(8),
          child: Icon(
            section.icon,
            color: AppColors.primary,
            size: 24,
          ),
        ),
        collapsedShape: const RoundedRectangleBorder(side: BorderSide.none),
        title: Text(
          section.title,
          style: AppConstants.titleStyle.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        children: [
          Text(
            section.content,
            style: AppConstants.bodyStyle.copyWith(
              color: Colors.grey[700],
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
