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
import '../admin_employee_profile_info_card_widget.dart';

class AdminEmployeeEditJobCardWidget extends StatelessWidget {
  const AdminEmployeeEditJobCardWidget({
    required this.positionController,
    required this.employeeCodeController,
    required this.gradeController,
    required this.divisionController,
    required this.contractTypeController,
    required this.contractStatusController,
    required this.selectedDepartmentId,
    required this.selectedBranchId,
    required this.selectedWorkSystem,
    required this.selectedDirectManagerId,
    required this.joinDate,
    required this.contractEndDate,
    required this.onDepartmentChanged,
    required this.onBranchChanged,
    required this.onWorkSystemChanged,
    required this.onManagerChanged,
    required this.onSelectJoinDate,
    required this.onSelectContractEndDate,
    super.key,
  });

  final TextEditingController positionController;
  final TextEditingController employeeCodeController;
  final TextEditingController gradeController;
  final TextEditingController divisionController;
  final TextEditingController contractTypeController;
  final TextEditingController contractStatusController;
  final int? selectedDepartmentId;
  final int? selectedBranchId;
  final String selectedWorkSystem;
  final String? selectedDirectManagerId;
  final DateTime? joinDate;
  final DateTime? contractEndDate;
  final ValueChanged<int?> onDepartmentChanged;
  final ValueChanged<int?> onBranchChanged;
  final ValueChanged<String> onWorkSystemChanged;
  final ValueChanged<String?> onManagerChanged;
  final VoidCallback onSelectJoinDate;
  final VoidCallback onSelectContractEndDate;

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('yyyy-MM-dd');
    return AdminEmployeeProfileInfoCardWidget(
      title: 'employee.profile.sectionJob'.tr(context: context),
      icon: Icons.work_outline_rounded,
      children: [
        CustomTextFormField(
          controller: positionController,
          hintText: 'employee.profile.position'.tr(context: context),
          prefixIcon: const Icon(Icons.badge_outlined, color: AppColors.brandPrimary),
        ),
        hSpace(10),
        CustomTextFormField(
          controller: employeeCodeController,
          hintText: 'employee.profile.code'.tr(context: context),
          prefixIcon: const Icon(Icons.tag_rounded, color: AppColors.brandPrimary),
        ),
        hSpace(10),
        CustomTextFormField(
          controller: gradeController,
          hintText: 'employee.profile.grade'.tr(context: context),
          prefixIcon: const Icon(Icons.military_tech_outlined, color: AppColors.brandPrimary),
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
                .map((d) => DropdownMenuItem<int>(value: d.id!, child: Text(d.departmentName ?? '-')))
                .toList();
            return DropdownButtonFormField<int>(
              isExpanded: true,
              value: departments.any((d) => d.id == selectedDepartmentId)
                  ? selectedDepartmentId
                  : null,
              decoration: InputDecoration(
                labelText: 'employee.profile.department'.tr(context: context),
                prefixIcon: const Icon(Icons.business_outlined, color: AppColors.brandPrimary),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r)),
                contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
              ),
              items: items,
              onChanged: onDepartmentChanged,
            );
          },
        ),
        hSpace(10),
        CustomTextFormField(
          controller: divisionController,
          hintText: 'employee.profile.division'.tr(context: context),
          prefixIcon: const Icon(Icons.hub_outlined, color: AppColors.brandPrimary),
        ),
        hSpace(10),
        BlocBuilder<AdminBranchesCubit, AdminBranchesState>(
          builder: (context, state) {
            final branches = state.maybeWhen(
              success: (brs) => brs,
              orElse: () => const <BranchModel>[],
            );
            final items = branches
                .where((b) => b.id != null)
                .map((b) => DropdownMenuItem<int>(value: b.id!, child: Text(b.name ?? '-', overflow: TextOverflow.ellipsis)))
                .toList();
            return DropdownButtonFormField<int>(
              isExpanded: true,
              value: branches.any((b) => b.id == selectedBranchId) ? selectedBranchId : null,
              decoration: InputDecoration(
                labelText: 'employee.profile.branch'.tr(context: context),
                prefixIcon: const Icon(Icons.location_on_outlined, color: AppColors.brandPrimary),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r)),
                contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
              ),
              items: items,
              onChanged: onBranchChanged,
            );
          },
        ),
        hSpace(10),
        DropdownButtonFormField<String>(
          isExpanded: true,
          value: selectedWorkSystem,
          decoration: InputDecoration(
            labelText: 'employee.profile.workSystem'.tr(context: context),
            prefixIcon: const Icon(Icons.devices_other_rounded, color: AppColors.brandPrimary),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r)),
            contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
          ),
          items: const [
            DropdownMenuItem(value: 'onsite', child: Text('Onsite (حضوري)', overflow: TextOverflow.ellipsis)),
            DropdownMenuItem(value: 'remote', child: Text('Remote (عن بعد)', overflow: TextOverflow.ellipsis)),
            DropdownMenuItem(value: 'hybrid', child: Text('Hybrid (هجين)', overflow: TextOverflow.ellipsis)),
          ],
          onChanged: (val) {
            if (val != null) onWorkSystemChanged(val);
          },
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
              value: employees.any((e) => e.id == selectedDirectManagerId)
                  ? selectedDirectManagerId
                  : null,
              decoration: InputDecoration(
                labelText: 'employee.profile.directManager'.tr(context: context),
                prefixIcon: const Icon(Icons.supervisor_account_outlined, color: AppColors.brandPrimary),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r)),
                contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
              ),
              items: [
                DropdownMenuItem<String>(
                  value: null,
                  child: Text('employee.profile.noManager'.tr(context: context), overflow: TextOverflow.ellipsis),
                ),
                ...employees.map(
                  (e) => DropdownMenuItem<String>(
                    value: e.id,
                    child: Text(e.name ?? e.userName ?? '-', overflow: TextOverflow.ellipsis),
                  ),
                ),
              ],
              onChanged: onManagerChanged,
            );
          },
        ),
        hSpace(10),
        CustomTextFormField(
          controller: contractTypeController,
          hintText: 'employee.profile.contractType'.tr(context: context),
          prefixIcon: const Icon(Icons.description_outlined, color: AppColors.brandPrimary),
        ),
        hSpace(10),
        CustomTextFormField(
          controller: contractStatusController,
          hintText: 'Status (نشط / فترة تجربة / موقوف)',
          prefixIcon: const Icon(Icons.verified_user_outlined, color: AppColors.brandPrimary),
        ),
        hSpace(10),
        Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: onSelectJoinDate,
                borderRadius: BorderRadius.circular(10.r),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.border),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'employee.profile.joinDate'.tr(context: context),
                        style: AppTextStyles.font11Regular,
                      ),
                      hSpace(2),
                      Text(
                        joinDate != null ? dateFormat.format(joinDate!) : '-',
                        style: AppTextStyles.font14Regular.copyWith(fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            wSpace(10),
            Expanded(
              child: InkWell(
                onTap: onSelectContractEndDate,
                borderRadius: BorderRadius.circular(10.r),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.border),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'employee.profile.contractEndDate'.tr(context: context),
                        style: AppTextStyles.font11Regular,
                      ),
                      hSpace(2),
                      Text(
                        contractEndDate != null ? dateFormat.format(contractEndDate!) : '-',
                        style: AppTextStyles.font14Regular.copyWith(fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
