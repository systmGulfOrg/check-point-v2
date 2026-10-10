import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/shifts_policies/admin_shifts_policies_cubit.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/shifts_policies/admin_shifts_policies_state.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/employee/admin_employees_cubit.dart';
import 'package:check_point_v2/features/admin/presentation/widgets/admin_assign_policy_employee_sheet_widget.dart';
import 'package:check_point_v2/features/admin/presentation/widgets/admin_new_policy_button_widget.dart';
import 'package:check_point_v2/features/admin/presentation/widgets/admin_policy_time_range_widget.dart';
import 'package:check_point_v2/features/admin/presentation/widgets/admin_shift_employees_widget.dart';
import 'package:check_point_v2/features/admin/presentation/widgets/admin_shift_policies_skeleton_widget.dart';

class AdminShiftDetailsScreen extends StatelessWidget {
  const AdminShiftDetailsScreen({required this.shiftKey, super.key});

  final String shiftKey;

  @override
  Widget build(BuildContext context) {
    final shiftId = int.tryParse(shiftKey);
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        title: Text(
          'admin.shifts.details.title'.tr(context: context),
          style: AppTextStyles.font18Bold,
        ),
      ),
      body: RefreshIndicator(
        color: AppColors.brandPrimary,
        onRefresh: shiftId == null
            ? () async {}
            : () => context
                  .read<AdminShiftsPoliciesCubit>()
                  .loadPoliciesForShift(shiftId),
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
                    'admin.shifts.policies.title'.tr(context: context),
                    style: AppTextStyles.font12Bold,
                  ),
                  const AdminNewPolicyButtonWidget(
                    labelKey: 'admin.shifts.policies.add',
                  ),
                ],
              ),
              hSpace(10),
              BlocBuilder<AdminShiftsPoliciesCubit, AdminShiftsPoliciesState>(
                builder: (context, state) {
                  return state.when(
                    initial: () => const SizedBox.shrink(),
                    loading: () => const AdminShiftPoliciesSkeletonWidget(),
                    error: (messageKey) =>
                        Text(messageKey.tr(context: context)),
                    actionSuccess: (_) => const SizedBox.shrink(),
                    success: (shifts, policies) {
                      if (policies.isEmpty) {
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: 24.h),
                          child: Center(
                            child: Text(
                              'admin.shifts.policies.empty'.tr(
                                context: context,
                              ),
                              style: AppTextStyles.font14Regular,
                            ),
                          ),
                        );
                      }
                      return ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: policies.length,
                        separatorBuilder: (_, _) => hSpace(10),
                        itemBuilder: (context, index) {
                          final policy = policies[index];
                          final rawEmployees = policy.employees ?? const [];
                          final seenEmployeeIds = <String>{};
                          final employees = rawEmployees.where((e) {
                            final id = e.id ?? e.userName ?? '';
                            return id.isEmpty || seenEmployeeIds.add(id);
                          }).toList();
                          return AnimatedListItemWidget(
                            index: index,
                            child: Container(
                              padding: EdgeInsets.all(14.r),
                              decoration: BoxDecoration(
                                color: AppColors.cardBackground,
                                borderRadius: BorderRadius.circular(14.r),
                                border: Border.all(color: AppColors.border),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        policy.effectiveName,
                                        style: AppTextStyles.font14SemiBold,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          if (policy.id != null &&
                                              shiftId != null) {
                                            context
                                                .read<
                                                  AdminShiftsPoliciesCubit
                                                >()
                                                .deletePolicy(
                                                  policy.id!,
                                                  shiftId,
                                                );
                                          }
                                        },
                                        child: Text(
                                          'admin.shifts.policies.delete'.tr(
                                            context: context,
                                          ),
                                          style: AppTextStyles.font12Regular
                                              .copyWith(color: AppColors.error),
                                        ),
                                      ),
                                    ],
                                  ),
                                  hSpace(6),
                                  AdminPolicyTimeRangeWidget(
                                    clockIn: policy.effectiveClockIn,
                                    clockOut: policy.effectiveClockOut,
                                  ),
                                  if (policy.area != null) ...[
                                    hSpace(8),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.location_on_outlined,
                                          size: 16.r,
                                          color: AppColors.info,
                                        ),
                                        wSpace(4),
                                        Expanded(
                                          child: Text(
                                            policy.area!,
                                            overflow: TextOverflow.ellipsis,
                                            style: AppTextStyles.font12Regular
                                                .copyWith(
                                                  color: AppColors.info,
                                                ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                  hSpace(10),
                                  Text(
                                    'admin.shifts.policies.assigned'.tr(
                                      context: context,
                                      args: [employees.length.toString()],
                                    ),
                                    style: AppTextStyles.font12Bold.copyWith(
                                      color: AppColors.textPrimary,
                                    ),
                                  ),
                                  Align(
                                    alignment: AlignmentDirectional.centerEnd,
                                    child: TextButton.icon(
                                      onPressed:
                                          policy.id == null || shiftId == null
                                          ? null
                                          : () => showModalBottomSheet<void>(
                                              context: context,
                                              isScrollControlled: true,
                                              constraints: BoxConstraints(
                                                maxHeight:
                                                    MediaQuery.sizeOf(
                                                      context,
                                                    ).height *
                                                    0.58,
                                              ),
                                              backgroundColor:
                                                  AppColors.cardBackground,
                                              builder: (_) => MultiBlocProvider(
                                                providers: [
                                                  BlocProvider.value(
                                                    value: context
                                                        .read<
                                                          AdminShiftsPoliciesCubit
                                                        >(),
                                                  ),
                                                  BlocProvider.value(
                                                    value: context
                                                        .read<
                                                          AdminEmployeesCubit
                                                        >(),
                                                  ),
                                                ],
                                                child:
                                                    AdminAssignPolicyEmployeeSheetWidget(
                                                      policy: policy,
                                                      shiftId: shiftId,
                                                      policies: policies,
                                                    ),
                                              ),
                                            ),
                                      icon: Icon(
                                        Icons.person_add_alt_1_rounded,
                                        size: 16.r,
                                      ),
                                      label: Text(
                                        'admin.shifts.policies.assignEmployee'
                                            .tr(context: context),
                                      ),
                                    ),
                                  ),
                                  if (employees.isNotEmpty) ...[
                                    hSpace(8),
                                    AdminShiftEmployeesWidget(
                                      employees: employees,
                                    ),
                                  ],
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
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
