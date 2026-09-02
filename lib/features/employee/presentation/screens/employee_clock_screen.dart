import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/core.dart';
import '../widgets/employee_attendance_record_card_widget.dart';
import '../widgets/employee_attendance_record_data.dart';
import '../widgets/employee_clock_card_widget.dart';

class EmployeeClockScreen extends StatefulWidget {
  const EmployeeClockScreen({super.key});

  @override
  State<EmployeeClockScreen> createState() => _EmployeeClockScreenState();
}

class _EmployeeClockScreenState extends State<EmployeeClockScreen> {
  bool _isCheckedIn = false;
  bool _hasCheckedOut = true;
  String _checkInTime = '08:02';
  String _checkOutTime = '16:06';
  String? _workedHours = '8.07h worked';

  static const _recentAttendance = <EmployeeAttendanceRecordData>[
    EmployeeAttendanceRecordData(
      date: '2026-09-01',
      checkIn: 'In 08:02 · Out 16:06 · 8.07h',
      status: 'On Time',
    ),
    EmployeeAttendanceRecordData(
      date: '2026-08-31',
      checkIn: 'In 08:00 · Out 16:05 · 8.08h',
      status: 'On Time',
    ),
    EmployeeAttendanceRecordData(
      date: '2026-08-30',
      checkIn: 'In 08:05 · Out 16:03 · 7.97h',
      status: 'On Time',
    ),
  ];

  void _toggleCheckInOut() {
    setState(() {
      if (_isCheckedIn) {
        _isCheckedIn = false;
        _hasCheckedOut = true;
        _checkOutTime = '16:06';
        _workedHours = '8.07h worked';
      } else {
        _isCheckedIn = true;
        _hasCheckedOut = false;
        _checkInTime = '08:02';
        _checkOutTime = '—';
        _workedHours = null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'employee.clock.title'.tr(context: context),
                style: AppTextStyles.font24Bold,
              ),
              hSpace(20),
              EmployeeClockCardWidget(
                policyText: 'Policy B — 08:00–16:00 · 08:00 – 16:00',
                checkInTime: _checkInTime,
                checkOutTime: _checkOutTime,
                isCheckedIn: _isCheckedIn,
                hasCheckedOut: _hasCheckedOut,
                workedHours: _workedHours,
                onToggleCheckInOut: _toggleCheckInOut,
              ),
              hSpace(20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'employee.clock.recentAttendance'.tr(context: context),
                    style: AppTextStyles.font18Bold,
                  ),
                  hSpace(12),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.cardBackground,
                      borderRadius: BorderRadius.circular(16.r),
                      border: Border.all(color: AppColors.border),
                      boxShadow: const [
                        BoxShadow(
                          color: AppColors.shadow,
                          blurRadius: 8,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        for (int i = 0; i < _recentAttendance.length; i++) ...[
                          EmployeeAttendanceRecordCardWidget(
                            record: _recentAttendance[i],
                          ),
                          if (i < _recentAttendance.length - 1)
                            const Divider(
                              height: 1,
                              thickness: 1,
                              color: AppColors.border,
                            ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
