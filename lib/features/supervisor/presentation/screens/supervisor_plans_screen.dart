import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/supervisor/presentation/cubit/plans/supervisor_plans_cubit.dart';
import 'package:check_point_v2/features/supervisor/presentation/widgets/supervisor_new_plan_button_widget.dart';
import 'package:check_point_v2/features/supervisor/presentation/widgets/supervisor_plans_bloc_builder_widget.dart';

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
        actions: [
          IconButton(
            onPressed: () => Navigator.pushNamed(context, AppRoutes.projects),
            icon: const Icon(Icons.view_kanban_outlined),
          ),
        ],
      ),
      body: SafeArea(
        child: RefreshIndicator(
          color: AppColors.brandPrimary,
          onRefresh: context.read<SupervisorPlansCubit>().loadPlans,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
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
      ),
    );
  }
}
