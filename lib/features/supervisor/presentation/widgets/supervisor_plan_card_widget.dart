import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/core.dart';
import 'supervisor_plan_data.dart';

class SupervisorPlanCardWidget extends StatelessWidget {
  const SupervisorPlanCardWidget({required this.plan, super.key});

  final SupervisorPlanData plan;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14.r),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 19.r,
            backgroundColor: plan.iconBackgroundColor,
            child: Icon(Icons.map_outlined, color: plan.iconColor, size: 20.r),
          ),
          vSpace(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        plan.titleKey.tr(context: context),
                        style: AppTextStyles.font14SemiBold,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 3.h,
                      ),
                      decoration: BoxDecoration(
                        color: plan.iconBackgroundColor,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Text(
                        plan.typeKey.tr(context: context),
                        style: AppTextStyles.font11Medium.copyWith(
                          color: plan.iconColor,
                        ),
                      ),
                    ),
                  ],
                ),
                hSpace(6),
                Text(
                  plan.dateTime,
                  style: AppTextStyles.font12Regular.copyWith(
                    color: AppColors.placeholder,
                  ),
                ),
                hSpace(4),
                Text(
                  plan.descriptionKey.tr(context: context),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.font12Regular,
                ),
                hSpace(8),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 9.w,
                        vertical: 4.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.softGreenBackground,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Text(
                        'supervisor.plans.status.planned'.tr(context: context),
                        style: AppTextStyles.font12Bold.copyWith(
                          color: AppColors.success,
                        ),
                      ),
                    ),
                    vSpace(8),
                    for (final initials in plan.assigneeInitials)
                      Padding(
                        padding: EdgeInsetsDirectional.only(start: 2.w),
                        child: CircleAvatar(
                          radius: 10.r,
                          backgroundColor: AppColors.softGreenBackground,
                          child: Text(
                            initials,
                            style: AppTextStyles.font11Medium.copyWith(
                              color: AppColors.success,
                              fontSize: 8.sp,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
