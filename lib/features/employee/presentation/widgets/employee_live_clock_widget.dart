import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:check_point_v2/core/core.dart';

/// Current time and date, refreshed every 15 seconds.
class EmployeeLiveClockWidget extends StatefulWidget {
  const EmployeeLiveClockWidget({super.key});

  @override
  State<EmployeeLiveClockWidget> createState() =>
      _EmployeeLiveClockWidgetState();
}

class _EmployeeLiveClockWidgetState extends State<EmployeeLiveClockWidget> {
  late DateTime now;
  late final Timer timer;

  @override
  void initState() {
    super.initState();
    now = DateTime.now();
    timer = Timer.periodic(const Duration(seconds: 15), (_) {
      if (mounted) setState(() => now = DateTime.now());
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final languageCode = context.locale.languageCode;
    return Column(
      children: [
        Text(
          AppDateFormatter.formatTime(now, isArabic: languageCode == 'ar'),
          style: AppTextStyles.font28Bold,
        ),
        Text(
          AppDateFormatter.formatLongDate(now, languageCode),
          style: AppTextStyles.font12Regular.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}
