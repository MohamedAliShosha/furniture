import 'package:flutter/material.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/constants.dart';
import 'package:gap/gap.dart';

class AuthTextField extends StatefulWidget {
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
  State<AuthTextField> createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<AuthTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
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
          controller: widget.controller,
          validator: widget.validator,
          keyboardType: widget.keyboardType,
          obscureText: widget.isPassword ? _obscureText : false,
          enabled: widget.enabled,
          style: AppConstants.bodyStyle,
          decoration: InputDecoration(
            filled: true,
            fillColor:
                widget.enabled ? Colors.grey.shade100 : Colors.grey.shade50,
            hintText: widget.hintText,
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
            suffixIcon: widget.isPassword
                ? IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility_off : Icons.visibility,
                      color: AppColors.primary,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  )
                : null,
          ),
        ),
      ],
    );
  }
}
