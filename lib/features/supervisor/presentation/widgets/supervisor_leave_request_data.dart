import 'package:flutter/material.dart';

class SupervisorLeaveRequestData {
  const SupervisorLeaveRequestData({
    required this.initials,
    required this.nameKey,
    required this.typeKey,
    required this.dateRange,
    required this.reasonKey,
    required this.statusKey,
    required this.statusColor,
    required this.statusBackgroundColor,
    this.attachmentUrl,
  });

  final String initials;
  final String nameKey;
  final String typeKey;
  final String dateRange;
  final String reasonKey;
  final String statusKey;
  final Color statusColor;
  final Color statusBackgroundColor;
  final String? attachmentUrl;
}
