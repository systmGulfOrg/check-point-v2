import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';

class SupervisorAttendanceDateBarWidget extends StatelessWidget {
  const SupervisorAttendanceDateBarWidget({
    required this.selectedDate,
    required this.onDateChanged,
    this.onAddPressed,
    super.key,
  });

  final DateTime selectedDate;
  final ValueChanged<DateTime> onDateChanged;
  final VoidCallback? onAddPressed;

  bool get _isToday {
    final now = DateTime.now();
    return selectedDate.year == now.year &&
        selectedDate.month == now.month &&
        selectedDate.day == now.day;
  }

  Future<void> _pickDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      initialDate: selectedDate,
      builder: (pickerContext, child) {
        return Theme(
          data: Theme.of(pickerContext).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.brandPrimary,
              onPrimary: AppColors.white,
              onSurface: AppColors.textPrimary,
            ),
          ),
          child: child ?? const SizedBox.shrink(),
        );
      },
    );
    if (picked != null) {
      onDateChanged(picked);
    }
  }

  void _goToPreviousDay() {
    onDateChanged(selectedDate.subtract(const Duration(days: 1)));
  }

  void _goToNextDay() {
    onDateChanged(selectedDate.add(const Duration(days: 1)));
  }

  void _goToToday() {
    onDateChanged(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    final formattedFull = AppDateFormatter.formatMediumDate(selectedDate);
    final formattedDayOfWeek = AppDateFormatter.formatDate(
      selectedDate,
      pattern: 'EEEE',
    );
    final isoDate = AppDateFormatter.formatYearMonthDay(selectedDate);

    return Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.cardBackground,
              borderRadius: BorderRadius.circular(14.r),
              border: Border.all(color: AppColors.border),
              boxShadow: const [
                BoxShadow(
                  color: AppColors.shadow,
                  blurRadius: 8,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () => _pickDate(context),
                borderRadius: BorderRadius.circular(14.r),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 8.h,
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(8.r),
                        decoration: BoxDecoration(
                          color: AppColors.softBrandBackground,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.calendar_month_rounded,
                          size: 18.r,
                          color: AppColors.brandPrimary,
                        ),
                      ),
                      wSpace(10),
                      Expanded(
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 250),
                          transitionBuilder: (child, animation) =>
                              FadeTransition(
                                opacity: animation,
                                child: SlideTransition(
                                  position: Tween<Offset>(
                                    begin: const Offset(0.0, 0.2),
                                    end: Offset.zero,
                                  ).animate(animation),
                                  child: child,
                                ),
                              ),
                          child: Column(
                            key: ValueKey<String>(isoDate),
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    formattedFull,
                                    style: AppTextStyles.font14SemiBold
                                        .copyWith(color: AppColors.textPrimary),
                                  ),
                                  if (_isToday) ...[
                                    wSpace(6),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 6.w,
                                        vertical: 2.h,
                                      ),
                                      decoration: BoxDecoration(
                                        color: AppColors.softGreenBackground,
                                        borderRadius: BorderRadius.circular(
                                          6.r,
                                        ),
                                      ),
                                      child: Text(
                                        'supervisor.attendance.today'.tr(
                                          context: context,
                                        ),
                                        style: AppTextStyles.font10Bold
                                            .copyWith(color: AppColors.success),
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                              hSpace(2),
                              Text(
                                formattedDayOfWeek,
                                style: AppTextStyles.font11Medium.copyWith(
                                  color: AppColors.placeholder,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      if (!_isToday)
                        IconButton(
                          tooltip: 'Today',
                          visualDensity: VisualDensity.compact,
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          icon: Icon(
                            Icons.today_rounded,
                            size: 18.r,
                            color: AppColors.brandPrimary,
                          ),
                          onPressed: _goToToday,
                        ),
                      wSpace(4),
                      IconButton(
                        visualDensity: VisualDensity.compact,
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        icon: Icon(
                          Icons.chevron_left_rounded,
                          size: 20.r,
                          color: AppColors.textSecondary,
                        ),
                        onPressed: _goToPreviousDay,
                      ),
                      IconButton(
                        visualDensity: VisualDensity.compact,
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        icon: Icon(
                          Icons.chevron_right_rounded,
                          size: 20.r,
                          color: AppColors.textSecondary,
                        ),
                        onPressed: _goToNextDay,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        if (onAddPressed != null) ...[
          wSpace(10),
          Container(
            decoration: BoxDecoration(
              color: AppColors.brandPrimary,
              borderRadius: BorderRadius.circular(14.r),
              boxShadow: [
                BoxShadow(
                  color: AppColors.brandPrimary.withValues(alpha: 0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: onAddPressed,
                borderRadius: BorderRadius.circular(14.r),
                child: Padding(
                  padding: EdgeInsets.all(12.r),
                  child: Icon(Icons.add, color: AppColors.white, size: 20.r),
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }
}
