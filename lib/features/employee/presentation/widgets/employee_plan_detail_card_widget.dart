import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/core.dart';
import 'employee_assignee_avatar_widget.dart';
import 'employee_plan_data.dart';

class EmployeePlanDetailCardWidget extends StatelessWidget {
  const EmployeePlanDetailCardWidget({
    required this.plan,
    super.key,
  });

  final EmployeePlanData plan;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.border),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
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
              wSpace(12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            plan.title,
                            style: AppTextStyles.font16Bold,
                          ),
                        ),
                        if (plan.planType != null) ...[
                          wSpace(8),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 10.w,
                              vertical: 4.h,
                            ),
                            decoration: BoxDecoration(
                              color: plan.planType == 'Mission'
                                  ? AppColors.softBlueBackground
                                  : AppColors.softGreenBackground,
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: Text(
                              plan.planType!,
                              style: AppTextStyles.font12Medium.copyWith(
                                color: plan.planType == 'Mission'
                                    ? AppColors.info
                                    : AppColors.success,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                    hSpace(4),
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_today_outlined,
                          size: 14.r,
                          color: AppColors.textSecondary,
                        ),
                        wSpace(4),
                        Expanded(
                          child: Text(
                            plan.locationName != null
                                ? '${plan.dateTime} · ${plan.locationName}'
                                : plan.dateTime,
                            style: AppTextStyles.font12Regular,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (plan.description != null) ...[
            hSpace(10),
            Text(
              plan.description!,
              style: AppTextStyles.font13Regular.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ],
          hSpace(14),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (plan.status != null)
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 4.h,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.softGreenBackground,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Text(
                    plan.status!,
                    style: AppTextStyles.font12Medium.copyWith(
                      color: AppColors.success,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              if (plan.assignees.isNotEmpty)
                EmployeeAssigneeAvatarWidget(assignees: plan.assignees),
            ],
          ),
        ],
      ),
    );
  }
}
