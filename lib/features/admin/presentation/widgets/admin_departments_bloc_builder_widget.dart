import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/core.dart';
import '../../data/models/department_request_model.dart';
import '../cubit/admin_departments_cubit.dart';
import '../cubit/admin_departments_state.dart';
import 'admin_location_card_widget.dart';
import 'admin_location_data.dart';

class AdminDepartmentsBlocBuilderWidget extends StatelessWidget {
  const AdminDepartmentsBlocBuilderWidget({super.key});

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
          AdminDepartmentsLoading() => const Center(
            child: CircularProgressIndicator(),
          ),
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
                              context
                                  .read<AdminDepartmentsCubit>()
                                  .deleteDepartment(dept.id!);
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
