import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';

class EmployeeClockGaugeWidget extends StatelessWidget {
  const EmployeeClockGaugeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80.r,
      height: 80.r,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: AppColors.brandPrimary.withValues(alpha: 0.5),
          width: 3,
        ),
        color: AppColors.softBrandBackground,
      ),
      child: Center(
        child: Icon(
          Icons.access_time_rounded,
          color: AppColors.brandPrimary,
          size: 36.r,
        ),
      ),
    );
  }
}
