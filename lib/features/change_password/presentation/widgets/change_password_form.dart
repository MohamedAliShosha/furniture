import 'package:flutter/material.dart';
import 'package:furniture/core/utils/app_texts.dart';
import 'package:furniture/core/utils/service_locator.dart';
import 'package:furniture/features/home/presentation/cubit/user/user_cubit.dart';
import 'package:furniture/features/home/presentation/cubit/user/user_state.dart';
import 'package:gap/gap.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/constants.dart';
import 'password_badge.dart';

class ChangePasswordForm extends StatefulWidget {
  const ChangePasswordForm({
    super.key,
    required this.formKey,
  });

  final GlobalKey<FormState> formKey;

  @override
  State<ChangePasswordForm> createState() => _ChangePasswordFormState();
}

class _ChangePasswordFormState extends State<ChangePasswordForm> {
  final _currentPassWordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _obscureCurrentPassword = true;
  bool _obscureNewPassword = true;
  bool _obscureConfirmPassword = true;
  final bool _isLoading = false;

  @override
  void dispose() {
    _currentPassWordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();

    super.dispose();
  }

  final user = getIt<UserCubit>();

  Future<void> _changePassword() async {
    if (widget.formKey.currentState?.validate() ?? false) {
      final userCubit = getIt<UserCubit>();
      await userCubit.changePassword(
        currentPassword: _currentPassWordController.text.trim(),
        newPassword: _newPasswordController.text.trim(),
      );

      if (!mounted) return;

      final state = userCubit.state;
      if (state is UserSuccess) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(AppTexts.passwordChangedSuccessfully),
            backgroundColor: Colors.green,
          ),
        );

        _currentPassWordController.clear();
        _newPasswordController.clear();
        _confirmPasswordController.clear();
        widget.formKey.currentState?.reset();
      } else if (state is UserFailure) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(state.message),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Gap(20),
          Container(
            padding: const EdgeInsets.all(
              20,
            ),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const PasswordBadge(),
          ),
          const Gap(32),
          _buildPasswordField(
            label: AppTexts.currentPasswordLabel,
            controller: _currentPassWordController,
            obscureText: _obscureCurrentPassword,
            onToggleVisibility: () {
              setState(
                () {
                  _obscureCurrentPassword = !_obscureCurrentPassword;
                },
              );
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return AppTexts.enterCurrentPassword;
              }
              return null;
            },
          ),
          const Gap(24),
          _buildPasswordField(
            label: AppTexts.newPasswordLabel,
            controller: _newPasswordController,
            obscureText: _obscureNewPassword,
            onToggleVisibility: () {
              setState(
                () {
                  _obscureNewPassword = !_obscureNewPassword;
                },
              );
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return AppTexts.enterNewPassword;
              }
              if (value.length < 6) {
                return AppTexts.passwordMinLengthChange;
              }
              if (value == _currentPassWordController.text) {
                return AppTexts.newPasswordMustBeDifferent;
              }
              return null;
            },
          ),
          const Gap(24),
          _buildPasswordField(
            label: AppTexts.confirmNewPasswordLabel,
            controller: _confirmPasswordController,
            obscureText: _obscureConfirmPassword,
            onToggleVisibility: () {
              setState(
                () {
                  _obscureConfirmPassword = !_obscureConfirmPassword;
                },
              );
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return AppTexts.confirmNewPasswordRequired;
              }
              if (value != _newPasswordController.text) {
                return AppTexts.passwordsDoNotMatch;
              }
              return null;
            },
          ),
          const Gap(40),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              onPressed: user.isUserLoggedIn() ? _changePassword : null,
              child: _isLoading
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor:
                            AlwaysStoppedAnimation<Color>(AppColors.white),
                      ),
                    )
                  : const Text(
                      AppTexts.changePasswordButton,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildPasswordField({
    required String label,
    required TextEditingController controller,
    required bool obscureText,
    required VoidCallback onToggleVisibility,
    required String? Function(String?) validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppConstants.bodyStyle.copyWith(
            color: Colors.grey[700],
            fontWeight: FontWeight.w600,
          ),
        ),
        const Gap(8),
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          validator: validator,
          style: AppConstants.bodyStyle,
          decoration: InputDecoration(
            hintText: AppTexts.passwordEnterHint,
            hintStyle: AppConstants.bodyStyle.copyWith(
              color: Colors.grey[400],
            ),
            filled: true,
            fillColor: Colors.grey[100],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            suffixIcon: IconButton(
              onPressed: onToggleVisibility,
              icon: Icon(
                obscureText ? Icons.visibility_off : Icons.visibility,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
