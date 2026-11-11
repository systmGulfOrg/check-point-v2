import 'package:flutter/material.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/employee_record/data/models/employee_record_model.dart';

/// Label key and colors for one record day. Display mapping only; the
/// server decides the day type and status.
class RecordDayStatusStyle {
  const RecordDayStatusStyle({
    required this.labelKey,
    required this.color,
    required this.background,
    required this.icon,
  });

  final String labelKey;
  final Color color;
  final Color background;
  final IconData icon;

  factory RecordDayStatusStyle.of(RecordDayModel day) {
    switch (day.dayType) {
      case 'leave':
        return const RecordDayStatusStyle(
          labelKey: 'record.status.leave',
          color: AppColors.info,
          background: AppColors.softBlueBackground,
          icon: Icons.beach_access_rounded,
        );
      case 'holiday':
        return const RecordDayStatusStyle(
          labelKey: 'record.status.holiday',
          color: AppColors.purpleText,
          background: AppColors.softPurpleBackground,
          icon: Icons.celebration_rounded,
        );
      case 'weeklyOff':
        if (day.clockIn == null) {
          return const RecordDayStatusStyle(
            labelKey: 'record.status.weeklyOff',
            color: AppColors.textSecondary,
            background: AppColors.pageBackground,
            icon: Icons.weekend_rounded,
          );
        }
    }
    return switch (day.status) {
      'late' || 'lateAndEarly' => const RecordDayStatusStyle(
        labelKey: 'record.status.late',
        color: AppColors.error,
        background: AppColors.softRedBackground,
        icon: Icons.schedule_rounded,
      ),
      'earlyLeave' => const RecordDayStatusStyle(
        labelKey: 'record.status.earlyLeave',
        color: AppColors.error,
        background: AppColors.softRedBackground,
        icon: Icons.logout_rounded,
      ),
      'lateCovered' => const RecordDayStatusStyle(
        labelKey: 'record.status.lateCovered',
        color: AppColors.success,
        background: AppColors.softGreenBackground,
        icon: Icons.verified_rounded,
      ),
      'earlyCovered' => const RecordDayStatusStyle(
        labelKey: 'record.status.earlyCovered',
        color: AppColors.success,
        background: AppColors.softGreenBackground,
        icon: Icons.verified_rounded,
      ),
      'present' => const RecordDayStatusStyle(
        labelKey: 'record.status.present',
        color: AppColors.success,
        background: AppColors.softGreenBackground,
        icon: Icons.check_circle_rounded,
      ),
      'absent' => const RecordDayStatusStyle(
        labelKey: 'record.status.absent',
        color: AppColors.error,
        background: AppColors.softRedBackground,
        icon: Icons.cancel_rounded,
      ),
      _ => const RecordDayStatusStyle(
        labelKey: 'record.status.upcoming',
        color: AppColors.textSecondary,
        background: AppColors.pageBackground,
        icon: Icons.event_rounded,
      ),
    };
  }
}
