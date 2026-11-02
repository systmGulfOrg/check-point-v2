import 'package:flutter/material.dart';

import 'package:check_point_v2/core/core.dart';

class EmployeeTodayTimeCellWidget extends StatelessWidget {
  const EmployeeTodayTimeCellWidget({
    required this.label,
    required this.value,
    super.key,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text(
            label,
            style: AppTextStyles.font11Medium.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          hSpace(2),
          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.font14Bold,
          ),
        ],
      ),
    );
  }
}
