import 'package:flutter/material.dart';
import 'package:check_point_v2/core/core.dart';

class DisciplinaryViolationStatusBadgeWidget extends StatelessWidget {
  const DisciplinaryViolationStatusBadgeWidget({
    super.key,
    required this.status,
  });

  final String status;

  @override
  Widget build(BuildContext context) {
    final (label, color, bg) = switch (status) {
      'APPROVED' => ('معتمد', AppColors.success, AppColors.softGreenBackground),
      'DEDUCTED_IN_PAYROLL' => (
        'مخصوم بالراتب',
        AppColors.brandInk,
        AppColors.softBrandBackground,
      ),
      'WAIVED' => ('معفى إدارياً', AppColors.textSecondary, AppColors.border),
      'CANCELLED_BY_APPEAL' => (
        'ملغي بتظلم',
        AppColors.info,
        AppColors.softBlueBackground,
      ),
      _ => ('قيد الاعتماد', AppColors.warning, AppColors.softYellowBackground),
    };

    return AppStatusPillWidget(
      label: label,
      color: color,
      backgroundColor: bg,
    );
  }
}
