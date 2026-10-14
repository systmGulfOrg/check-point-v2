import 'package:flutter/material.dart';

import 'package:check_point_v2/core/core.dart';

/// One value/label pair inside [LeaveBalanceCardWidget]'s stats row.
class LeaveBalanceStatColumnWidget extends StatelessWidget {
  const LeaveBalanceStatColumnWidget({
    required this.label,
    required this.value,
    required this.color,
    super.key,
  });

  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) => Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(value, style: AppTextStyles.font18Bold.copyWith(color: color)),
      hSpace(2),
      Text(
        label,
        style: AppTextStyles.font11Regular.copyWith(
          color: AppColors.textSecondary,
        ),
      ),
    ],
  );
}
