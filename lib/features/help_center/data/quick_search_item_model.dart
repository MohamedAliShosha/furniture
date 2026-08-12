import 'package:flutter/material.dart';

class QuickSearchItemModel {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  QuickSearchItemModel({
    required this.icon,
    required this.title,
    required this.onTap,
  });
}
