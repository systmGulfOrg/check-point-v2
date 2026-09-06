import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/core.dart';
import '../../data/models/department_request_model.dart';
import '../cubit/admin_departments_cubit.dart';
import '../cubit/admin_departments_state.dart';
import 'admin_delete_confirmation_dialog_widget.dart';
import 'admin_location_card_widget.dart';
import 'admin_location_data.dart';
import 'admin_locations_skeleton_widget.dart';

class AdminDepartmentsBlocBuilderWidget extends StatelessWidget {
  const AdminDepartmentsBlocBuilderWidget({super.key});

  void _showDeleteDialog(BuildContext context, int departmentId) {
    showDialog<void>(
      context: context,
      builder: (dialogContext) => AdminDeleteConfirmationDialogWidget(
        title: 'admin.locations.delete'.tr(context: context),
        message: 'admin.employees.deleteEmployeeMessage'.tr(context: context),
        onConfirm: () {
          Navigator.pop(dialogContext);
          context.read<AdminDepartmentsCubit>().deleteDepartment(departmentId);
        },
      ),
    );
  }

  void _showEditDialog(BuildContext context, int id, String currentName) {
    final controller = TextEditingController(text: currentName);
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Edit Department'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(labelText: 'Department Name'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (controller.text.trim().isNotEmpty) {
                context.read<AdminDepartmentsCubit>().editDepartment(
                      id,
                      DepartmentRequestModel(departmentName: controller.text.trim()),
                    );
                Navigator.pop(dialogContext);
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<AdminDepartmentsCubit, AdminDepartmentsState>(
        builder: (context, state) => switch (state) {
          AdminDepartmentsInitial() => const SizedBox.shrink(),
          AdminDepartmentsLoading() =>
            const AdminLocationsSkeletonWidget(),
          AdminDepartmentsError(:final messageKey) => Padding(
            padding: const EdgeInsets.all(24),
            child: Text(
              messageKey.tr(context: context),
              style: AppTextStyles.font14Regular,
            ),
          ),
          AdminDepartmentsSuccess(:final departments) =>
            departments.isEmpty
                ? Padding(
                    padding: const EdgeInsets.all(24),
                    child: Text(
                      'admin.locations.empty'.tr(context: context),
                      style: AppTextStyles.font14Regular,
                    ),
                  )
                : Column(
                    children: [
                      for (final dept in departments) ...[
                        AdminLocationCardWidget(
                          location: AdminLocationData(
                            nameKey: dept.departmentName ?? '-',
                            descriptionKey: 'Department ID: ${dept.id ?? '-'}',
                            addressKey: 'Active Department',
                            statusKey: 'admin.locations.status.active',
                            icon: Icons.domain_outlined,
                            iconColor: AppColors.info,
                            iconBackgroundColor: AppColors.softBlueBackground,
                          ),
                          onEdit: () {
                            if (dept.id != null) {
                              _showEditDialog(
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
