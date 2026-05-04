import 'package:flutter/material.dart';
import 'package:furniture/core/utils/constants.dart';
import 'package:gap/gap.dart';

class AuthTextField extends StatelessWidget {
  const AuthTextField({
    super.key,
    required this.hintText,
    required this.label,
    this.isPassword = false,
    required this.controller,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.enabled = true,
  });

  final String hintText;
  final String label;
  final bool isPassword;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppConstants.bodyStyle.copyWith(
            color: Colors.grey.shade700,
            fontWeight: FontWeight.w400,
          ),
        ),
        const Gap(8),
        TextFormField(
          onTapOutside: (event) {
            FocusScope.of(context).unfocus();
          },
          cursorColor: Colors.black,
          cursorHeight: 15,
          controller: controller,
          validator: validator,
          keyboardType: keyboardType,
          obscureText: isPassword,
          enabled: enabled,
          style: AppConstants.bodyStyle,
          decoration: InputDecoration(
            filled: true,
            fillColor: enabled ? Colors.grey.shade100 : Colors.grey.shade50,
            hintText: hintText,
            hintStyle: AppConstants.bodyStyle.copyWith(
              color: Colors.grey.shade400,
            ),
            border: OutlineInputBorder(
              borderRadius:
                  BorderRadius.circular(AppConstants.defaultBorderRadius),
              borderSide: BorderSide.none,
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          ),
        ),
      ],
    );
  }
}
