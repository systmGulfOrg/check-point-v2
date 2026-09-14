import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/admin/data/models/employee/employee_model.dart';
import 'package:check_point_v2/features/employee/presentation/widgets/employee_details_sheet_widget.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/employee/admin_employees_cubit.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/employee/admin_employees_state.dart';
import 'package:check_point_v2/core/di/service_locator.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/locations/admin_branches_cubit.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/locations/admin_departments_cubit.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/shifts_policies/admin_shifts_policies_cubit.dart';
import 'admin_delete_confirmation_dialog_widget.dart';
import 'admin_edit_employee_sheet_widget.dart';
import 'admin_employee_card_widget.dart';
import 'admin_employees_skeleton_widget.dart';
import 'admin_requests_empty_state_widget.dart';

class AdminEmployeesBlocBuilderWidget extends StatelessWidget {
  const AdminEmployeesBlocBuilderWidget({super.key});

  void _showEditSheet(BuildContext context, EmployeeModel employee) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.cardBackground,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (_) => MultiBlocProvider(
        providers: [
          BlocProvider<AdminDepartmentsCubit>(
            create: (_) => sl<AdminDepartmentsCubit>()..load(),
          ),
          BlocProvider<AdminBranchesCubit>(
            create: (_) => sl<AdminBranchesCubit>()..load(),
          ),
          BlocProvider<AdminShiftsPoliciesCubit>(
            create: (_) => sl<AdminShiftsPoliciesCubit>()..load(),
          ),
        ],
        child: AdminEditEmployeeSheetWidget(
          employee: employee,
          onSave: (body) {
            if (employee.id != null) {
              context.read<AdminEmployeesCubit>().editEmployee(
                employee.id!,
                body,
              );
            }
          },
        ),
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, String employeeId) {
    showDialog<void>(
      context: context,
      builder: (dialogContext) => AdminDeleteConfirmationDialogWidget(
        title: 'admin.employees.deleteEmployeeTitle'.tr(context: context),
        message: 'admin.employees.deleteEmployeeMessage'.tr(context: context),
        onConfirm: () {
          Navigator.pop(dialogContext);
          context.read<AdminEmployeesCubit>().deleteEmployee(employeeId);
        },
      ),
    );
  }

  @override
  Widget build(
    BuildContext context,
  ) => BlocBuilder<AdminEmployeesCubit, AdminEmployeesState>(
    builder: (context, state) => switch (state) {
      AdminEmployeesStateInitial() => const SizedBox.shrink(),
      AdminEmployeesStateLoading() => const AdminEmployeesSkeletonWidget(),
      AdminEmployeesStateError(:final messageKey) =>
        AdminRequestsEmptyStateWidget(messageKey: messageKey),
      AdminEmployeesStateSuccess(:final employees) ||
      AdminEmployeesStateActionSuccess(:final employees) =>
        employees.isEmpty
            ? AdminRequestsEmptyStateWidget(messageKey: 'admin.employees.empty')
            : Column(
                children: [
                  Text(
                    'admin.employees.countHeader'.tr(
                      context: context,
                      args: [employees.length.toString()],
                    ),
                    style: AppTextStyles.font13Regular.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  hSpace(12),
                  for (final employee in employees) ...[
                    AdminEmployeeCardWidget(
                      initials: _initials(employee.name),
                      name: employee.name ?? employee.userName ?? '-',
                      roles: employee.allRoles,
                      email: (employee.email != null && employee.email!.isNotEmpty)
                          ? employee.email!
                          : (employee.userName ?? '-'),
                      empCode: employee.employeeCode ?? employee.id ?? '-',
                      department: employee.departmentName,
                      isOnline: employee.canAddAttendance ?? false,
                      onEdit: () => _showEditSheet(context, employee),
                      onDelete: () {
                        if (employee.id != null) {
                          _showDeleteDialog(context, employee.id!);
                        }
                      },
                      onTap: () =>
                          EmployeeDetailsSheetWidget.show(context, employee),
                    ),
                    hSpace(10),
                  ],
                ],
              ),
      _ => const SizedBox.shrink(),
    },
  );

  static String _initials(String? name) {
    final parts = (name ?? '').trim().split(RegExp(r'\s+'));
    final initials = parts
        .where((part) => part.isNotEmpty)
        .take(2)
        .map((part) => part[0].toUpperCase())
        .join();
    return initials.isEmpty ? '?' : initials;
  }
}
