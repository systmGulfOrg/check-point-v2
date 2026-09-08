import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';

class AdminAttendanceLegendItemWidget extends StatelessWidget {
  const AdminAttendanceLegendItemWidget({
    required this.color,
    required this.label,
    super.key,
  });

  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 7.r,
          height: 7.r,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        vSpace(3),
        Text(
          label,
          style: AppTextStyles.font12Regular.copyWith(
            color: AppColors.textSecondary,
            fontSize: 9.sp,
          ),
        ),
      ],
    );
  }
}
