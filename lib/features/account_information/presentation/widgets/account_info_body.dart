import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_texts.dart';
import '../../../../core/utils/constants.dart';
import '../../../home/presentation/cubit/user/user_cubit.dart';
import '../../../home/presentation/cubit/user/user_state.dart';
import 'account_info_card.dart';
import 'account_info_form_fields.dart';
import 'account_profile_avatar.dart';

class AccountInfoViewBody extends StatelessWidget {
  const AccountInfoViewBody({
    super.key,
    required GlobalKey<FormState> formKey,
    required bool isEditing,
    required TextEditingController nameController,
    required TextEditingController emailController,
    required TextEditingController phoneController,
  })  : _formKey = formKey,
        _isEditing = isEditing,
        _nameController = nameController,
        _emailController = emailController,
        _phoneController = phoneController;

  final GlobalKey<FormState> _formKey;
  final bool _isEditing;
  final TextEditingController _nameController;
  final TextEditingController _emailController;
  final TextEditingController _phoneController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        final user = state is UserSuccess ? state.user : null;
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(AppConstants.defaultPadding),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Gap(24),
                  AccountProfileAvatar(
                    isEditing: _isEditing,
                    imageUrl: user?.profileImage,
                  ),
                  const Gap(32),
                  AccountInfoFormFields(
                    nameController: _nameController,
                    emailController: _emailController,
                    phoneController: _phoneController,
                    isEditing: _isEditing,
                  ),
                  if (!_isEditing) ...[
                    const Gap(32),
                    AccountInfoCard(
                      title: AppTexts.accountInfoStatus,
                      content: user?.isActive == true
                          ? AppTexts.accountInfoActive
                          : AppTexts.accountInfoInactive,
                      icon: Icons.check_circle,
                      color: user?.isActive == true
                          ? AppColors.green
                          : AppColors.red,
                    ),
                    const Gap(32),
                    AccountInfoCard(
                      title: AppTexts.accountInfoMemberSince,
                      content: user?.memberSince != null
                          ? '${user!.memberSince!.month}/${user.memberSince!.year}'
                          : AppTexts.accountInfoNotAvailable,
                      icon: Icons.calendar_today,
                      color: AppColors.primary,
                    ),
                  ]
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
