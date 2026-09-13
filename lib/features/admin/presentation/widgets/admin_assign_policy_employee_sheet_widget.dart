import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/admin/data/models/employee/employee_model.dart';
import 'package:check_point_v2/features/admin/data/models/shifts_policies/police_model.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/employee/admin_employees_cubit.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/employee/admin_employees_state.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/shifts_policies/admin_shifts_policies_cubit.dart';

class AdminAssignPolicyEmployeeSheetWidget extends StatefulWidget {
  const AdminAssignPolicyEmployeeSheetWidget({
    required this.policy,
    required this.shiftId,
    required this.policies,
    super.key,
  });

  final PoliceModel policy;
  final int shiftId;
  final List<PoliceModel> policies;

  @override
  State<AdminAssignPolicyEmployeeSheetWidget> createState() =>
      _AdminAssignPolicyEmployeeSheetWidgetState();
}

class _AdminAssignPolicyEmployeeSheetWidgetState
    extends State<AdminAssignPolicyEmployeeSheetWidget> {
  late final TextEditingController searchController;
  late final Set<String> existingIds;
  late final Set<String> assignedToAnotherPolicyIds;
  final selectedIds = <String>{};

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
    existingIds = (widget.policy.employees ?? const [])
        .map((employee) => employee.id)
        .whereType<String>()
        .toSet();
    assignedToAnotherPolicyIds = {
      for (final policy in widget.policies)
        if (policy.id != widget.policy.id)
          ...((policy.employees ?? const [])
              .map((employee) => employee.id)
              .whereType<String>()),
    };
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  Future<void> _transferEmployee(EmployeeModel employee) async {
    final employeeId = employee.id;
    final policyId = widget.policy.id;
    if (employeeId == null || policyId == null) return;
    final success = await context
        .read<AdminShiftsPoliciesCubit>()
        .transferEmployee(
          policyId: policyId,
          shiftId: widget.shiftId,
          employeeId: employeeId,
        );
    if (success && mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 20.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 42.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: AppColors.border,
                  borderRadius: BorderRadius.circular(4.r),
                ),
              ),
            ),
            hSpace(14),
            Text(
              'admin.shifts.policies.assignEmployeeTitle'.tr(context: context),
              style: AppTextStyles.font18Bold,
            ),
            hSpace(4),
            Text(
              widget.policy.effectiveName,
              style: AppTextStyles.font13Regular.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            hSpace(14),
            CustomTextFormField(
              controller: searchController,
              hintText: 'admin.shifts.policies.searchEmployee'.tr(
                context: context,
              ),
              prefixIcon: Icon(Icons.search_rounded, size: 20.r),
              onChanged: (_) => setState(() {}),
            ),
            hSpace(12),
            Flexible(
              child: BlocBuilder<AdminEmployeesCubit, AdminEmployeesState>(
                builder: (context, state) => switch (state) {
                  AdminEmployeesStateLoading() ||
                  AdminEmployeesStateInitial() => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  AdminEmployeesStateError(:final messageKey) => Center(
                    child: Text(messageKey.tr(context: context)),
                  ),
                  AdminEmployeesStateSuccess(:final employees) ||
                  AdminEmployeesStateActionSuccess(:final employees) => () {
                    final query = searchController.text.trim().toLowerCase();
                    final visibleEmployees = query.isEmpty
                        ? employees
                        : employees.where((employee) {
                            final name = (employee.name ?? '').toLowerCase();
                            final code = (employee.userName ?? '')
                                .toLowerCase();
                            return name.contains(query) || code.contains(query);
                          }).toList();
                    return ListView.separated(
                      shrinkWrap: true,
                      itemCount: visibleEmployees.length,
                      separatorBuilder: (_, _) => hSpace(8),
                      itemBuilder: (context, index) {
                        final employee = visibleEmployees[index];
                        return AdminPolicyEmployeeOptionWidget(
                          employee: employee,
                          isAssignedToAnotherPolicy:
                              assignedToAnotherPolicyIds.contains(
                                employee.id,
                              ) ||
                              ((employee.shiftName ?? '').isNotEmpty &&
                                  employee.shiftName !=
                                      widget.policy.effectiveName),
                          isAlreadyAssigned: existingIds.contains(employee.id),
                          onTransfer:
                              assignedToAnotherPolicyIds.contains(
                                    employee.id,
                                  ) ||
                                  ((employee.shiftName ?? '').isNotEmpty &&
                                      employee.shiftName !=
                                          widget.policy.effectiveName)
                              ? () => _transferEmployee(employee)
                              : null,
                          isSelected: selectedIds.contains(employee.id),
                          onTap: () {
                            final id = employee.id;
                            if (id == null ||
                                existingIds.contains(id) ||
                                assignedToAnotherPolicyIds.contains(id) ||
                                ((employee.shiftName ?? '').isNotEmpty &&
                                    employee.shiftName !=
                                        widget.policy.effectiveName)) {
                              return;
                            }
                            setState(() {
                              if (!selectedIds.add(id)) selectedIds.remove(id);
                            });
                          },
                        );
                      },
                    );
                  }(),
                  _ => const SizedBox.shrink(),
                },
              ),
            ),
            hSpace(14),
            SizedBox(
              width: double.infinity,
              child: CustomButton(
                text: 'admin.shifts.policies.assignEmployee'.tr(
                  context: context,
                ),
                onTap: selectedIds.isEmpty
                    ? () {}
                    : () async {
                        final existingIds =
                            (widget.policy.employees ?? const [])
                                .map((employee) => employee.id)
                                .whereType<String>();
                        final employeeIds = {
                          ...existingIds,
                          ...selectedIds,
                        }.toList();
                        final success = await context
                            .read<AdminShiftsPoliciesCubit>()
                            .assignEmployees(
                              policyId: widget.policy.id!,
                              shiftId: widget.shiftId,
                              employeeIds: employeeIds,
                            );
                        if (!context.mounted) return;
                        if (success) Navigator.pop(context);
                      },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AdminPolicyEmployeeOptionWidget extends StatelessWidget {
  const AdminPolicyEmployeeOptionWidget({
    required this.employee,
    required this.isAssignedToAnotherPolicy,
    required this.isAlreadyAssigned,
    required this.isSelected,
    required this.onTap,
    this.onTransfer,
    super.key,
  });

  final EmployeeModel employee;
  final bool isAssignedToAnotherPolicy;
  final bool isAlreadyAssigned;
  final bool isSelected;
  final VoidCallback onTap;
  final VoidCallback? onTransfer;

  @override
  Widget build(BuildContext context) {
    final name = employee.name ?? employee.userName ?? '-';
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: isAlreadyAssigned
              ? AppColors.softGreenBackground
              : isAssignedToAnotherPolicy
              ? AppColors.softYellowBackground
              : isSelected
              ? AppColors.softBrandBackground
              : AppColors.cardBackground,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isAlreadyAssigned
                ? AppColors.success
                : isAssignedToAnotherPolicy
                ? AppColors.warningOrange
                : isSelected
                ? AppColors.brandPrimary
                : AppColors.border,
          ),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 18.r,
              backgroundColor: AppColors.softBrandBackground,
              child: Text(
                name[0].toUpperCase(),
                style: AppTextStyles.font12Bold,
              ),
            ),
            vSpace(10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: AppTextStyles.font13SemiBold),
                  Text(
                    employee.departmentName ?? employee.userName ?? '-',
                    style: AppTextStyles.font11Regular.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            if (isAlreadyAssigned)
              Text(
                'admin.shifts.policies.alreadyAssigned'.tr(context: context),
                style: AppTextStyles.font11Medium.copyWith(
                  color: AppColors.success,
                ),
              )
            else if (isAssignedToAnotherPolicy)
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'admin.shifts.policies.assignedToOtherShift'.tr(
                      context: context,
                    ),
                    style: AppTextStyles.font11Medium.copyWith(
                      color: AppColors.warningOrange,
                    ),
                  ),
                  if (onTransfer != null)
                    TextButton(
                      onPressed: onTransfer,
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 6.w),
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: Text(
                        'admin.shifts.policies.transfer'.tr(context: context),
                        style: AppTextStyles.font11Medium.copyWith(
                          color: AppColors.brandPrimary,
                        ),
                      ),
                    ),
                ],
              )
            else
              Icon(
                isSelected ? Icons.check_circle_rounded : Icons.circle_outlined,
                color: isSelected ? AppColors.success : AppColors.placeholder,
              ),
          ],
        ),
      ),
    );
  }
}
