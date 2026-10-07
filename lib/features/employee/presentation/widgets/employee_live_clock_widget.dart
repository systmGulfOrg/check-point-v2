import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';

class EmployeeLiveClockWidget extends StatefulWidget {
  const EmployeeLiveClockWidget({super.key});

  @override
  State<EmployeeLiveClockWidget> createState() =>
      _EmployeeLiveClockWidgetState();
}

class _EmployeeLiveClockWidgetState extends State<EmployeeLiveClockWidget> {
  late DateTime currentDateTime;
  Timer? clockTimer;

  @override
  void initState() {
    super.initState();
    currentDateTime = DateTime.now();
    clockTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) {
        setState(() => currentDateTime = DateTime.now());
      }
    });
  }

  @override
  void dispose() {
    clockTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isArabic = context.locale.languageCode == 'ar';
    final currentTime = AppDateFormatter.formatTime(
      currentDateTime,
      isArabic: isArabic,
    );
    final currentDate = AppDateFormatter.formatYearMonthDay(currentDateTime);

    return Column(
      children: [
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 250),
          transitionBuilder: (child, animation) => FadeTransition(
            opacity: animation,
            child: ScaleTransition(scale: animation, child: child),
          ),
          child: Text(
            currentTime,
            key: ValueKey<String>(currentTime),
            style: AppTextStyles.font24Bold.copyWith(
              fontSize: 28.sp,
              letterSpacing: 0.8,
            ),
          ),
        ),
        hSpace(4),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: Text(
            currentDate,
            key: ValueKey<String>(currentDate),
            style: AppTextStyles.font13Regular.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ),
      ],
    );
  }
}
