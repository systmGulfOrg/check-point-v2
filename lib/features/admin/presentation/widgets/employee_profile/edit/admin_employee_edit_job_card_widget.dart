import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/admin/data/models/employee/employee_model.dart';
import 'package:check_point_v2/features/admin/data/models/locations/branch_response_model.dart';
import 'package:check_point_v2/features/admin/data/models/locations/department_response_model.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/employee/admin_employees_cubit.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/employee/admin_employees_state.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/locations/admin_branches_cubit.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/locations/admin_branches_state.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/locations/admin_departments_cubit.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/locations/admin_departments_state.dart';
import 'package:check_point_v2/features/admin/presentation/widgets/admin_employee_work_system_widget.dart';
import 'package:check_point_v2/features/contractor/data/models/site_boundary_model.dart';
import 'package:check_point_v2/features/contractor/presentation/cubit/contractor_cubit.dart';
import 'package:check_point_v2/features/contractor/presentation/cubit/contractor_state.dart';
import '../admin_employee_profile_info_card_widget.dart';

class AdminEmployeeEditJobCardWidget extends StatelessWidget {
  const AdminEmployeeEditJobCardWidget({
    required this.positionController,
    required this.employeeCodeController,
    required this.selectedDepartmentId,
    required this.selectedBranchId,
    required this.selectedBranchIds,
    required this.selectedSiteIds,
    required this.selectedLocationType,
    required this.selectedSiteId,
    required this.selectedWorkSystem,
    required this.selectedRemoteWorkPolicyId,
    required this.selectedDirectManagerId,
    required this.onDepartmentChanged,
    required this.onBranchChanged,
    required this.onBranchIdsChanged,
    required this.onSiteIdsChanged,
    required this.onLocationTypeChanged,
    required this.onSiteChanged,
    required this.onWorkSystemChanged,
    required this.onRemoteWorkPolicyChanged,
    required this.onManagerChanged,
    super.key,
  });

  final TextEditingController positionController;
  final TextEditingController employeeCodeController;
  final int? selectedDepartmentId;
  final int? selectedBranchId;
  final Set<int> selectedBranchIds;
  final Set<String> selectedSiteIds;
  final String selectedLocationType;
  final String? selectedSiteId;
  final String selectedWorkSystem;
  final String? selectedRemoteWorkPolicyId;
  final String? selectedDirectManagerId;
  final ValueChanged<int?> onDepartmentChanged;
  final ValueChanged<int?> onBranchChanged;
  final ValueChanged<Set<int>> onBranchIdsChanged;
  final ValueChanged<Set<String>> onSiteIdsChanged;
  final ValueChanged<String> onLocationTypeChanged;
  final ValueChanged<String?> onSiteChanged;
  final ValueChanged<String> onWorkSystemChanged;
  final ValueChanged<String?> onRemoteWorkPolicyChanged;
  final ValueChanged<String?> onManagerChanged;

  @override
  Widget build(BuildContext context) {
    return AdminEmployeeProfileInfoCardWidget(
      title: 'employee.profile.sectionJob'.tr(context: context),
      icon: Icons.work_outline_rounded,
      children: [
        CustomTextFormField(
          controller: positionController,
          hintText: 'employee.profile.position'.tr(context: context),
          prefixIcon: const Icon(
            Icons.badge_outlined,
            color: AppColors.brandPrimary,
          ),
        ),
        hSpace(10),
        CustomTextFormField(
          controller: employeeCodeController,
          hintText: 'EMP-23211',
          prefixIcon: const Icon(
            Icons.tag_rounded,
            color: AppColors.brandPrimary,
          ),
          suffixIcon: IconButton(
            icon: const Icon(
              Icons.refresh_rounded,
              color: AppColors.brandPrimary,
            ),
            onPressed: () {
              employeeCodeController.text =
                  CodeGeneratorHelper.generateEmployeeCode();
            },
          ),
        ),
        hSpace(10),
        BlocBuilder<AdminDepartmentsCubit, AdminDepartmentsState>(
          builder: (context, state) {
            final departments = state.maybeWhen(
              success: (depts) => depts,
              orElse: () => const <DepartmentModel>[],
            );
            final items = departments
                .where((d) => d.id != null)
                .map(
                  (d) => DropdownMenuItem<int>(
                    value: d.id!,
                    child: Text(d.departmentName ?? '-'),
                  ),
                )
                .toList();
            return DropdownButtonFormField<int>(
              isExpanded: true,
              initialValue: departments.any((d) => d.id == selectedDepartmentId)
                  ? selectedDepartmentId
                  : null,
              decoration: InputDecoration(
                labelText: 'employee.profile.department'.tr(context: context),
                prefixIcon: const Icon(
                  Icons.business_outlined,
                  color: AppColors.brandPrimary,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 12.w,
                  vertical: 12.h,
                ),
              ),
              items: items,
              onChanged: onDepartmentChanged,
            );
          },
        ),
        hSpace(10),
        DropdownButtonFormField<String>(
          isExpanded: true,
          initialValue: selectedLocationType,
          decoration: InputDecoration(
            labelText: 'employee.profile.locationType'.tr(context: context),
            prefixIcon: const Icon(
              Icons.location_on_outlined,
              color: AppColors.brandPrimary,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 12.w,
              vertical: 12.h,
            ),
          ),
          items: [
            DropdownMenuItem(
              value: 'branch',
              child: Text('employee.profile.branch'.tr(context: context)),
            ),
            DropdownMenuItem(
              value: 'site',
              child: Text('employee.profile.site'.tr(context: context)),
            ),
          ],
          onChanged: (value) {
            if (value != null) onLocationTypeChanged(value);
          },
        ),
        hSpace(10),
        Text(
          'employee.profile.attendanceLocation'.tr(context: context),
          style: AppTextStyles.font13Medium,
        ),
        hSpace(6),
        if (selectedLocationType == 'branch')
          BlocBuilder<AdminBranchesCubit, AdminBranchesState>(
            builder: (context, state) {
              final branches = state.maybeWhen(
                success: (value) => value,
                orElse: () => const <BranchModel>[],
              );
              return Wrap(
                spacing: 8.w,
                runSpacing: 6.h,
                children: branches
                    .where((branch) => branch.id != null)
                    .map(
                      (branch) => FilterChip(
                        label: Text(branch.name ?? '-'),
                        selected: selectedBranchIds.contains(branch.id),
                        onSelected: (selected) {
                          final values = {...selectedBranchIds};
                          if (selected) {
                            values.add(branch.id!);
                          } else {
                            values.remove(branch.id);
                          }
                          onBranchIdsChanged(values);
                        },
                      ),
                    )
                    .toList(),
              );
            },
          ),
        if (selectedLocationType == 'site')
          BlocBuilder<ContractorCubit, ContractorState>(
            builder: (context, state) {
              final sites =
                  state.mapOrNull(success: (value) => value.sites) ??
                  const <SiteBoundaryModel>[];
              if (sites.isEmpty) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.h),
                  child: Text(
                    'admin.employeeWizard.noSitesAvailable'.tr(
                      context: context,
                    ),
                    style: AppTextStyles.font13Medium.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                );
              }
              return Wrap(
                spacing: 8.w,
                runSpacing: 6.h,
                children: sites
                    .map(
                      (site) => FilterChip(
                        label: Text(site.siteName),
                        selected: selectedSiteIds.contains(site.siteId),
                        onSelected: (selected) {
                          final values = {...selectedSiteIds};
                          if (selected) {
                            values.add(site.siteId);
                          } else {
                            values.remove(site.siteId);
                          }
                          onSiteIdsChanged(values);
                        },
                      ),
                    )
                    .toList(),
              );
            },
          ),
        hSpace(10),
        AdminEmployeeWorkSystemWidget(
          selectedSystem: selectedWorkSystem,
          selectedPolicyId: selectedRemoteWorkPolicyId,
          onSystemChanged: onWorkSystemChanged,
          onPolicyChanged: onRemoteWorkPolicyChanged,
        ),
        hSpace(10),
        BlocBuilder<AdminEmployeesCubit, AdminEmployeesState>(
          builder: (context, state) {
            final employees = state.maybeWhen(
              success: (emps, roleFilter) => emps,
              actionSuccess: (message, emps, roleFilter) => emps,
              orElse: () => const <EmployeeModel>[],
            );
            return DropdownButtonFormField<String>(
              isExpanded: true,
              initialValue:
                  employees.any((e) => e.id == selectedDirectManagerId)
                  ? selectedDirectManagerId
                  : null,
              decoration: InputDecoration(
                labelText: 'employee.profile.directManager'.tr(
                  context: context,
                ),
                prefixIcon: const Icon(
                  Icons.supervisor_account_outlined,
                  color: AppColors.brandPrimary,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 12.w,
                  vertical: 12.h,
                ),
              ),
              items: [
                DropdownMenuItem<String>(
                  value: null,
                  child: Text(
                    'employee.profile.noManager'.tr(context: context),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                ...employees.map(
                  (e) => DropdownMenuItem<String>(
                    value: e.id,
                    child: Text(
                      e.name ?? e.userName ?? '-',
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
              onChanged: onManagerChanged,
            );
          },
        ),
      ],
    );
  }
}
