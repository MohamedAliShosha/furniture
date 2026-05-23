import 'package:flutter/material.dart';
import 'package:furniture/features/home/services/user_service.dart';
import '../../../../core/utils/app_images.dart';

import '../../../../core/utils/app_texts.dart';
import '../../../../core/utils/constants.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final UserService userService = UserService();
    final user = userService.user;
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppTexts.hello,
                style: AppConstants.bodyStyle.copyWith(
                  color: Colors.grey,
                ),
              ),
              Text(
                user?.name ?? userService.user?.name ?? AppTexts.guestUser,
                style: AppConstants.headingStyle,
              ),
            ],
          ),
          GestureDetector(
            onTap: () {
              // navigate to account info screen
            },
            child: CircleAvatar(
              backgroundColor: Colors.grey[200],
              radius: 20,
              backgroundImage: user?.profileImage != null
                  ? NetworkImage(user!.profileImage!)
                  : const AssetImage(
                      AppImages.profileImage,
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
