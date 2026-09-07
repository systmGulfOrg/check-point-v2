import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/core.dart';
import '../widgets/employee_plan_data.dart';
import '../widgets/employee_plan_detail_card_widget.dart';

class EmployeePlansScreen extends StatelessWidget {
  const EmployeePlansScreen({super.key});

  static const _plans = <EmployeePlanData>[
    EmployeePlanData(
      id: '1',
      title: 'Emergency Response Drill',
      dateTime: '2026-09-15 09:00',
      planType: 'Mission',
      description: 'Annual emergency response training exercise.',
      status: 'planned',
      assignees: ['JM', 'PN', 'FA'],
    ),
    EmployeePlanData(
      id: '2',
      title: 'Al Futtaim Site Inspection',
      dateTime: '2026-09-10 10:00',
      planType: 'Customer Visit',
      locationName: 'Al Futtaim Group',
      description: 'Monthly review meeting with Al Futtaim...',
      status: 'planned',
      assignees: ['JM', 'SJ'],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'employee.plans.title'.tr(context: context),
                style: AppTextStyles.font24Bold,
              ),
              hSpace(14),
              Text(
                '${_plans.length} plans',
                style: AppTextStyles.font13Regular.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              hSpace(12),
              Expanded(
                child: ListView.separated(
                  itemCount: _plans.length,
                  separatorBuilder: (_, _) => hSpace(12),
                  itemBuilder: (context, index) {
                    return EmployeePlanDetailCardWidget(plan: _plans[index]);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
