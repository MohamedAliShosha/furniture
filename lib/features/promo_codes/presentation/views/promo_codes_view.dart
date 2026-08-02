import 'package:flutter/material.dart';
import 'package:furniture/core/utils/app_colors.dart';
import '../../../../core/utils/app_texts.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../widgets/add_promo_fab.dart';
import '../widgets/promo_codes_list.dart';
import '../widgets/promo_codes_tab_bar.dart';

class PromoCodesView extends StatelessWidget {
  const PromoCodesView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.white,
      appBar: CustomAppBar(title: AppTexts.promoCodes),
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            PromoCodesTabBar(),
            Expanded(
              child: TabBarView(
                children: [
                  PromoCodesList(isAvailable: true),
                  PromoCodesList(isAvailable: false),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: AddPromoFloatingActionButton(),
    );
  }
}
