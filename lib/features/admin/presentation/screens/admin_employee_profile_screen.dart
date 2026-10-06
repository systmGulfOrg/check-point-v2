import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/core/di/service_locator.dart';
import 'package:check_point_v2/features/admin/data/models/employee/edit_employee_request_body.dart';
import 'package:check_point_v2/features/admin/data/models/employee/employee_model.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/employee/admin_employees_cubit.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/employee_profile/admin_employee_profile_cubit.dart';
import 'package:check_point_v2/features/admin/presentation/widgets/employee_profile/admin_employee_profile_bloc_builder_widget.dart';
import 'package:check_point_v2/features/admin/presentation/widgets/employee_profile/edit/admin_employee_profile_edit_form_widget.dart';
import 'package:check_point_v2/features/auth/presentation/cubit/profile/auth_profile_cubit.dart';

class AdminEmployeeProfileScreen extends StatefulWidget {
  const AdminEmployeeProfileScreen({required this.employee, super.key});

  final EmployeeModel employee;

  @override
  State<AdminEmployeeProfileScreen> createState() =>
      _AdminEmployeeProfileScreenState();
}

class _AdminEmployeeProfileScreenState
    extends State<AdminEmployeeProfileScreen> {
  bool _isEditing = false;

  EmployeeModel _resolveCurrentEmployee() {
    final state = context.read<AdminEmployeeProfileCubit>().state;
    return state.maybeWhen(
      success:
          (
            emp,
            attendance,
            selectedMonth,
            attendedDays,
            absentDays,
            lateDays,
            earlyLeaveDays,
            totalHours,
            devicesHistory,
            leaveRequests,
            leaveBalances,
            permissions,
          ) => emp,
      orElse: () => widget.employee,
    );
  }

  Future<void> _handleSave(EditEmployeeRequestBody body) async {
    final currentEmp = _resolveCurrentEmployee();
    final empId = currentEmp.id ?? widget.employee.id;
    if (empId == null) return;

    final cubit = sl<AdminEmployeesCubit>();
    final error = await cubit.editEmployee(empId, body);
    if (!mounted) return;

    if (error == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Employee updated successfully'),
          backgroundColor: AppColors.success,
        ),
      );
      context.read<AdminEmployeeProfileCubit>().load(
        empId,
        initialEmployee: currentEmp,
      );
      setState(() => _isEditing = false);
    } else {
      CustomSnackBar.showError(context, message: error.tr(context: context));
    }
  }

  @override
  Widget build(BuildContext context) {
    final canEdit = context.select<AuthProfileCubit, bool>(
      (cubit) => cubit.state.maybeWhen(
        success: (name, userId, role, username, permissions) =>
            AppPermissions.has(permissions, AppPermissions.employeeEdit),
        orElse: () => true,
      ),
    );

    final currentEmp = _resolveCurrentEmployee();

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: Text(
          (_isEditing ? 'employee.profile.edit' : 'employee.profile.title').tr(
            context: context,
          ),
          style: AppTextStyles.font18Bold.copyWith(
            color: AppColors.textPrimary,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            if (_isEditing) {
              setState(() => _isEditing = false);
            } else {
              Navigator.of(context).pop();
            }
          },
          icon: Icon(
            _isEditing ? Icons.close_rounded : Icons.arrow_back_ios_new_rounded,
          ),
          color: AppColors.textPrimary,
        ),
        actions: [
          if (!_isEditing && canEdit)
            IconButton(
              onPressed: () => setState(() => _isEditing = true),
              icon: const Icon(Icons.edit_outlined),
              color: AppColors.brandPrimary,
              tooltip: 'employee.profile.edit'.tr(context: context),
            ),
          if (!_isEditing)
            IconButton(
              onPressed: () {
                final empId = currentEmp.id ?? widget.employee.id;
                if (empId != null) {
                  context.read<AdminEmployeeProfileCubit>().load(
                    empId,
                    initialEmployee: currentEmp,
                  );
                }
              },
              icon: const Icon(Icons.refresh_rounded),
              color: AppColors.textPrimary,
              tooltip: 'core.actions.refresh'.tr(context: context),
            ),
        ],
      ),
      body: SafeArea(
        child: _isEditing
            ? AdminEmployeeProfileEditFormWidget(
                employee: currentEmp,
                onSave: _handleSave,
                onCancel: () => setState(() => _isEditing = false),
              )
            : const AdminEmployeeProfileBlocBuilderWidget(),
      ),
    );
  }
}
