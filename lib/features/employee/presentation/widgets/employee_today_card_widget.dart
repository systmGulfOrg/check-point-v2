import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'employee_status_badge_widget.dart';

class EmployeeTodayCardWidget extends StatelessWidget {
  const EmployeeTodayCardWidget({
    required this.policyText,
    required this.isOnTime,
    required this.checkInTime,
    required this.checkOutTime,
    required this.isCheckedIn,
    required this.hasCheckedOut,
    required this.workedHours,
    required this.leaveBalance,
    required this.workModeText,
    required this.workSystemText,
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
  final int? leaveBalance;
  final String workModeText;
  final String workSystemText;
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
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.border),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 10,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'employee.home.today'.tr(context: context),
                      style: AppTextStyles.font11Medium.copyWith(
                        color: AppColors.textSecondary,
                        letterSpacing: 1.0,
                      ),
                    ),
                    hSpace(4),
                    Text(
                      policyText,
                      style: AppTextStyles.font13SemiBold.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),
              if (isOnTime && isCheckedIn)
                const EmployeeStatusBadgeWidget(status: 'On Time'),
            ],
          ),
          hSpace(16),
          Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 7.h),
                decoration: BoxDecoration(
                  color: AppColors.softBlueBackground,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.home_work_outlined,
                      size: 16.r,
                      color: AppColors.info,
                    ),
                    wSpace(5),
                    Text(
                      '$workSystemText • $workModeText',
                      style: AppTextStyles.font11Medium.copyWith(
                        color: AppColors.info,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 7.h),
                decoration: BoxDecoration(
                  color: AppColors.softGreenBackground,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.beach_access_outlined,
                      size: 16.r,
                      color: AppColors.success,
                    ),
                    wSpace(5),
                    Text(
                      '${leaveBalance ?? '--'} ${'employee.home.leaveBalance'.tr(context: context)}',
                      style: AppTextStyles.font11Medium.copyWith(
                        color: AppColors.success,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          hSpace(16),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 12.h,
                    horizontal: 12.w,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.softGreenBackground,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: AppColors.success.withValues(alpha: 0.3),
                      width: 1.2,
                    ),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'employee.home.checkInLabel'.tr(context: context),
                        style: AppTextStyles.font12Regular.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                      hSpace(4),
                      Text(
                        checkInTime,
                        style: AppTextStyles.font18Bold.copyWith(
                          color: AppColors.success,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              wSpace(12),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 12.h,
                    horizontal: 12.w,
                  ),
                  decoration: BoxDecoration(
                    color: hasCheckedOut
                        ? AppColors.softBlueBackground
                        : AppColors.pageBackground,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: hasCheckedOut
                          ? AppColors.info.withValues(alpha: 0.3)
                          : AppColors.border,
                      width: hasCheckedOut ? 1.2 : 1.0,
                    ),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'employee.home.checkOutLabel'.tr(context: context),
                        style: AppTextStyles.font12Regular.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                      hSpace(4),
                      Text(
                        checkOutTime,
                        style: AppTextStyles.font18Bold.copyWith(
                          color: hasCheckedOut
                              ? AppColors.info
                              : AppColors.placeholder,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          hSpace(16),
          if (isTodayHoliday)
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 16.w),
              decoration: BoxDecoration(
                color: AppColors.softGreenBackground,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(
                  color: AppColors.success.withValues(alpha: 0.35),
                  width: 1.2,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.celebration_rounded,
                    color: AppColors.success,
                    size: 22.r,
                  ),
                  wSpace(8),
                  Expanded(
                    child: Text(
                      holidayGreeting ??
                          '${'holidays.todayHolidayTitle'.tr(context: context)}: ${holidayName ?? ''} - ${'holidays.todayHolidayGreeting'.tr(context: context)}',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.font13SemiBold.copyWith(
                        color: AppColors.success,
                      ),
                    ),
                  ),
                ],
              ),
            )
          else if (isTodayWeeklyOff)
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 16.w),
              decoration: BoxDecoration(
                color: AppColors.softBlueBackground,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(
                  color: AppColors.info.withValues(alpha: 0.35),
                  width: 1.2,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.weekend_rounded,
                    color: AppColors.info,
                    size: 22.r,
                  ),
                  wSpace(8),
                  Expanded(
                    child: Text(
                      'employee.home.todayWeeklyOffGreeting'.tr(
                        context: context,
                      ),
                      textAlign: TextAlign.center,
                      style: AppTextStyles.font13SemiBold.copyWith(
                        color: AppColors.info,
                      ),
                    ),
                  ),
                ],
              ),
            )
          else if (hasCheckedOut && !isCheckedIn)
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (isOnTime)
                      const EmployeeStatusBadgeWidget(status: 'On Time'),
                    if (isOnTime && workedHours != null) wSpace(12),
                    if (workedHours != null)
                      Text(
                        workedHours!,
                        style: AppTextStyles.font13Regular.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                  ],
                ),
                hSpace(12),
                CustomButton(
                  key: const ValueKey<String>('today_customer_checkin_btn'),
                  text: 'employee.home.checkInCustomerAction'.tr(
                    context: context,
                  ),
                  icon: Icons.person_pin_circle_outlined,
                  backgroundColor: AppColors.softBrandBackground,
                  textColor: AppColors.brandPrimary,
                  onTap: onToggleCheckInOut,
                ),
              ],
            )
          else
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (child, animation) => FadeTransition(
                opacity: animation,
                child: SizeTransition(
                  sizeFactor: animation,
                  axisAlignment: 0.0,
                  child: child,
                ),
              ),
              child: CustomButton(
                key: ValueKey<bool>(isCheckedIn),
                text: isCheckedIn
                    ? 'employee.home.checkOutAction'.tr(context: context)
                    : 'employee.home.checkInAction'.tr(context: context),
                backgroundColor: isCheckedIn
                    ? AppColors.error
                    : AppColors.brandPrimary,
                onTap: onToggleCheckInOut,
              ),
            ),
        ],
      ),
    );
  }
}
