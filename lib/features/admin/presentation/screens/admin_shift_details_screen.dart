import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/core.dart';
import '../cubit/admin_shifts_policies_cubit.dart';
import '../cubit/admin_shifts_policies_state.dart';
import '../widgets/admin_new_policy_button_widget.dart';
import '../widgets/admin_shift_policies_skeleton_widget.dart';

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
        title: Text('Shift Details', style: AppTextStyles.font18Bold),
      ),
      body: SingleChildScrollView(
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
                  error: (messageKey) => Text(messageKey.tr(context: context)),
                  actionSuccess: (_) => const SizedBox.shrink(),
                  success: (shifts, policies) {
                    if (policies.isEmpty) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 24),
                        child: Center(
                          child: Text(
                            'No policies found for this shift.',
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
                        final employees = policy.employees ?? const [];
                        return Container(
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
                                            .read<AdminShiftsPoliciesCubit>()
                                            .deletePolicy(policy.id!, shiftId);
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
                              Row(
                                children: [
                                  Icon(
                                    Icons.access_time_rounded,
                                    size: 16.r,
                                    color: AppColors.textSecondary,
                                  ),
                                  wSpace(6),
                                  Text(
                                    '${policy.effectiveClockIn} - ${policy.effectiveClockOut}',
                                    style: AppTextStyles.font12Medium,
                                  ),
                                  if (policy.area != null) ...[
                                    wSpace(12),
                                    Icon(
                                      Icons.location_on_outlined,
                                      size: 16.r,
                                      color: AppColors.info,
                                    ),
                                    wSpace(4),
                                    Text(
                                      policy.area!,
                                      style: AppTextStyles.font12Regular
                                          .copyWith(color: AppColors.info),
                                    ),
                                  ],
                                ],
                              ),
                              if (policy.workDays != null &&
                                  policy.workDays!.isNotEmpty) ...[
                                hSpace(6),
                                Text(
                                  'Days: ${policy.workDays!.join(', ')}',
                                  style: AppTextStyles.font12Regular.copyWith(
                                    color: AppColors.textSecondary,
                                  ),
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
                              if (employees.isNotEmpty) ...[
                                hSpace(8),
                                Wrap(
                                  spacing: 6.w,
                                  runSpacing: 6.h,
                                  children: [
                                    for (final emp in employees)
                                      Chip(
                                        avatar: CircleAvatar(
                                          backgroundColor:
                                              AppColors.softBrandBackground,
                                          child: Text(
                                            (emp.name ?? emp.userName ?? '?')
                                                .substring(0, 1)
                                                .toUpperCase(),
                                            style: TextStyle(
                                              fontSize: 10.sp,
                                              color: AppColors.brandPrimary,
                                            ),
                                          ),
                                        ),
                                        label: Text(
                                          emp.name ?? emp.userName ?? '-',
                                          style: AppTextStyles.font12Regular,
                                        ),
                                        backgroundColor: AppColors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            8.r,
                                          ),
                                          side: BorderSide(
                                            color: AppColors.border,
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ],
                            ],
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
    );
  }
}
