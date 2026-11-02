import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';

import 'package:check_point_v2/core/styles/app_colors.dart';

/// Display name for a leave type as the API sends it (English, Arabic or a
/// translation key).
String leaveTypeDisplayName(String? name) {
  if (name == null || name.isEmpty) return 'leaves.request.title'.tr();
  if (name.startsWith('leaves.dashboard.')) return name.tr();
  final lower = name.toLowerCase().trim();
  if (lower == 'annual leave' ||
      lower == 'annual' ||
      lower == 'إجازة اعتيادية / سنوية') {
    return 'leaves.dashboard.annualLeave'.tr();
  }
  if (lower == 'sick leave' || lower == 'sick' || lower == 'إجازة مرضية') {
    return 'leaves.dashboard.sickLeave'.tr();
  }
  if (lower == 'casual leave' || lower == 'casual' || lower == 'إجازة عارضة') {
    return 'leaves.dashboard.casualLeave'.tr();
  }
  return name;
}

/// Translation key, text color and background for a leave request status.
(String, Color, Color) leaveStatusStyle(String status) =>
    switch (status.toLowerCase()) {
      'pendinghr' => (
        'leaves.status.pendingHR',
        AppColors.warningOrange,
        AppColors.softYellowBackground,
      ),
      'approved' || 'approvedbyhr' || 'approvedbymanager' => (
        'leaves.status.approved',
        AppColors.success,
        AppColors.softGreenBackground,
      ),
      'rejected' || 'rejectedbymanager' || 'rejectedbyhr' => (
        'leaves.status.rejected',
        AppColors.error,
        AppColors.softRedBackground,
      ),
      'cancelled' => (
        'leaves.status.cancelled',
        AppColors.placeholder,
        AppColors.border,
      ),
      _ => (
        'leaves.status.pending',
        AppColors.warningOrange,
        AppColors.softYellowBackground,
      ),
    };
