import 'package:flutter/material.dart';

class AdminLocationData {
  const AdminLocationData({
    required this.nameKey,
    required this.descriptionKey,
    required this.addressKey,
    required this.statusKey,
    required this.icon,
    required this.iconColor,
    required this.iconBackgroundColor,
    this.isGeofenced = false,
  });

  final String nameKey;
  final String descriptionKey;
  final String addressKey;
  final String statusKey;
  final IconData icon;
  final Color iconColor;
  final Color iconBackgroundColor;
  final bool isGeofenced;
}
