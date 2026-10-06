import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/core/widgets/app_multi_select_dropdown_widget.dart';
import 'package:check_point_v2/features/admin/data/models/tasks/admin_task_model.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/employee/admin_employees_cubit.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/employee/admin_employees_state.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/tasks/admin_tasks_cubit.dart';
import 'package:check_point_v2/features/supervisor/presentation/widgets/supervisor_create_task_field_widget.dart';

class AdminEditTaskSheetWidget extends StatefulWidget {
  const AdminEditTaskSheetWidget({required this.task, super.key});

  final AdminTaskModel task;

  @override
  State<AdminEditTaskSheetWidget> createState() =>
      _AdminEditTaskSheetWidgetState();
}

class _AdminEditTaskSheetWidgetState extends State<AdminEditTaskSheetWidget> {
  late final TextEditingController titleController;
  late final TextEditingController descriptionController;
  late final TextEditingController dueDateController;
  late String selectedPriority;
  late String selectedStatus;
  Set<String> selectedEmployeeIds = {};
  bool isSubmitting = false;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.task.title ?? '');
    descriptionController = TextEditingController(
      text: widget.task.description ?? '',
    );
    dueDateController = TextEditingController();
    selectedPriority = 'Medium';
    selectedStatus = switch (widget.task.status) {
      'In Progress' => 'InProgress',
      'Pending' ||
      'InProgress' ||
      'Completed' ||
      'Cancelled' ||
      'Overdue' => widget.task.status!,
      _ => 'Pending',
    };
    if (widget.task.assignedEmployeeId != null &&
        widget.task.assignedEmployeeId!.isNotEmpty) {
      selectedEmployeeIds = widget.task.assignedEmployeeId!
          .split(',')
          .map((e) => e.trim())
          .toSet();
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    dueDateController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final title = titleController.text.trim();
    if (title.isEmpty) {
      CustomSnackBar.showError(
        context,
        message: 'supervisor.tasks.create.titleRequired'.tr(),
      );
      return;
    }

    if (widget.task.id == null) return;

    setState(() => isSubmitting = true);
    final tasksCubit = context.read<AdminTasksCubit>();

    final success = await tasksCubit.editTask(
      widget.task.id!,
      AddTaskRequestBody(
        title: title,
        description: descriptionController.text.trim(),
        assignedEmployeeId: selectedEmployeeIds.isNotEmpty
            ? selectedEmployeeIds.first
            : null,
        dueDate: dueDateController.text.trim().isNotEmpty
            ? dueDateController.text.trim()
            : null,
        priorityStatus: selectedPriority,
        status: selectedStatus,
      ),
    );

    if (!mounted) return;
    setState(() => isSubmitting = false);

    if (success) {
      Navigator.pop(context);
      CustomSnackBar.showSuccess(
        context,
        message: 'supervisor.tasks.edit.success'.tr(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.fromLTRB(20.w, 18.h, 20.w, 16.h),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'supervisor.tasks.edit.title'.tr(context: context),
                    style: AppTextStyles.font18Bold,
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(Icons.close_rounded, size: 20.r),
                  ),
                ],
              ),
              const Divider(color: AppColors.border),
              hSpace(14),
              SupervisorCreateTaskFieldWidget(
                labelKey: 'supervisor.tasks.create.titleLabel',
                hintKey: 'supervisor.tasks.create.titleHint',
                controller: titleController,
              ),
              hSpace(16),
              SupervisorCreateTaskFieldWidget(
                labelKey: 'supervisor.tasks.create.descriptionLabel',
                hintKey: 'supervisor.tasks.create.descriptionHint',
                controller: descriptionController,
                maxLines: 3,
              ),
              hSpace(16),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'supervisor.tasks.create.statusLabel'.tr(
                            context: context,
                          ),
                          style: AppTextStyles.font12Medium,
                        ),
                        hSpace(8),
                        DropdownButtonFormField<String>(
                          key: ValueKey(selectedStatus),
                          initialValue: selectedStatus,
                          decoration: InputDecoration(
                            hintText: 'supervisor.tasks.create.statusLabel'.tr(
                              context: context,
                            ),
                          ),
                          items: [
                            DropdownMenuItem(
                              value: 'Pending',
                              child: Text(
                                'supervisor.tasks.status.pending'.tr(
                                  context: context,
                                ),
                              ),
                            ),
                            DropdownMenuItem(
                              value: 'InProgress',
                              child: Text(
                                'supervisor.tasks.status.inProgress'.tr(
                                  context: context,
                                ),
                              ),
                            ),
                            DropdownMenuItem(
                              value: 'Completed',
                              child: Text(
                                'supervisor.tasks.status.completed'.tr(
                                  context: context,
                                ),
                              ),
                            ),
                          ],
                          onChanged: (value) => setState(() {
                            selectedStatus = value ?? selectedStatus;
                          }),
                        ),
                      ],
                    ),
                  ),
                  vSpace(12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'supervisor.tasks.create.priorityLabel'.tr(
                            context: context,
                          ),
                          style: AppTextStyles.font12Medium,
                        ),
                        hSpace(8),
                        DropdownButtonFormField<String>(
                          key: ValueKey(selectedPriority),
                          initialValue: selectedPriority,
                          decoration: InputDecoration(
                            hintText: 'supervisor.tasks.priority.medium'.tr(
                              context: context,
                            ),
                          ),
                          items: [
                            for (final priority in const [
                              'Low',
                              'Medium',
                              'High',
                              'Critical',
                            ])
                              DropdownMenuItem(
                                value: priority,
                                child: Text(
                                  'supervisor.tasks.priority.${priority.toLowerCase()}'
                                      .tr(context: context),
                                ),
                              ),
                          ],
                          onChanged: (value) => setState(() {
                            selectedPriority = value ?? selectedPriority;
                          }),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              hSpace(16),
              BlocBuilder<AdminEmployeesCubit, AdminEmployeesState>(
                builder: (context, state) {
                  final employees = switch (state) {
                    AdminEmployeesStateSuccess(:final employees) => employees,
                    _ => const [],
                  };
                  final items = employees
                      .where((e) => e.id != null)
                      .map(
                        (e) => AppMultiSelectItem<String>(
                          id: e.id!,
                          label: e.name ?? e.userName ?? 'Employee',
                        ),
                      )
                      .toList();
                  return AppMultiSelectDropdownWidget<String>(
                    label: 'supervisor.tasks.create.assignToLabel'.tr(
                      context: context,
                    ),
                    hint: 'supervisor.tasks.create.selectEmployeesHint'.tr(
                      context: context,
                    ),
                    items: items,
                    selectedIds: selectedEmployeeIds,
                    onSelectionChanged: (newSelected) =>
                        setState(() => selectedEmployeeIds = newSelected),
                  );
                },
              ),
              hSpace(20),
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      text: 'supervisor.tasks.create.cancel'.tr(
                        context: context,
                      ),
                      onTap: () => Navigator.pop(context),
                      backgroundColor: AppColors.pageBackground,
                      textColor: AppColors.textPrimary,
                    ),
                  ),
                  vSpace(12),
                  Expanded(
                    child: CustomButton(
                      text: 'supervisor.tasks.edit.save'.tr(context: context),
                      isLoading: isSubmitting,
                      onTap: _submit,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
