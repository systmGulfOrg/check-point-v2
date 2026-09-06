import 'package:flutter/material.dart';

class AdminAttendanceRecordData {
  const AdminAttendanceRecordData({
    required this.initials,
    required this.name,
    required this.date,
    required this.checkIn,
    required this.checkOut,
    required this.area,
    required this.totalHours,
    required this.statusKey,
    required this.statusColor,
    required this.statusBackgroundColor,
  });

  final String initials;
  final String name;
  final String date;
  final String checkIn;
  final String checkOut;
  final String area;
  final String totalHours;
  final String statusKey;
  final Color statusColor;
  final Color statusBackgroundColor;
}

