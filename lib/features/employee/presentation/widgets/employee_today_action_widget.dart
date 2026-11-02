import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:check_point_v2/core/core.dart';
import 'employee_today_day_off_banner_widget.dart';

/// The one action for today: check in, check out, check in at a customer
/// after the day is closed, or a day-off message instead of a button.
class EmployeeTodayActionWidget extends StatelessWidget {
  const EmployeeTodayActionWidget({
    required this.isCheckedIn,
    required this.hasCheckedOut,
    required this.isTodayHoliday,
    required this.isTodayWeeklyOff,
    required this.onToggleCheckInOut,
    this.holidayGreeting,
    this.holidayName,
    super.key,
  });

  final bool isCheckedIn;
  final bool hasCheckedOut;
  final bool isTodayHoliday;
  final bool isTodayWeeklyOff;
  final VoidCallback onToggleCheckInOut;
  final String? holidayGreeting;
  final String? holidayName;

  @override
  Widget build(BuildContext context) {
    if (isTodayHoliday) {
      return EmployeeTodayDayOffBannerWidget(
        message:
            holidayGreeting ??
            '${'holidays.todayHolidayTitle'.tr(context: context)}: ${holidayName ?? ''} - ${'holidays.todayHolidayGreeting'.tr(context: context)}',
        icon: Icons.celebration_rounded,
        color: AppColors.success,
        backgroundColor: AppColors.softGreenBackground,
      );
    }
    if (isTodayWeeklyOff) {
      return EmployeeTodayDayOffBannerWidget(
        message: 'employee.home.todayWeeklyOffGreeting'.tr(context: context),
        icon: Icons.weekend_rounded,
        color: AppColors.info,
        backgroundColor: AppColors.softBlueBackground,
      );
    }
    if (hasCheckedOut && !isCheckedIn) {
      return CustomButton(
        key: const ValueKey<String>('today_customer_checkin_btn'),
        text: 'employee.home.checkInCustomerAction'.tr(context: context),
        icon: Icons.person_pin_circle_outlined,
        backgroundColor: AppColors.softBrandBackground,
        textColor: AppColors.brandPrimary,
        onTap: onToggleCheckInOut,
      );
    }
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 250),
      child: CustomButton(
        key: ValueKey<bool>(isCheckedIn),
        text: isCheckedIn
            ? 'employee.home.checkOutAction'.tr(context: context)
            : 'employee.home.checkInAction'.tr(context: context),
        icon: isCheckedIn ? Icons.logout_rounded : Icons.fingerprint_rounded,
        backgroundColor: isCheckedIn ? AppColors.error : AppColors.brandPrimary,
        onTap: onToggleCheckInOut,
      ),
    );
  }
}
