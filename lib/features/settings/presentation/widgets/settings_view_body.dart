import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_router.dart';
import '../../../../core/utils/app_texts.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/utils/service_locator.dart';
import '../../../home/presentation/cubit/user/user_cubit.dart';
import '../../../home/presentation/cubit/user/user_state.dart';
import '../../../notification/presentation/cubit/notification_cubit.dart';
import '../../../notification/presentation/cubit/notification_state.dart';
import '../../../profile/presentation/widgets/logout_dialog.dart';

class SettingsViewBody extends StatelessWidget {
  const SettingsViewBody({super.key});

  void _handleSignInOut(BuildContext context) {
    final user = getIt<UserCubit>();
    if (user.isUserLoggedIn()) {
      LogoutDialog.show(context);
    } else {
      GoRouter.of(context).push(AppRouter.kLoginView);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle(AppTexts.accountSection),
          BlocBuilder<UserCubit, UserState>(
            builder: (context, state) {
              final user = state is UserSuccess ? state.user : null;
              return _buildSettingsItem(
                icon: Icons.person_outline,
                title: AppTexts.accountInformation,
                subTitle: user?.name ?? AppTexts.notSignedIn,
                onTap: () {
                  // navigate to account info screen
                },
              );
            },
          ),
          BlocBuilder<UserCubit, UserState>(
            builder: (context, state) {
              final isLoggedIn = state is UserSuccess && state.isLoggedIn;
              if (!isLoggedIn) {
                return const SizedBox.shrink();
              }
              return _buildSettingsItem(
                icon: Icons.lock_outline,
                title: AppTexts.changePassword,
                subTitle: AppTexts.changeYourAccountPassword,
                onTap: () {
                  // navigate to change password screen
                  GoRouter.of(context).push(AppRouter.kChangePasswordView);
                },
              );
            },
          ),
          _buildSectionTitle(AppTexts.preferencesSection),
          BlocBuilder<UserCubit, UserState>(
            builder: (context, state) {
              final isLoggedIn = state is UserSuccess && state.isLoggedIn;
              return BlocBuilder<NotificationCubit, NotificationState>(
                builder: (context, state) {
                  final pushEnabled =
                      state is NotificationSuccess ? state.pushEnabled : false;
                  return _buildSettingsItem(
                    icon: Icons.notifications_outlined,
                    title: AppTexts.pushNotifications,
                    subTitle: AppTexts.receiveValidationSettings,
                    trailing: Switch(
                      value: isLoggedIn && pushEnabled,
                      onChanged: isLoggedIn
                          ? (value) {
                              context
                                  .read<NotificationCubit>()
                                  .togglePush(value);
                            }
                          : null,
                      activeColor: AppColors.primary,
                    ),
                    onTap: () {
                      // navigate to notification view
                    },
                  );
                },
              );
            },
          ),
          _buildSectionTitle(AppTexts.supportSection),
          _buildSettingsItem(
            icon: Icons.help_outline,
            title: AppTexts.helpCenter,
            subTitle: AppTexts.getHelpAndFindAnswers,
            onTap: () {
              GoRouter.of(context).push(AppRouter.kHelpCenterView);
            },
          ),
          _buildSettingsItem(
            icon: Icons.privacy_tip_outlined,
            title: AppTexts.privacyPolicy,
            subTitle: AppTexts.readOurPrivacyPolicy,
            onTap: () {
              // Navigate to privacy policy view
            },
          ),
          _buildSettingsItem(
            icon: Icons.description_outlined,
            title: AppTexts.termsOfService,
            subTitle: AppTexts.readOurTermsOfService,
            onTap: () {
              // Navigate to terms of service view
            },
          ),
          BlocBuilder<UserCubit, UserState>(
            builder: (context, state) {
              final isLoggedIn = state is UserSuccess && state.isLoggedIn;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (isLoggedIn) ...[
                    _buildSectionTitle(AppTexts.dangerZone),
                    _buildSettingsItem(
                      icon: Icons.logout,
                      title: AppTexts.signOut,
                      subTitle: AppTexts.signoutOfYourAccount,
                      textColor: AppColors.red,
                      onTap: () => _handleSignInOut(context),
                    ),
                  ] else
                    _buildSettingsItem(
                      icon: Icons.login,
                      title: AppTexts.signIn,
                      subTitle: AppTexts.signInToAccessAllFeatures,
                      textColor: AppColors.primary,
                      onTap: () => _handleSignInOut,
                    ),
                ],
              );
            },
          ),
          const Gap(32),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Text(
        title,
        style: AppConstants.titleStyle.copyWith(
          color: Colors.grey[800],
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildSettingsItem(
      {required IconData icon,
      required String title,
      required String subTitle,
      Widget? trailing,
      VoidCallback? onTap,
      Color? textColor}) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      leading: Container(
        decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.all(8),
        child: Icon(
          icon,
          color: textColor ?? AppColors.primary,
        ),
      ),
      title: Text(
        title,
        style: AppConstants.titleStyle.copyWith(
          fontSize: 16,
          color: textColor,
        ),
      ),
      subtitle: Text(
        subTitle,
        style: AppConstants.bodyStyle.copyWith(
          fontSize: 12,
          color: Colors.grey,
        ),
      ),
      trailing: trailing ??
          Icon(
            Icons.arrow_forward_ios,
            size: 16,
            color: Colors.grey[400],
          ),
      onTap: onTap,
    );
  }
}
