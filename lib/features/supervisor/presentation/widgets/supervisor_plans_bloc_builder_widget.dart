import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/admin/data/models/plans/admin_plan_model.dart';
import 'package:check_point_v2/features/supervisor/presentation/cubit/plans/supervisor_plans_cubit.dart';
import 'package:check_point_v2/features/supervisor/presentation/cubit/plans/supervisor_plans_state.dart';
import 'supervisor_plans_list_widget.dart';

class SupervisorPlansBlocBuilderWidget extends StatelessWidget {
  const SupervisorPlansBlocBuilderWidget({super.key});

  static const _dummyPlans = [
    AdminPlanModel(
      title: 'Loading Emergency Mission Plan',
      description: 'Loading detailed plan description',
      startDate: '2026-09-01',
      endDate: '2026-09-05',
      assignedEmployeeName: 'Loading Employee',
    ),
    AdminPlanModel(
      title: 'Loading Site Inspection Plan',
      description: 'Loading inspection plan details',
      startDate: '2026-09-10',
      endDate: '2026-09-12',
      assignedEmployeeName: 'Loading Employee',
    ),
  ];

  void _showDeleteDialog(
    BuildContext context,
    SupervisorPlansCubit cubit,
    int planId,
  ) {
    showDialog<void>(
      context: context,
      builder: (dialogContext) => AppDeleteConfirmationDialogWidget(
        title: 'admin.locations.delete'.tr(context: context),
        message: 'admin.plans.deleteMessage'.tr(context: context),
        onConfirm: () {
          Navigator.pop(dialogContext);
          cubit.deletePlan(planId);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SupervisorPlansCubit>();

    return BlocListener<SupervisorPlansCubit, SupervisorPlansState>(
      listener: (context, state) {
        if (state is SupervisorPlansError && cubit.allPlans.isNotEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.messageKey.tr(context: context)),
              backgroundColor: AppColors.error,
            ),
          );
        }
      },
      child: BlocBuilder<SupervisorPlansCubit, SupervisorPlansState>(
        builder: (context, state) {
          return switch (state) {
            SupervisorPlansLoading() => cubit.allPlans.isNotEmpty
                ? SupervisorPlansListWidget(
                    plans: cubit.allPlans,
                    onDelete: (plan) {
                      if (plan.id != null) {
                        _showDeleteDialog(context, cubit, plan.id!);
                      }
                    },
                  )
                : const Skeletonizer(
                    enabled: true,
                    child: SupervisorPlansListWidget(plans: _dummyPlans),
                  ),
            SupervisorPlansSuccess(:final plans) => SupervisorPlansListWidget(
                plans: plans,
                onDelete: (plan) {
                  if (plan.id != null) {
                    _showDeleteDialog(context, cubit, plan.id!);
                  }
                },
              ),
            SupervisorPlansError(:final messageKey) => cubit.allPlans.isNotEmpty
                ? SupervisorPlansListWidget(
                    plans: cubit.allPlans,
                    onDelete: (plan) {
                      if (plan.id != null) {
                        _showDeleteDialog(context, cubit, plan.id!);
                      }
                    },
                  )
                : Center(
                    child: Text(
                      messageKey.tr(context: context),
                      style: AppTextStyles.font14Regular.copyWith(
                        color: AppColors.error,
                      ),
                    ),
                  ),
            _ => const SupervisorPlansListWidget(plans: []),
          };
        },
      ),
    );
  }
}
