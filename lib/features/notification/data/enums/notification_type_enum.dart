import 'package:flutter/material.dart';

enum NotificationType {
  // Define different types of notifications with associated icons and colors
  order(Icons.shopping_bag_outlined, Colors.blue),
  promotion(Icons.local_offer_outlined, Colors.orange),
  newArrival(Icons.new_releases_outlined, Colors.green),
  delivery(Icons.local_shipping_outlined, Colors.purple);

  final IconData icon;
  final Color color;

  const NotificationType(this.icon, this.color);
}
