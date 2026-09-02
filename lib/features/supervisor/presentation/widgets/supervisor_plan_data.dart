import 'package:flutter/material.dart';

class SupervisorPlanData {
  const SupervisorPlanData({
    required this.titleKey,
    required this.typeKey,
    required this.dateTime,
    required this.descriptionKey,
    required this.assigneeInitials,
    required this.iconColor,
    required this.iconBackgroundColor,
  });

  final String titleKey;
  final String typeKey;
  final String dateTime;
  final String descriptionKey;
  final List<String> assigneeInitials;
  final Color iconColor;
  final Color iconBackgroundColor;
}
