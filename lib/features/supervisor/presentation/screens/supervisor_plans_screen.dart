import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/core.dart';
import '../widgets/supervisor_new_plan_button_widget.dart';
import '../widgets/supervisor_plans_bloc_builder_widget.dart';

class SupervisorPlansScreen extends StatelessWidget {
  const SupervisorPlansScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        title: Text(
          'supervisor.plans.title'.tr(context: context),
          style: AppTextStyles.font18Bold,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(16.w, 4.h, 16.w, 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'supervisor.plans.allPlans'.tr(context: context),
                    style: AppTextStyles.font14SemiBold,
                  ),
                  const SupervisorNewPlanButtonWidget(),
                ],
              ),
              hSpace(14),
              const SupervisorPlansBlocBuilderWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
