import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/employee/presentation/cubit/plans/employee_plans_cubit.dart';
import 'package:check_point_v2/features/employee/presentation/cubit/plans/employee_plans_state.dart';
import 'package:check_point_v2/features/employee/presentation/widgets/employee_plan_data.dart';
import 'package:check_point_v2/features/employee/presentation/widgets/employee_plan_detail_card_widget.dart';
import 'package:check_point_v2/features/employee/presentation/widgets/employee_new_project_button_widget.dart';

class EmployeePlansScreen extends StatefulWidget {
  const EmployeePlansScreen({super.key});

  @override
  State<EmployeePlansScreen> createState() => _EmployeePlansScreenState();
}

class _EmployeePlansScreenState extends State<EmployeePlansScreen> {
  @override
  void initState() {
    super.initState();
    context.read<EmployeePlansCubit>().loadMyPlans();
  }

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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlinedButton.icon(
                    onPressed: () =>
                        Navigator.pushNamed(context, AppRoutes.projects),
                    icon: const Icon(Icons.view_kanban_outlined),
                    label: Text('projects.title'.tr(context: context)),
                  ),
                  const EmployeeNewProjectButtonWidget(),
                ],
              ),
              hSpace(14),
              BlocConsumer<EmployeePlansCubit, EmployeePlansState>(
                listener: (context, state) {
                  switch (state) {
                    case EmployeePlansStateActionSuccess(:final message):
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text(message)));
                    case EmployeePlansStateError(:final messageKey):
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text(messageKey)));
                    default:
                      break;
                  }
                },
                builder: (context, state) {
                  final plans = switch (state) {
                    EmployeePlansStateSuccess(:final plans) =>
                      plans
                          .map(
                            (p) => EmployeePlanData(
                              id: '${p.id ?? 0}',
                              title: p.title ?? 'Plan #${p.id ?? 0}',
                              dateTime: p.planDate ?? DateTime.now().toString(),
                              planType: p.planType ?? 'Mission',
                              description: p.notes ?? '',
                              status: p.status ?? 'planned',
                              assignees: const ['EM'],
                            ),
                          )
                          .toList(),
                    _ => const <EmployeePlanData>[],
                  };

                  if (state is EmployeePlansStateLoading) {
                    return Expanded(
                      child: Skeletonizer(
                        child: RefreshIndicator(
                          color: AppColors.brandPrimary,
                          onRefresh: context
                              .read<EmployeePlansCubit>()
                              .loadMyPlans,
                          child: ListView.separated(
                            physics: const AlwaysScrollableScrollPhysics(),
                            itemCount: 3,
                            separatorBuilder: (_, _) => hSpace(12),
                            itemBuilder: (_, _) => EmployeePlanDetailCardWidget(
                              plan: const EmployeePlanData(
                                id: '000',
                                title: 'Loading plan title',
                                dateTime: 'Loading date',
                                planType: 'Mission',
                                description: 'Loading plan description',
                                status: 'planned',
                                assignees: ['EM'],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }

                  return Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${plans.length} plans',
                          style: AppTextStyles.font13Regular.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                        hSpace(12),
                        Expanded(
                          child: plans.isEmpty
                              ? Center(child: Text('employee.plans.empty'.tr()))
                              : RefreshIndicator(
                                  color: AppColors.brandPrimary,
                                  onRefresh: context
                                      .read<EmployeePlansCubit>()
                                      .loadMyPlans,
                                  child: ListView.separated(
                                    physics:
                                        const AlwaysScrollableScrollPhysics(),
                                    itemCount: plans.length,
                                    separatorBuilder: (_, _) => hSpace(12),
                                    itemBuilder: (context, index) {
                                      return EmployeePlanDetailCardWidget(
                                        plan: plans[index],
                                      );
                                    },
                                  ),
                                ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
