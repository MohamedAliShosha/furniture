import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_images.dart';
import '../../../../core/utils/constants.dart';

class AccountProfileAvatar extends StatelessWidget {
  const AccountProfileAvatar({
    super.key,
    required this.isEditing,
    this.imageUrl,
  });

  final bool isEditing;
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    final imageProvider = imageUrl != null
        ? NetworkImage(imageUrl!)
        : const AssetImage(AppImages.profileImage) as ImageProvider;

    return Center(
      child: Stack(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundColor: AppColors.grey,
            backgroundImage: imageProvider,
          ),
          if (isEditing)
            Positioned(
              right: 0,
              bottom: 0,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: AppConstants.primaryColor,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.camera_alt,
                  color: AppColors.white,
                  size: 20,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
