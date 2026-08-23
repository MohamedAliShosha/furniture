import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furniture/core/utils/app_texts.dart';
import 'package:furniture/features/home/data/models/user_model.dart';
import 'package:furniture/features/home/presentation/cubit/user/user_cubit.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../widgets/account_info_body.dart';

class AccountInfoView extends StatefulWidget {
  const AccountInfoView({super.key});

  @override
  State<AccountInfoView> createState() => _AccountInfoViewState();
}

class _AccountInfoViewState extends State<AccountInfoView> {
  bool _isEditing = false;
  final GlobalKey<FormState> _formKey = GlobalKey();
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;

  @override
  void initState() {
    super.initState();
    final userCubit = context.read<UserCubit>();
    final currentUser = userCubit.getCurrentUser();

    if (currentUser == null) {
      userCubit.setUser(
        UserModel(
          id: 'guest-user',
          name: AppTexts.guestUser,
          email: AppTexts.noEmail,
          phoneNumber: null,
          profileImage: null,
          memberSince: DateTime.now(),
        ),
      );
    }

    _nameController = TextEditingController(
      text: userCubit.getCurrentUser()?.name ?? AppTexts.guestUser,
    );
    _emailController = TextEditingController(
      text: userCubit.getCurrentUser()?.email ?? AppTexts.noEmail,
    );
    _phoneController = TextEditingController(
      text: userCubit.getCurrentUser()?.phoneNumber ?? '',
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _saveChanges() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();

      final userCubit = context.read<UserCubit>();
      userCubit.updateUser(
        name: _nameController.text,
        email: _emailController.text,
        phone: _phoneController.text,
      );

      setState(() {
        _isEditing = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: AppColors.green,
          content: Center(
            child: Text(
              AppTexts.accountInfoUpdatedSuccessfully,
            ),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CustomAppBar(
        title: AppTexts.accountInformationTitle,
        actions: [
          TextButton(
            onPressed: () {
              if (_isEditing) {
                _saveChanges();
              } else {
                setState(() {
                  _isEditing = true;
                });
              }
            },
            child: Text(
              _isEditing ? AppTexts.accountInfoSave : AppTexts.accountInfoEdit,
              style: AppConstants.bodyStyle.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          )
        ],
      ),
      body: AccountInfoViewBody(
        formKey: _formKey,
        isEditing: _isEditing,
        nameController: _nameController,
        emailController: _emailController,
        phoneController: _phoneController,
      ),
    );
  }
}
