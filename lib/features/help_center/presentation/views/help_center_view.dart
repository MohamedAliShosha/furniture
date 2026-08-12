import 'package:flutter/material.dart';
import 'package:furniture/core/widgets/custom_app_bar.dart';
import 'package:furniture/features/help_center/data/quick_search_item_model.dart';
import 'package:gap/gap.dart';
import '../../../../core/utils/app_texts.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/constants.dart';
import '../../data/faq_model.dart';
import '../widgets/help_center_search_text_field.dart';
import '../widgets/quick_help_item_grid_view.dart';
import '../widgets/still_need_help_widget_content.dart';

class HelpCenterView extends StatelessWidget {
  const HelpCenterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: const CustomAppBar(
        title: AppTexts.helpCenter,
      ),
      body: ListView(
        children: [
          _buildSearchBar(),
          _buildQuickHelp(context),
          _buildFAQSection(),
          _buildContactSupport(context),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.all(
        AppConstants.defaultPadding,
      ),
      child: const HelpCenterSearchTextField(),
    );
  }

  Widget _buildContactSupport(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(
        AppConstants.defaultPadding,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppTexts.stillNeedHelp,
            style: AppConstants.titleStyle.copyWith(
              fontSize: 18,
            ),
          ),
          const Gap(16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(
                AppConstants.defaultBorderRadius,
              ),
            ),
            child: const StillNeedHelpWidgetContent(),
          )
        ],
      ),
    );
  }

  Widget _buildFAQSection() {
    final faqs = [
      FAQModel(
        question: AppTexts.howDoITrackMyOrders,
        answer: AppTexts.visitOrdersInYourAccount,
      ),
      FAQModel(
        question: AppTexts.whatIsTheReturnPolicy,
        answer: AppTexts.returnPolicyDescription,
      ),
      FAQModel(
        question: AppTexts.howLongDoesDeliveryTake,
        answer: AppTexts.deliveryTypicalDuration,
      ),
      FAQModel(
        question: AppTexts.doYouOfferAssemblyServices,
        answer: AppTexts.assemblyServicesAnswer,
      )
    ];

    return Container(
      padding: const EdgeInsets.all(
        AppConstants.defaultPadding,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppTexts.frequentlyAskedQuestions,
            style: AppConstants.titleStyle.copyWith(
              fontSize: 18,
            ),
          ),
          const Gap(16),
          ExpansionPanelList.radio(
            elevation: 0,
            dividerColor: Colors.grey[200],
            children: faqs.map((faq) {
              return ExpansionPanelRadio(
                value: faq.question,
                headerBuilder: (context, isExpanded) {
                  return ListTile(
                    title: Text(
                      faq.question,
                      style: AppConstants.titleStyle.copyWith(
                        fontSize: 16,
                      ),
                    ),
                  );
                },
                body: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: Text(
                    faq.answer,
                    style: AppConstants.bodyStyle.copyWith(
                      color: Colors.grey[600],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickHelp(BuildContext context) {
    final quickHelp = [
      QuickSearchItemModel(
        icon: Icons.shopping_bag_outlined,
        title: AppTexts.trackOrderHelp,
        onTap: () {
          // Navigate o order tracking
        },
      ),
      QuickSearchItemModel(
        icon: Icons.assignment_return_outlined,
        title: AppTexts.returnsHelp,
        onTap: () {
          // Navigate to returns
        },
      ),
      QuickSearchItemModel(
        icon: Icons.payment_outlined,
        title: AppTexts.paymentHelp,
        onTap: () {
          // Navigate to payment help
        },
      ),
      QuickSearchItemModel(
        icon: Icons.support_agent_outlined,
        title: AppTexts.liveChatHelp,
        onTap: () {
          // Navigate to payment help
        },
      )
    ];
    return Container(
      padding: const EdgeInsets.all(
        AppConstants.defaultPadding,
      ),
      child: Column(
        children: [
          Text(
            AppTexts.quickHelp,
            style: AppConstants.titleStyle.copyWith(
              fontSize: 18,
            ),
          ),
          const Gap(16),
          QuickHelpItemsGridView(
            quickHelp: quickHelp,
          ),
        ],
      ),
    );
  }
}
