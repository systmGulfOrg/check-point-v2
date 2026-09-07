import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/core.dart';
import 'employee_plan_data.dart';

class EmployeePlanCardWidget extends StatelessWidget {
  const EmployeePlanCardWidget({required this.plan, super.key});

  final EmployeePlanData plan;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10.r),
            decoration: BoxDecoration(
              color: AppColors.softBrandBackground,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(
              Icons.map_outlined,
              color: AppColors.brandPrimary,
              size: 20.r,
            ),
          ),
          wSpace(14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(plan.title, style: AppTextStyles.font14SemiBold),
                hSpace(4),
                Text(plan.dateTime, style: AppTextStyles.font12Regular),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
