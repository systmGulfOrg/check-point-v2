import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/core/di/service_locator.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/employee/admin_department_employees_cubit.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/locations/admin_departments_cubit.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/locations/admin_departments_state.dart';
import 'admin_create_department_sheet_widget.dart';
import 'admin_delete_confirmation_dialog_widget.dart';
import 'admin_department_card_widget.dart';
import 'admin_department_employees_sheet_widget.dart';
import 'admin_locations_skeleton_widget.dart';

class AdminDepartmentsBlocBuilderWidget extends StatelessWidget {
  const AdminDepartmentsBlocBuilderWidget({super.key});

  void _showEmployeesSheet(
    BuildContext context,
    int departmentId,
    String departmentName,
  ) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (_) => BlocProvider<AdminDepartmentEmployeesCubit>(
        create: (_) => sl<AdminDepartmentEmployeesCubit>()..load(departmentId),
        child: AdminDepartmentEmployeesSheetWidget(
          departmentId: departmentId,
          departmentName: departmentName,
        ),
      ),
    );
  }

  void _showEditSheet(
    BuildContext context,
    int departmentId,
    String departmentName,
  ) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (_) => BlocProvider.value(
        value: context.read<AdminDepartmentsCubit>(),
        child: AdminCreateDepartmentSheetWidget(
          departmentId: departmentId,
          initialName: departmentName,
        ),
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, int departmentId) {
    showDialog<void>(
      context: context,
      builder: (dialogContext) => AdminDeleteConfirmationDialogWidget(
        title: 'admin.departments.delete'.tr(context: context),
        message: 'admin.departments.deleteMessage'.tr(context: context),
        onConfirm: () {
          Navigator.pop(dialogContext);
          context.read<AdminDepartmentsCubit>().deleteDepartment(departmentId);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<AdminDepartmentsCubit, AdminDepartmentsState>(
        builder: (context, state) => switch (state) {
          AdminDepartmentsInitial() ||
          AdminDepartmentsLoading() => const AdminLocationsSkeletonWidget(),
          AdminDepartmentsError(:final messageKey) => Padding(
            padding: EdgeInsets.all(24.r),
            child: Text(
              messageKey.tr(context: context),
              style: AppTextStyles.font14Regular.copyWith(
                color: AppColors.error,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          AdminDepartmentsSuccess(:final departments) =>
            departments.isEmpty
                ? Padding(
                    padding: EdgeInsets.all(24.r),
                    child: Center(
                      child: Text(
                        'admin.departments.empty'.tr(context: context),
                        style: AppTextStyles.font14Regular.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ),
                  )
                : Column(
                    children: [
                      for (final dept in departments) ...[
                        AdminDepartmentCardWidget(
                          department: dept,
                          onViewEmployees: () {
                            if (dept.id != null) {
                              _showEmployeesSheet(
                                context,
                                dept.id!,
                                dept.departmentName ?? '',
                              );
                            }
                          },
                          onEdit: () {
                            if (dept.id != null) {
                              _showEditSheet(
                                context,
                                dept.id!,
                                dept.departmentName ?? '',
                              );
                            }
                          },
                          onDelete: () {
                            if (dept.id != null) {
                              _showDeleteDialog(context, dept.id!);
                            }
                          },
                        ),
                        hSpace(10),
                      ],
                    ],
                  ),
          _ => const SizedBox.shrink(),
        },
      );
}
