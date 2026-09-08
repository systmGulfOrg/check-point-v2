import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/admin/data/models/tasks/admin_task_model.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/employee/admin_employees_cubit.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/employee/admin_employees_state.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/tasks/admin_tasks_cubit.dart';
import 'package:check_point_v2/features/supervisor/presentation/widgets/supervisor_create_task_field_widget.dart';

class AdminCreateTaskSheetWidget extends StatefulWidget {
  const AdminCreateTaskSheetWidget({super.key});

  @override
  State<AdminCreateTaskSheetWidget> createState() =>
      _AdminCreateTaskSheetWidgetState();
}

class _AdminCreateTaskSheetWidgetState
    extends State<AdminCreateTaskSheetWidget> {
  late final TextEditingController titleController;
  late final TextEditingController descriptionController;
  late final TextEditingController dueDateController;
  String selectedPriority = 'medium';
  String? selectedEmployeeId;
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
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('supervisor.tasks.create.titleRequired'.tr()),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }

    setState(() => isSubmitting = true);
    final tasksCubit = context.read<AdminTasksCubit>();

    final success = await tasksCubit.addTask(
      AddTaskRequestBody(
        title: title,
        description: descriptionController.text.trim(),
        assignedEmployeeId: selectedEmployeeId,
        dueDate: dueDateController.text.trim().isNotEmpty
            ? dueDateController.text.trim()
            : null,
        priorityStatus: selectedPriority,
      ),
    );

    if (!mounted) return;
    setState(() => isSubmitting = false);

    if (success) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('supervisor.tasks.create.success'.tr()),
          backgroundColor: AppColors.success,
        ),
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
                    'admin.tasks.create.title'.tr(context: context),
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
                              AppDateFormatter.formatDayMonthYear(date);
                        }
                      },
                      suffixIcon: Icon(
                        Icons.calendar_today_outlined,
                        size: 18.r,
                      ),
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
                              'low',
                              'medium',
                              'high',
                            ])
                              DropdownMenuItem(
                                value: priority,
                                child: Text(
                                  'supervisor.tasks.priority.$priority'.tr(
                                    context: context,
                                  ),
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
                  return DropdownButtonFormField<String>(
                    initialValue: selectedEmployeeId,
                    decoration: InputDecoration(
                      labelText: 'supervisor.tasks.create.assignToLabel'.tr(
                        context: context,
                      ),
                    ),
                    items: employees
                        .where((e) => e.id != null)
                        .map(
                          (e) => DropdownMenuItem<String>(
                            value: e.id!,
                            child: Text(e.name ?? e.userName ?? 'Employee'),
                          ),
                        )
                        .toList(),
                    onChanged: (val) =>
                        setState(() => selectedEmployeeId = val),
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
                      text: 'supervisor.tasks.create.submit'.tr(
                        context: context,
                      ),
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
