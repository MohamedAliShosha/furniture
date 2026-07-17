import 'package:flutter/material.dart';
import '../../../../core/utils/app_colors.dart';

class SearchCategoryChip extends StatelessWidget {
  const SearchCategoryChip({
    super.key,
    required this.label,
    required this.icon,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(
        label,
        style: TextStyle(
          color: Colors.grey[800],
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
      avatar: Icon(
        icon,
        size: 18,
        color: AppColors.primary,
      ),
      shape: StadiumBorder(
        side: BorderSide(
          color: AppColors.grey.withOpacity(0),
          width: 1,
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 4),
    );
  }
}
