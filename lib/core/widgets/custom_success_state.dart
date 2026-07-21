import 'package:flutter/material.dart';
import '../utils/constants.dart';

class CustomSuccessState extends StatelessWidget {
  const CustomSuccessState({
    super.key,
    required this.child,
    this.padding,
  });

  final Widget child;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.all(AppConstants.defaultPadding),
      child: child,
    );
  }
}
