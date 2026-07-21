import 'package:flutter/cupertino.dart';

import '../utils/app_colors.dart';

class CustomLoadingState extends StatelessWidget {
  const CustomLoadingState({
    super.key,
    this.color,
    this.radius,
  });

  final Color? color;
  final double? radius;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CupertinoActivityIndicator(
        color: color ?? AppColors.primary,
        radius: radius ?? 14,
      ),
    );
  }
}
