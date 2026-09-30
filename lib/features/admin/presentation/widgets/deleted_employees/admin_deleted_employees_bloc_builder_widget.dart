import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/admin/data/models/employee/employee_model.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/deleted_employees/admin_deleted_employees_cubit.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/deleted_employees/admin_deleted_employees_state.dart';
import 'package:check_point_v2/features/admin/presentation/widgets/admin_requests_empty_state_widget.dart';
import 'admin_deleted_employee_card_widget.dart';

class AdminDeletedEmployeesBlocBuilderWidget extends StatelessWidget {
  const AdminDeletedEmployeesBlocBuilderWidget({super.key});

  void _showRestoreDialog(BuildContext context, String id, String name) {
    showDialog<void>(
      context: context,
      builder: (dialogCtx) => CustomDialogWidget(
        title: 'admin.deletedEmployees.restoreTitle'.tr(context: context),
        message: 'admin.deletedEmployees.restoreMessage'.tr(
          args: [name],
          context: context,
        ),
        icon: Icons.restore_rounded,
        iconColor: AppColors.success,
        iconBackgroundColor: AppColors.softGreenBackground,
        confirmLabel: 'admin.deletedEmployees.restore'.tr(context: context),
        cancelLabel: 'common.cancel'.tr(context: context),
        confirmButtonColor: AppColors.success,
        onConfirm: () {
          Navigator.pop(dialogCtx);
          context.read<AdminDeletedEmployeesCubit>().restore(id);
        },
      ),
    );
  }

  void _showPermanentDeleteDialog(BuildContext context, String id, String name) {
    showDialog<void>(
      context: context,
      builder: (dialogCtx) => CustomDialogWidget(
        title:
            'admin.deletedEmployees.permanentDeleteTitle'.tr(context: context),
        message: 'admin.deletedEmployees.permanentDeleteMessage'.tr(
          args: [name],
          context: context,
        ),
        icon: Icons.delete_forever_rounded,
        iconColor: AppColors.error,
        iconBackgroundColor: AppColors.softRedBackground,
        confirmLabel:
            'admin.deletedEmployees.permanentDelete'.tr(context: context),
        cancelLabel: 'common.cancel'.tr(context: context),
        confirmButtonColor: AppColors.error,
        onConfirm: () {
          Navigator.pop(dialogCtx);
          context.read<AdminDeletedEmployeesCubit>().permanentDelete(id);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<AdminDeletedEmployeesCubit, AdminDeletedEmployeesState>(
        builder: (context, state) => switch (state) {
          AdminDeletedEmployeesStateInitial() => const SizedBox.shrink(),
          AdminDeletedEmployeesStateLoading() =>
            const Center(child: CircularProgressIndicator()),
          AdminDeletedEmployeesStateError(:final messageKey) =>
            context.read<AdminDeletedEmployeesCubit>().deletedEmployees.isNotEmpty
                ? _buildList(
                    context,
                    context.read<AdminDeletedEmployeesCubit>().deletedEmployees,
                  )
                : AdminRequestsEmptyStateWidget(messageKey: messageKey),
          AdminDeletedEmployeesStateSuccess(:final employees) ||
          AdminDeletedEmployeesStateActionSuccess(:final employees) =>
            employees.isEmpty
                ? const AdminRequestsEmptyStateWidget(
                    messageKey: 'admin.deletedEmployees.empty',
                  )
                : _buildList(context, employees),
          _ => const SizedBox.shrink(),
        },
      );

  Widget _buildList(BuildContext context, List<EmployeeModel> employees) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: employees.length,
      separatorBuilder: (_, _) => hSpace(10),
      itemBuilder: (_, i) {
        final emp = employees[i];
        return AdminDeletedEmployeeCardWidget(
          employee: emp,
          onRestore: () => _showRestoreDialog(
            context,
            emp.id!,
            emp.name ?? '-',
          ),
          onPermanentDelete: () => _showPermanentDeleteDialog(
            context,
            emp.id!,
            emp.name ?? '-',
          ),
        );
      },
    );
  }
}
