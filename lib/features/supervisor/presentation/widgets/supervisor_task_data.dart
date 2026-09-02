import 'package:flutter/material.dart';

class SupervisorTaskData {
  const SupervisorTaskData({
    required this.titleKey,
    required this.descriptionKey,
    required this.priorityKey,
    required this.priorityColor,
    required this.priorityBackgroundColor,
    required this.assigneeKey,
    required this.dueDate,
    this.assigneeInitials = const [],
    this.progress = 0,
    required this.statusKey,
    required this.statusColor,
    required this.statusBackgroundColor,
  });

  final String titleKey;
  final String descriptionKey;
  final String priorityKey;
  final Color priorityColor;
  final Color priorityBackgroundColor;
  final String assigneeKey;
  final String dueDate;
  final List<String> assigneeInitials;
  final double progress;
  final String statusKey;
  final Color statusColor;
  final Color statusBackgroundColor;
}
