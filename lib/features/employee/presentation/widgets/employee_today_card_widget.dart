import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'employee_live_clock_widget.dart';
import 'employee_today_action_widget.dart';
import 'employee_today_status_row_widget.dart';
import 'employee_today_times_row_widget.dart';

/// The home screen's main card: today's status, the clock, the one attendance
/// action, and today's check-in, check-out and worked hours.
class EmployeeTodayCardWidget extends StatelessWidget {
  const EmployeeTodayCardWidget({
    required this.policyText,
    required this.isOnTime,
    required this.checkInTime,
    required this.checkOutTime,
    required this.isCheckedIn,
    required this.hasCheckedOut,
    required this.workedHours,
    required this.workModeText,
    required this.onToggleCheckInOut,
    this.isTodayHoliday = false,
    this.isTodayWeeklyOff = false,
    this.holidayGreeting,
    this.holidayName,
    super.key,
  });

  final String policyText;
  final bool isOnTime;
  final String checkInTime;
  final String checkOutTime;
  final bool isCheckedIn;
  final bool hasCheckedOut;
  final String? workedHours;
  final String workModeText;
  final VoidCallback onToggleCheckInOut;
  final bool isTodayHoliday;
  final bool isTodayWeeklyOff;
  final String? holidayGreeting;
  final String? holidayName;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: AppColors.orangeBorder),
      ),
      child: Column(
        children: [
          EmployeeTodayStatusRowWidget(
            isCheckedIn: isCheckedIn,
            hasCheckedOut: hasCheckedOut,
            isOnTime: isOnTime,
            workModeText: workModeText,
          ),
          hSpace(16),
          const EmployeeLiveClockWidget(),
          hSpace(4),
          Text(
            policyText,
            textAlign: TextAlign.center,
            style: AppTextStyles.font12Regular.copyWith(
              color: AppColors.brandPrimaryDark,
            ),
          ),
          hSpace(16),
          EmployeeTodayActionWidget(
            isCheckedIn: isCheckedIn,
            hasCheckedOut: hasCheckedOut,
            isTodayHoliday: isTodayHoliday,
            isTodayWeeklyOff: isTodayWeeklyOff,
            onToggleCheckInOut: onToggleCheckInOut,
            holidayGreeting: holidayGreeting,
            holidayName: holidayName,
          ),
          hSpace(16),
          EmployeeTodayTimesRowWidget(
            checkInTime: checkInTime,
            checkOutTime: checkOutTime,
            workedHours: workedHours,
          ),
        ],
      ),
    );
  }
}
