import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/core/di/service_locator.dart';
import 'package:check_point_v2/features/supervisor/presentation/widgets/supervisor_create_plan_sheet_widget.dart';
import 'package:check_point_v2/features/supervisor/presentation/cubit/plans/supervisor_plans_cubit.dart';
import 'package:check_point_v2/features/supervisor/presentation/cubit/team/supervisor_team_cubit.dart';
import 'package:check_point_v2/features/admin/data/models/plans/admin_plan_model.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/plans/admin_plans_cubit.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/plans/admin_plans_state.dart';
import 'package:check_point_v2/features/admin/presentation/widgets/admin_plans_skeleton_widget.dart';

class AdminPlansScreen extends StatelessWidget {
  const AdminPlansScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        title: Text(
          'admin.plans.title'.tr(context: context),
          style: AppTextStyles.font18Bold,
        ),
      ),
      body: SafeArea(
        child: RefreshIndicator(
          color: AppColors.brandPrimary,
          onRefresh: context.read<AdminPlansCubit>().loadPlans,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.fromLTRB(16.w, 4.h, 16.w, 24.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BlocListener<AdminPlansCubit, AdminPlansState>(
                  listener: (context, state) {
                    state.maybeWhen(
                      error: (messageKey) {
                        final cubit = context.read<AdminPlansCubit>();
                        if (cubit.allPlans.isNotEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(messageKey.tr(context: context)),
                              backgroundColor: AppColors.error,
                            ),
                          );
                        }
                      },
                      orElse: () {},
                    );
                  },
                  child: BlocBuilder<AdminPlansCubit, AdminPlansState>(
                    builder: (context, state) {
                      final cubit = context.read<AdminPlansCubit>();
                      return state.when(
                        initial: () => const SizedBox.shrink(),
                        loading: () => cubit.allPlans.isNotEmpty
                            ? _buildPlansView(context, cubit.allPlans)
                            : const AdminPlansSkeletonWidget(),
                        error: (messageKey) {
                          if (cubit.allPlans.isNotEmpty) {
                            return _buildPlansView(context, cubit.allPlans);
                          }
                          return Padding(
                            padding: EdgeInsets.all(24.r),
                            child: Center(
                              child: Text(
                                messageKey.tr(context: context),
                                style: AppTextStyles.font14Regular.copyWith(
                                  color: AppColors.error,
                                ),
                              ),
                            ),
                          );
                        },
                        actionSuccess: (_) =>
                            _buildPlansView(context, cubit.allPlans),
                        success: (plans) => _buildPlansView(context, plans),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPlansView(BuildContext context, List<AdminPlanModel> plans) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'admin.plans.count'.tr(
                context: context,
                args: ['${plans.length}'],
              ),
              style: AppTextStyles.font12Regular,
            ),
            InkWell(
              onTap: () => showModalBottomSheet<void>(
                context: context,
                isScrollControlled: true,
                backgroundColor: AppColors.cardBackground,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                ),
                builder: (_) => MultiBlocProvider(
                  providers: [
                    BlocProvider<SupervisorPlansCubit>(
                      create: (_) => sl<SupervisorPlansCubit>(),
                    ),
                    BlocProvider<SupervisorTeamCubit>(
                      create: (_) => sl<SupervisorTeamCubit>()..loadTeam(),
                    ),
                  ],
                  child: const SupervisorCreatePlanSheetWidget(),
                ),
              ),
              child: Text(
                'admin.plans.newPlan'.tr(context: context),
                style: AppTextStyles.font13SemiBold.copyWith(
                  color: AppColors.brandPrimary,
                ),
              ),
            ),
          ],
        ),
        hSpace(12),
        if (plans.isEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 32),
            child: Center(
              child: Text(
                'admin.requests.emptyAll'.tr(
                  context: context,
                ),
                style: AppTextStyles.font14Regular,
              ),
            ),
          )
        else
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: plans.length,
            separatorBuilder: (_, _) => hSpace(10),
            itemBuilder: (context, index) {
              final plan = plans[index];
              return Container(
                padding: EdgeInsets.all(14.r),
                decoration: AppDecorations.card,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'admin.plans.plan'.tr(
                        context: context,
                        args: ['${plan.id ?? ''}'],
                      ),
                      style: AppTextStyles.font16Bold,
                    ),
                    if (plan.notes?.isNotEmpty ?? false) ...[
                      hSpace(4),
                      Text(
                        plan.notes!,
                        style: AppTextStyles.font13Regular,
                      ),
                    ],
                    hSpace(8),
                    Text(
                      'admin.plans.date'.tr(
                        context: context,
                        args: [
                          AppDateFormatter.formatDateString(
                            plan.planDate,
                          ),
                        ],
                      ),
                      style: AppTextStyles.font12Regular,
                    ),
                    if (plan.departmentName?.isNotEmpty ?? false) ...[
                      hSpace(4),
                      Text(
                        'admin.plans.department'.tr(
                          context: context,
                          args: [plan.departmentName!],
                        ),
                        style: AppTextStyles.font12Regular,
                      ),
                    ],
                  ],
                ),
              );
            },
          ),
      ],
    );
  }
}
