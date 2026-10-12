import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/admin/data/models/employee/employee_model.dart';
import 'package:check_point_v2/features/admin/data/models/locations/department_response_model.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/attendance/admin_attendance_cubit.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/employee/admin_employees_cubit.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/employee/admin_employees_state.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/locations/admin_departments_cubit.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/locations/admin_departments_state.dart';
import 'package:check_point_v2/features/admin/presentation/widgets/admin_attendance_contractor_filter_widget.dart';
import 'package:check_point_v2/features/admin/presentation/widgets/admin_attendance_site_filter_widget.dart';

class AdminAttendanceAdvancedFilterWidget extends StatelessWidget {
  const AdminAttendanceAdvancedFilterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final attendanceCubit = context.watch<AdminAttendanceCubit>();
    final employees = switch (context.watch<AdminEmployeesCubit>().state) {
      AdminEmployeesStateSuccess(:final employees) => employees,
      AdminEmployeesStateActionSuccess(:final employees) => employees,
      _ => const <EmployeeModel>[],
    };
    final departments = switch (context.watch<AdminDepartmentsCubit>().state) {
      AdminDepartmentsSuccess(:final departments) => departments,
      _ => const <DepartmentModel>[],
    };
    final isContractorSelected = attendanceCubit.selectedContractorId != null;
    final targetEmployees = isContractorSelected
        ? employees
            .where((e) => e.contractorId == attendanceCubit.selectedContractorId)
            .toList()
        : employees;
    final activeFilters = [
      if (attendanceCubit.selectedSiteId != null) 1,
      if (attendanceCubit.selectedContractorId != null) 1,
      if (attendanceCubit.selectedEmployeeId != null) 1,
      if (attendanceCubit.selectedDepartmentId != null) 1,
      if (attendanceCubit.selectedStatus != 'all') 1,
    ].length;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: AppColors.border),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          tilePadding: EdgeInsets.symmetric(horizontal: 14.w),
          childrenPadding: EdgeInsets.fromLTRB(14.w, 0, 14.w, 14.h),
          leading: Container(
            padding: EdgeInsets.all(8.r),
            decoration: BoxDecoration(
              color: AppColors.softBrandBackground,
              borderRadius: BorderRadius.circular(9.r),
            ),
            child: Icon(
              Icons.tune_rounded,
              size: 18.r,
              color: AppColors.brandPrimary,
            ),
          ),
          title: Text(
            'admin.attendance.advancedFilters'.tr(context: context),
            style: AppTextStyles.font13SemiBold,
          ),
          subtitle: Text(
            activeFilters == 0
                ? 'admin.attendance.noAdvancedFilters'.tr(context: context)
                : 'admin.attendance.activeFilters'.tr(
                    context: context,
                    args: ['$activeFilters'],
                  ),
            style: AppTextStyles.font11Regular,
          ),
          children: [
            const AdminAttendanceSiteFilterWidget(),
            hSpace(10),
            const AdminAttendanceContractorFilterWidget(),
            hSpace(10),
            InkWell(
              borderRadius: BorderRadius.circular(12.r),
              onTap: () {
                final controller = TextEditingController();
                showModalBottomSheet<void>(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: AppColors.cardBackground,
                  builder: (sheetContext) => StatefulBuilder(
                    builder: (sheetContext, setSheetState) {
                      final query = controller.text.trim().toLowerCase();
                      final filtered = targetEmployees.where((employee) {
                        final name =
                            '${employee.name ?? ''} ${employee.userName ?? ''}'
                                .toLowerCase();
                        return name.contains(query);
                      }).toList();
                      return SafeArea(
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(
                            16.w,
                            12.h,
                            16.w,
                            MediaQuery.viewInsetsOf(sheetContext).bottom + 16.h,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                (isContractorSelected
                                        ? 'admin.attendance.contractorWorkers'
                                        : 'admin.attendance.employee')
                                    .tr(context: context),
                                style: AppTextStyles.font16Bold,
                              ),
                              hSpace(10),
                              CustomTextFormField(
                                controller: controller,
                                hintText: 'admin.attendance.searchEmployee'.tr(
                                  context: context,
                                ),
                                prefixIcon: Icon(
                                  Icons.search_rounded,
                                  size: 19.r,
                                ),
                                onChanged: (_) => setSheetState(() {}),
                              ),
                              hSpace(8),
                              Flexible(
                                child: ListView(
                                  shrinkWrap: true,
                                  children: [
                                    ListTile(
                                      leading: const CircleAvatar(
                                        backgroundColor:
                                            AppColors.softBrandBackground,
                                        child: Icon(
                                          Icons.groups_rounded,
                                          color: AppColors.brandPrimary,
                                        ),
                                      ),
                                      title: Text(
                                        (isContractorSelected
                                                ? 'admin.attendance.allContractorWorkers'
                                                : 'admin.attendance.allEmployees')
                                            .tr(context: context),
                                      ),
                                      onTap: () {
                                        attendanceCubit.setEmployeeFilter(null);
                                        Navigator.pop(sheetContext);
                                      },
                                    ),
                                    for (final employee in filtered)
                                      if (employee.id != null)
                                        ListTile(
                                          leading: CircleAvatar(
                                            backgroundColor:
                                                AppColors.softGreenBackground,
                                            child: Text(
                                              (employee.name ??
                                                      employee.userName ??
                                                      'E')
                                                  .trim()[0]
                                                  .toUpperCase(),
                                            ),
                                          ),
                                          title: Text(
                                            employee.name ??
                                                employee.userName ??
                                                '-',
                                          ),
                                          subtitle:
                                              employee.departmentName == null
                                              ? null
                                              : Text(employee.departmentName!),
                                          onTap: () {
                                            attendanceCubit.setEmployeeFilter(
                                              employee.id,
                                            );
                                            Navigator.pop(sheetContext);
                                          },
                                        ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ).whenComplete(controller.dispose);
              },
              child: Padding(
                padding: EdgeInsets.only(top: 5.h),
                child: InputDecorator(
                  decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    labelText: (isContractorSelected
                            ? 'admin.attendance.contractorWorkers'
                            : 'admin.attendance.employee')
                        .tr(context: context),
                    labelStyle: AppTextStyles.font11Regular.copyWith(
                      color: AppColors.textSecondary,
                    ),
                    prefixIcon: Icon(Icons.person_outline_rounded, size: 18.r),
                    suffixIcon: Icon(
                      Icons.keyboard_arrow_down_rounded,
                      size: 20.r,
                    ),
                  ),
                  child: Text(
                    targetEmployees
                            .where(
                              (employee) =>
                                  employee.id ==
                                  attendanceCubit.selectedEmployeeId,
                            )
                            .map(
                              (employee) =>
                                  employee.name ?? employee.userName ?? '-',
                            )
                            .firstOrNull ??
                        (isContractorSelected
                                ? 'admin.attendance.allContractorWorkers'
                                : 'admin.attendance.allEmployees')
                            .tr(context: context),
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.font14Medium,
                  ),
                ),
              ),
            ),
            hSpace(10),
            InkWell(
              borderRadius: BorderRadius.circular(12.r),
              onTap: () {
                final controller = TextEditingController();
                showModalBottomSheet<void>(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: AppColors.cardBackground,
                  builder: (sheetContext) => StatefulBuilder(
                    builder: (sheetContext, setSheetState) {
                      final query = controller.text.trim().toLowerCase();
                      final filtered = departments
                          .where(
                            (department) => (department.departmentName ?? '')
                                .toLowerCase()
                                .contains(query),
                          )
                          .toList();
                      return SafeArea(
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(
                            16.w,
                            12.h,
                            16.w,
                            MediaQuery.viewInsetsOf(sheetContext).bottom + 16.h,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'admin.attendance.department'.tr(
                                  context: context,
                                ),
                                style: AppTextStyles.font16Bold,
                              ),
                              hSpace(10),
                              CustomTextFormField(
                                controller: controller,
                                hintText: 'admin.attendance.searchDepartment'
                                    .tr(context: context),
                                prefixIcon: Icon(
                                  Icons.search_rounded,
                                  size: 19.r,
                                ),
                                onChanged: (_) => setSheetState(() {}),
                              ),
                              hSpace(8),
                              Flexible(
                                child: ListView(
                                  shrinkWrap: true,
                                  children: [
                                    ListTile(
                                      leading: const CircleAvatar(
                                        backgroundColor:
                                            AppColors.softBrandBackground,
                                        child: Icon(
                                          Icons.apartment_rounded,
                                          color: AppColors.brandPrimary,
                                        ),
                                      ),
                                      title: Text(
                                        'admin.attendance.allDepartments'.tr(
                                          context: context,
                                        ),
                                      ),
                                      onTap: () {
                                        attendanceCubit.setDepartmentFilter(
                                          null,
                                        );
                                        Navigator.pop(sheetContext);
                                      },
                                    ),
                                    for (final department in filtered)
                                      if (department.id != null)
                                        ListTile(
                                          leading: Icon(
                                            Icons.apartment_outlined,
                                            color: AppColors.placeholder,
                                          ),
                                          title: Text(
                                            department.departmentName ?? '-',
                                          ),
                                          onTap: () {
                                            attendanceCubit.setDepartmentFilter(
                                              department.id,
                                            );
                                            Navigator.pop(sheetContext);
                                          },
                                        ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ).whenComplete(controller.dispose);
              },
              child: Padding(
                padding: EdgeInsets.only(top: 5.h),
                child: InputDecorator(
                  decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    labelText: 'admin.attendance.department'.tr(
                      context: context,
                    ),
                    labelStyle: AppTextStyles.font11Regular.copyWith(
                      color: AppColors.textSecondary,
                    ),
                    prefixIcon: Icon(Icons.apartment_outlined, size: 18.r),
                    suffixIcon: Icon(
                      Icons.keyboard_arrow_down_rounded,
                      size: 20.r,
                    ),
                  ),
                  child: Text(
                    departments
                            .where(
                              (department) =>
                                  department.id ==
                                  attendanceCubit.selectedDepartmentId,
                            )
                            .map(
                              (department) => department.departmentName ?? '-',
                            )
                            .firstOrNull ??
                        'admin.attendance.allDepartments'.tr(context: context),
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.font14Medium,
                  ),
                ),
              ),
            ),
            hSpace(12),
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: Text(
                'admin.attendance.statusLabel'.tr(context: context),
                style: AppTextStyles.font12Medium,
              ),
            ),
            hSpace(7),
            Wrap(
              spacing: 7.w,
              runSpacing: 7.h,
              children: [
                for (final status in const [
                  'all',
                  'onTime',
                  'late',
                  'absent',
                  'earlyCheckout',
                ])
                  ChoiceChip(
                    label: Text(
                      'admin.attendance.filters.$status'.tr(context: context),
                    ),
                    selected: attendanceCubit.selectedStatus == status,
                    onSelected: (_) => attendanceCubit.setStatusFilter(status),
                    selectedColor: AppColors.softBrandBackground,
                    backgroundColor: AppColors.pageBackground,
                    labelStyle: AppTextStyles.font11Medium.copyWith(
                      color: attendanceCubit.selectedStatus == status
                          ? AppColors.brandPrimary
                          : AppColors.textSecondary,
                    ),
                    side: BorderSide(
                      color: attendanceCubit.selectedStatus == status
                          ? AppColors.brandPrimary
                          : AppColors.border,
                    ),
                    showCheckmark: false,
                  ),
              ],
            ),
            if (activeFilters > 0)
              Align(
                alignment: AlignmentDirectional.centerEnd,
                child: TextButton.icon(
                  onPressed: attendanceCubit.clearAdvancedFilters,
                  icon: Icon(Icons.restart_alt_rounded, size: 16.r),
                  label: Text(
                    'admin.attendance.clearFilters'.tr(context: context),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
