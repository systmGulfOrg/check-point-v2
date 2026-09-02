import 'package:flutter/material.dart';

class AdminAttendanceRecordData {
  const AdminAttendanceRecordData({
    required this.initials,
    required this.nameKey,
    required this.time,
    required this.branch,
    required this.statusKey,
    required this.statusColor,
    required this.statusBackgroundColor,
  });

  final String initials;
  final String nameKey;
  final String time;
  final String branch;
  final String statusKey;
  final Color statusColor;
  final Color statusBackgroundColor;
}
