import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/core.dart';
import 'employee_plan_card_widget.dart';
import 'employee_plan_data.dart';

class EmployeePlansSectionWidget extends StatelessWidget {
  const EmployeePlansSectionWidget({
    required this.plans,
    required this.onViewAllTap,
    super.key,
  });

  final List<EmployeePlanData> plans;
  final VoidCallback onViewAllTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'employee.home.upcomingPlansTitle'.tr(context: context),
              style: AppTextStyles.font18Bold,
            ),
            GestureDetector(
              onTap: onViewAllTap,
              child: Text(
                'employee.home.viewAll'.tr(context: context),
                style: AppTextStyles.font13SemiBold.copyWith(
                  color: AppColors.brandPrimary,
                ),
              ),
            ),
          ],
        ),
        hSpace(12),
        Container(
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
            children: [
              for (int i = 0; i < plans.length; i++) ...[
                EmployeePlanCardWidget(plan: plans[i]),
                if (i < plans.length - 1)
                  const Divider(
                    height: 1,
                    thickness: 1,
                    color: AppColors.border,
                  ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
