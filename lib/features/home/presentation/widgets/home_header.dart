import 'package:flutter/material.dart';
import '../../../../core/utils/app_images.dart';

import '../../../../core/utils/app_texts.dart';
import '../../../../core/utils/constants.dart';
import '../../data/models/user_model.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key, this.userModel});

  final UserModel? userModel;

  @override
  Widget build(BuildContext context) {
    return Row(
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
              userModel?.name ?? AppTexts.guestUser,
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
            backgroundImage: userModel?.profileImage != null
                ? NetworkImage(userModel!.profileImage!)
                : const AssetImage(
                    AppImages.profileImage,
                  ),
          ),
        ),
      ],
    );
  }
}
