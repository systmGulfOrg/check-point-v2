import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/core/di/service_locator.dart';
import 'package:check_point_v2/features/admin/data/models/employee/employee_model.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/employee/admin_employees_cubit.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/employee_profile/admin_employee_profile_cubit.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/locations/admin_branches_cubit.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/locations/admin_departments_cubit.dart';
import 'package:check_point_v2/features/admin/presentation/widgets/admin_edit_employee_sheet_widget.dart';
import 'package:check_point_v2/features/admin/presentation/widgets/employee_profile/admin_employee_profile_bloc_builder_widget.dart';
import 'package:check_point_v2/features/auth/presentation/cubit/profile/auth_profile_cubit.dart';
import 'package:check_point_v2/features/remote_work/presentation/cubit/remote_work_cubit.dart';

class AdminEmployeeProfileScreen extends StatelessWidget {
  const AdminEmployeeProfileScreen({
    required this.employee,
    super.key,
  });

  final EmployeeModel employee;

  void _showEditSheet(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.cardBackground,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (_) => MultiBlocProvider(
        providers: [
          BlocProvider<AdminEmployeesCubit>(
            create: (_) => sl<AdminEmployeesCubit>()..loadEmployees(),
          ),
          BlocProvider<AdminDepartmentsCubit>(
            create: (_) => sl<AdminDepartmentsCubit>()..load(),
          ),
          BlocProvider<AdminBranchesCubit>(
            create: (_) => sl<AdminBranchesCubit>()..load(),
          ),
          BlocProvider<RemoteWorkCubit>(
            create: (_) => sl<RemoteWorkCubit>()..load(),
          ),
        ],
        child: AdminEditEmployeeSheetWidget(
          employee: employee,
          onSave: (body) async {
            if (employee.id != null) {
              final cubit = sl<AdminEmployeesCubit>();
              await cubit.editEmployee(employee.id!, body);
              if (context.mounted) {
                context
                    .read<AdminEmployeeProfileCubit>()
                    .load(employee.id!, initialEmployee: employee);
              }
            }
          },
        ),
      ),
    );
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

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: Text(
          'employee.profile.title'.tr(context: context),
          style: AppTextStyles.font18Bold.copyWith(
            color: AppColors.textPrimary,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          color: AppColors.textPrimary,
        ),
        actions: [
          if (canEdit)
            IconButton(
              onPressed: () => _showEditSheet(context),
              icon: const Icon(Icons.edit_outlined),
              color: AppColors.brandPrimary,
              tooltip: 'employee.profile.edit'.tr(context: context),
            ),
          IconButton(
            onPressed: () {
              if (employee.id != null) {
                context
                    .read<AdminEmployeeProfileCubit>()
                    .load(employee.id!, initialEmployee: employee);
              }
            },
            icon: const Icon(Icons.refresh_rounded),
            color: AppColors.textPrimary,
            tooltip: 'core.actions.refresh'.tr(context: context),
          ),
        ],
      ),
      body: const SafeArea(
        child: AdminEmployeeProfileBlocBuilderWidget(),
      ),
    );
  }
}
