import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_texts.dart';
import '../../../../core/utils/constants.dart';
import '../../data/models/section_model.dart';
import 'section_tile.dart';

class TermsOfServiceViewBody extends StatelessWidget {
  const TermsOfServiceViewBody({super.key});

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
              Icons.description_outlined,
              size: 40,
              color: AppColors.primary,
            ),
          ),
          const Gap(16),
          Text(
            AppTexts.termsOfService,
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
        title: AppTexts.acceptanceOfTerms,
        content: AppTexts.acceptanceOfTermsContent,
        icon: Icons.check_circle_outline,
      ),
      Section(
        title: AppTexts.userAccount,
        content: AppTexts.userAccountContent,
        icon: Icons.person_outline,
      ),
      Section(
        title: AppTexts.ordersAndPayment,
        content: AppTexts.ordersAndPaymentContent,
        icon: Icons.shopping_cart_outlined,
      ),
      Section(
        title: AppTexts.shippingAndDelivery,
        content: AppTexts.shippingAndDeliveryContent,
        icon: Icons.local_shipping_outlined,
      ),
      Section(
        title: AppTexts.returnsAndRefunds,
        content: AppTexts.returnsAndRefundsContent,
        icon: Icons.undo_outlined,
      ),
      Section(
        title: AppTexts.productInformation,
        content: AppTexts.productInformationContent,
        icon: Icons.info_outlined,
      ),
      Section(
        title: AppTexts.intellectualProperty,
        content: AppTexts.intellectualPropertyContent,
        icon: Icons.copyright_outlined,
      ),
      Section(
        title: AppTexts.limitationOfLiability,
        content: AppTexts.limitationOfLiabilityContent,
        icon: Icons.shield_outlined,
      ),
      Section(
        title: AppTexts.changesToTerms,
        content: AppTexts.changesToTermsContent,
        icon: Icons.edit_outlined,
      ),
      Section(
        title: AppTexts.contactInformation,
        content: AppTexts.contactInformationContent,
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
