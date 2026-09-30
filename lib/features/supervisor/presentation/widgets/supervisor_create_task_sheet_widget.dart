import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/admin/data/models/tasks/admin_task_model.dart';
import 'package:check_point_v2/features/supervisor/presentation/cubit/tasks/supervisor_tasks_cubit.dart';
import 'package:check_point_v2/features/supervisor/presentation/cubit/team/supervisor_team_cubit.dart';
import 'package:check_point_v2/features/supervisor/presentation/cubit/team/supervisor_team_state.dart';
import 'package:check_point_v2/core/widgets/app_multi_select_dropdown_widget.dart';
import 'supervisor_create_task_field_widget.dart';

class SupervisorCreateTaskSheetWidget extends StatefulWidget {
  const SupervisorCreateTaskSheetWidget({super.key});

  @override
  State<SupervisorCreateTaskSheetWidget> createState() =>
      _SupervisorCreateTaskSheetWidgetState();
}

class _SupervisorCreateTaskSheetWidgetState
    extends State<SupervisorCreateTaskSheetWidget> {
  late final TextEditingController titleController;
  late final TextEditingController descriptionController;
  late final TextEditingController dueDateController;
  String selectedPriority = 'Medium';
  Set<String> selectedEmployeeIds = {};
  bool isSubmitting = false;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController();
    descriptionController = TextEditingController();
    dueDateController = TextEditingController();
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

    setState(() => isSubmitting = true);
    final tasksCubit = context.read<SupervisorTasksCubit>();

    final success = await tasksCubit.addTask(
      AddTaskRequestBody(
        title: title,
        description: descriptionController.text.trim(),
        dueDate: dueDateController.text.trim().isNotEmpty
            ? dueDateController.text.trim()
            : null,
        assignedEmployeeId: selectedEmployeeIds.isNotEmpty
            ? selectedEmployeeIds.first
            : null,
        priorityStatus: selectedPriority,
        status: 'Pending',
      ),
    );

    if (!mounted) return;
    setState(() => isSubmitting = false);

    if (success) {
      Navigator.pop(context);
      CustomSnackBar.showSuccess(
        context,
        message: 'supervisor.tasks.create.success'.tr(),
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
                    'supervisor.tasks.create.title'.tr(context: context),
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
                    child: SupervisorCreateTaskFieldWidget(
                      labelKey: 'supervisor.tasks.create.dueDateLabel',
                      hintKey: 'supervisor.tasks.create.dueDateHint',
                      controller: dueDateController,
                      readOnly: true,
                      onTap: () async {
                        final date = await showDatePicker(
                          context: context,
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2030),
                          initialDate: DateTime.now(),
                        );
                        if (date != null && context.mounted) {
                          dueDateController.text =
                              AppDateFormatter.formatYearMonthDay(date);
                        }
                      },
                      suffixIcon: Icon(
                        Icons.calendar_today_outlined,
                        size: 18.r,
                      ),
                    ),
                  ),
                  wSpace(12),
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
              BlocBuilder<SupervisorTeamCubit, SupervisorTeamState>(
                builder: (context, state) {
                  final team = switch (state) {
                    SupervisorTeamSuccess(:final members) => members,
                    _ => const [],
                  };
                  final items = team
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
                    hint: 'Select Employees',
                    items: items,
                    selectedIds: selectedEmployeeIds,
                    onSelectionChanged: (newSelected) =>
                        setState(() => selectedEmployeeIds = newSelected),
                  );
                },
              ),
              hSpace(20),
              CustomButton(
                text: 'supervisor.tasks.create.submit'.tr(context: context),
                isLoading: isSubmitting,
                onTap: _submit,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
