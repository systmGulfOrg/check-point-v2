import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/admin/data/models/attendance/admin_attendance_model.dart';
import 'package:check_point_v2/features/admin/data/models/leave_requests/admin_leave_request_model.dart';
import 'package:check_point_v2/features/employee/presentation/widgets/employee_details_chart_widget.dart';
import 'package:check_point_v2/features/leaves/data/models/leave_balance_model.dart';
import 'package:check_point_v2/features/leaves/data/models/short_leave_model.dart';
import 'admin_employee_profile_info_card_widget.dart';
import 'admin_employee_profile_stat_badge_widget.dart';
import 'admin_employee_profile_stat_pill_widget.dart';

class AdminEmployeeProfileAttendanceTabWidget extends StatelessWidget {
  const AdminEmployeeProfileAttendanceTabWidget({
    required this.attendance,
    required this.selectedMonth,
    required this.attendedDays,
    required this.absentDays,
    required this.lateDays,
    required this.earlyLeaveDays,
    required this.totalHours,
    required this.leaveBalances,
    required this.leaveRequests,
    required this.permissions,
    required this.onMonthChanged,
    super.key,
  });

  final List<AdminAttendanceModel> attendance;
  final DateTime selectedMonth;
  final int attendedDays;
  final int absentDays;
  final int lateDays;
  final int earlyLeaveDays;
  final String totalHours;
  final List<LeaveBalanceModel> leaveBalances;
  final List<AdminLeaveRequestModel> leaveRequests;
  final List<ShortLeaveModel> permissions;
  final ValueChanged<DateTime> onMonthChanged;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: Column(
        children: [
          // 1. Leave Balances Section
          AdminEmployeeProfileInfoCardWidget(
            title: 'employee.profile.sectionBalances'.tr(context: context),
            icon: Icons.beach_access_rounded,
            children: [
              Row(
                children: leaveBalances.map((b) {
                  return Expanded(
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 4.w),
                      padding: EdgeInsets.symmetric(
                        vertical: 10.h,
                        horizontal: 8.w,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.softBrandBackground,
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(
                          color: AppColors.brandPrimary.withValues(alpha: 0.2),
                        ),
                      ),
                      child: Column(
                        children: [
                          Text(
                            b.leaveTypeName,
                            style: AppTextStyles.font11Medium.copyWith(
                              color: AppColors.textSecondary,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          hSpace(4),
                          Text(
                            '${b.remainingBalance}',
                            style: AppTextStyles.font20Bold.copyWith(
                              color: AppColors.brandPrimary,
                            ),
                          ),
                          hSpace(2),
                          Text(
                            '${'employee.profile.balanceRemaining'.tr(context: context)} (${b.usedBalance}/${b.totalAllocated})',
                            style: AppTextStyles.font11Regular.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),

          // 2. Pending Requests Summary
          AdminEmployeeProfileInfoCardWidget(
            title: 'employee.profile.sectionRequests'.tr(context: context),
            icon: Icons.pending_actions_rounded,
            children: [
              Row(
                children: [
                  Expanded(
                    child: AdminEmployeeProfileStatPillWidget(
                      label: 'employee.profile.leaveRequests'.tr(context: context),
                      value: '${leaveRequests.length}',
                      icon: Icons.flight_takeoff_rounded,
                      color: AppColors.brandPrimary,
                    ),
                  ),
                  wSpace(10),
                  Expanded(
                    child: AdminEmployeeProfileStatPillWidget(
                      label: 'employee.profile.permissionsCount'.tr(context: context),
                      value: '${permissions.length}',
                      icon: Icons.timer_outlined,
                      color: AppColors.brandSecondary,
                    ),
                  ),
                ],
              ),
            ],
          ),

          // 3. Monthly Attendance Stats & Chart
          AdminEmployeeProfileInfoCardWidget(
            title: 'employee.profile.sectionAttendance'.tr(context: context),
            icon: Icons.calendar_month_rounded,
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  visualDensity: VisualDensity.compact,
                  onPressed: () => onMonthChanged(
                    DateTime(selectedMonth.year, selectedMonth.month - 1),
                  ),
                  icon: const Icon(Icons.chevron_left_rounded),
                ),
                Text(
                  DateFormat('MMMM yyyy', context.locale.toString())
                      .format(selectedMonth),
                  style: AppTextStyles.font13SemiBold.copyWith(
                    color: AppColors.brandPrimary,
                  ),
                ),
                IconButton(
                  visualDensity: VisualDensity.compact,
                  onPressed: () => onMonthChanged(
                    DateTime(selectedMonth.year, selectedMonth.month + 1),
                  ),
                  icon: const Icon(Icons.chevron_right_rounded),
                ),
              ],
            ),
            children: [
              Row(
                children: [
                  Expanded(
                    child: AdminEmployeeProfileStatBadgeWidget(
                      label: 'employee.details.attended'.tr(context: context),
                      value: attendedDays.toString(),
                      color: AppColors.success,
                    ),
                  ),
                  wSpace(8),
                  Expanded(
                    child: AdminEmployeeProfileStatBadgeWidget(
                      label: 'employee.details.absent'.tr(context: context),
                      value: absentDays.toString(),
                      color: AppColors.error,
                    ),
                  ),
                  wSpace(8),
                  Expanded(
                    child: AdminEmployeeProfileStatBadgeWidget(
                      label: 'employee.details.late'.tr(context: context),
                      value: lateDays.toString(),
                      color: AppColors.warningOrange,
                    ),
                  ),
                ],
              ),
              hSpace(8),
              Row(
                children: [
                  Expanded(
                    child: AdminEmployeeProfileStatBadgeWidget(
                      label: 'employee.details.earlyLeave'.tr(context: context),
                      value: earlyLeaveDays.toString(),
                      color: AppColors.info,
                    ),
                  ),
                  wSpace(8),
                  Expanded(
                    child: AdminEmployeeProfileStatBadgeWidget(
                      label: 'employee.details.totalHours'.tr(context: context),
                      value: totalHours,
                      color: AppColors.brandPrimary,
                    ),
                  ),
                ],
              ),
              hSpace(16),
              EmployeeDetailsChartWidget(
                attendedDays: attendedDays,
                absentDays: absentDays,
                lateDays: lateDays,
                earlyLeaveDays: earlyLeaveDays,
              ),
            ],
          ),

          // 4. Daily Attendance Logs
          AdminEmployeeProfileInfoCardWidget(
            title: 'employee.profile.attendanceLogs'.tr(context: context),
            icon: Icons.history_toggle_off_rounded,
            children: [
              if (attendance.isEmpty)
                Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    child: Text(
                      'employee.details.noAttendance'.tr(context: context),
                      style: AppTextStyles.font13Regular.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),
                )
              else
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: attendance.length,
                  separatorBuilder: (_, _) =>
                      const Divider(height: 1, color: AppColors.border),
                  itemBuilder: (context, index) {
                    final item = attendance[index];
                    final dateStr = AppDateFormatter.formatDateString(
                      item.attendanceDate,
                    );
                    final checkIn = AppDateFormatter.formatTimeString(
                      item.clockInTime,
                    );
                    final checkOut = AppDateFormatter.formatTimeString(
                      item.clockOutTime,
                    );

                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.h),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(dateStr, style: AppTextStyles.font13Medium),
                                if (item.isLate == true) ...[
                                  hSpace(2),
                                  Text(
                                    'employee.details.late'.tr(context: context),
                                    style: AppTextStyles.font11Medium.copyWith(
                                      color: AppColors.error,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Text(
                              '$checkIn - $checkOut',
                              style: AppTextStyles.font12Regular.copyWith(
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ),
                          Text(
                            item.dayHours ?? '-',
                            style: AppTextStyles.font13Medium.copyWith(
                              color: AppColors.brandPrimary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
            ],
          ),
        ],
      ),
    );
  }
}
