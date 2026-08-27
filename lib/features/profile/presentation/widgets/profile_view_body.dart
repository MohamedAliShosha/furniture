import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/utils/app_router.dart';
import '../../../../core/utils/app_texts.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/utils/service_locator.dart';
import '../../../orders/presentation/cubit/orders_cubit.dart';

import 'menu_section_widget.dart';
import 'profile_info.dart';

class ProfileViewBody extends StatelessWidget {
  const ProfileViewBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<OrdersCubit>()..loadOrders(),
      child: Column(
        children: [
          const Gap(16),
          Container(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top,
              bottom: AppConstants.defaultPadding,
              right: AppConstants.defaultPadding,
              left: AppConstants.defaultPadding,
            ),
            child: Row(
              children: [
                Text(
                  AppTexts.profileTitle,
                  style: AppConstants.headingStyle,
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {
                    GoRouter.of(context).push(AppRouter.kSettingsView);
                  },
                  icon: const Icon(
                    Icons.settings_outlined,
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Gap(24),
                  const ProfileInfo(),
                  const Gap(24),
                  buildMenuSection(context),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
