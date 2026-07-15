import 'package:flutter/material.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/constants.dart';

class ColorSelector extends StatefulWidget {
  const ColorSelector({
    super.key,
    required this.colors,
  });

  final List<String> colors;

  @override
  State<ColorSelector> createState() => _ColorSelectorState();
}

class _ColorSelectorState extends State<ColorSelector> {
  String? _selectedColor;

  @override
  void initState() {
    super.initState();
    _selectedColor = widget.colors.isNotEmpty ? widget.colors[0] : '#FFFFFF';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Select Color',
          style: AppConstants.bodyStyle.copyWith(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: widget.colors.map((colorHex) {
            final isSelected = _selectedColor == colorHex;
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedColor = colorHex;
                });
              },
              child: Container(
                margin: const EdgeInsets.only(right: 12),
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isSelected ? AppColors.primary : Colors.transparent,
                    width: 2,
                  ),
                ),
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: Color(
                      int.parse(
                        colorHex.replaceFirst('#', '0xFF'),
                      ),
                    ),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
