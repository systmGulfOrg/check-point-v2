import 'package:flutter/material.dart';

class AdminLeaveRequestData {
  const AdminLeaveRequestData({
    required this.initials,
    required this.nameKey,
    required this.leaveTypeKey,
    required this.dateRange,
    required this.reasonKey,
    required this.appliedDate,
    required this.statusKey,
    required this.statusColor,
    required this.statusBackgroundColor,
  });

  final String initials;
  final String nameKey;
  final String leaveTypeKey;
  final String dateRange;
  final String reasonKey;
  final String appliedDate;
  final String statusKey;
  final Color statusColor;
  final Color statusBackgroundColor;

  bool get isPending => statusKey == 'supervisor.leave.pending';
}
