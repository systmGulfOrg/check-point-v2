import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/admin/data/models/locations/branch_response_model.dart';
import 'package:check_point_v2/features/admin/data/models/locations/department_response_model.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/employee/admin_employees_cubit.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/employee/admin_employees_state.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/locations/admin_branches_cubit.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/locations/admin_branches_state.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/locations/admin_departments_cubit.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/locations/admin_departments_state.dart';
import 'package:check_point_v2/features/admin/presentation/widgets/admin_wizard_field_widget.dart';

class AdminCreateEmployeeOrganizationStepWidget extends StatelessWidget {
  const AdminCreateEmployeeOrganizationStepWidget({
    required this.selectedDepartmentId,
    required this.selectedBranchId,
    required this.selectedDirectManagerId,
    required this.onDepartmentChanged,
    required this.onBranchChanged,
    required this.onDirectManagerChanged,
    super.key,
  });

  final int? selectedDepartmentId;
  final int? selectedBranchId;
  final String? selectedDirectManagerId;
  final ValueChanged<int?> onDepartmentChanged;
  final ValueChanged<int?> onBranchChanged;
  final ValueChanged<String?> onDirectManagerChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'admin.employeeWizard.attendanceTitle'.tr(context: context),
          style: AppTextStyles.font16Bold,
        ),
        hSpace(16),

        // Department
        BlocBuilder<AdminDepartmentsCubit, AdminDepartmentsState>(
          builder: (context, deptState) {
            final rawDepartments = switch (deptState) {
              AdminDepartmentsSuccess(:final departments) => departments,
              _ => const <DepartmentModel>[],
            };
            final departments = <DepartmentModel>[];
            final seenIds = <int>{};
            for (final d in rawDepartments) {
              if (d.id != null && seenIds.add(d.id!)) {
                departments.add(d);
              }
            }
            final hasSelected = departments.any(
              (d) => d.id == selectedDepartmentId,
            );

            return AdminWizardFieldWidget(
              label:
                  '${'admin.employeeWizard.department'.tr(context: context)} *',
              child: DropdownButtonFormField<int>(
                key: ValueKey(
                  'dept_${hasSelected ? selectedDepartmentId : 'none'}',
                ),
                initialValue: hasSelected ? selectedDepartmentId : null,
                isExpanded: true,
                hint: Text(
                  'admin.employeeWizard.department'.tr(context: context),
                ),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: AppColors.fieldBackground,
                ),
                items: departments
                    .map(
                      (d) => DropdownMenuItem<int>(
                        value: d.id,
                        child: Text(d.departmentName ?? '-'),
                      ),
                    )
                    .toList(),
                onChanged: onDepartmentChanged,
              ),
            );
          },
        ),

        // Branch
        BlocBuilder<AdminBranchesCubit, AdminBranchesState>(
          builder: (context, branchState) {
            final rawBranches = switch (branchState) {
              AdminBranchesSuccess(:final branches) => branches,
              _ => const <BranchModel>[],
            };
            final branches = <BranchModel>[];
            final seenIds = <int>{};
            for (final b in rawBranches) {
              if (b.id != null && seenIds.add(b.id!)) {
                branches.add(b);
              }
            }
            final hasSelected = branches.any((b) => b.id == selectedBranchId);

            return AdminWizardFieldWidget(
              label: '${'admin.employeeWizard.branch'.tr(context: context)} *',
              child: DropdownButtonFormField<int>(
                key: ValueKey(
                  'branch_${hasSelected ? selectedBranchId : 'none'}',
                ),
                initialValue: hasSelected ? selectedBranchId : null,
                isExpanded: true,
                hint: Text('admin.employeeWizard.branch'.tr(context: context)),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: AppColors.fieldBackground,
                ),
                items: branches
                    .map(
                      (b) => DropdownMenuItem<int>(
                        value: b.id,
                        child: Text(b.name ?? '-'),
                      ),
                    )
                    .toList(),
                onChanged: onBranchChanged,
              ),
            );
          },
        ),

        // Direct Manager
        BlocBuilder<AdminEmployeesCubit, AdminEmployeesState>(
          builder: (context, empState) {
            final employees =
                context.read<AdminEmployeesCubit>().employees;
            final validEmployees =
                employees.where((e) => e.id != null).toList();

            return AdminWizardFieldWidget(
              label: 'admin.employeeWizard.directManager'.tr(context: context),
              child: DropdownButtonFormField<String?>(
                key: ValueKey(
                  'direct_manager_${selectedDirectManagerId ?? 'none'}',
                ),
                initialValue: selectedDirectManagerId,
                isExpanded: true,
                hint: Text(
                  'admin.employeeWizard.selectDirectManager'.tr(
                    context: context,
                  ),
                ),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: AppColors.fieldBackground,
                ),
                items: [
                  DropdownMenuItem<String?>(
                    value: null,
                    child: Text(
                      'admin.employeeWizard.noDirectManager'.tr(
                        context: context,
                      ),
                    ),
                  ),
                  ...validEmployees.map(
                    (e) => DropdownMenuItem<String?>(
                      value: e.id,
                      child: Text(
                        '${e.name ?? e.userName ?? '-'} (${e.role ?? 'Employee'})',
                      ),
                    ),
                  ),
                ],
                onChanged: onDirectManagerChanged,
              ),
            );
          },
        ),
      ],
    );
  }
}
