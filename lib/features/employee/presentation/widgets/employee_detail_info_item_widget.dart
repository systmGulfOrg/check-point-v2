import 'package:flutter/material.dart';

import 'package:check_point_v2/core/core.dart';

class EmployeeDetailInfoItemWidget extends StatelessWidget {
  const EmployeeDetailInfoItemWidget({
    required this.label,
    required this.value,
    super.key,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
          style: AppTextStyles.font13SemiBold.copyWith(
            color: AppColors.textPrimary,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
