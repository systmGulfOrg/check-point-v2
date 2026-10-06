import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/core/widgets/app_multi_select_dropdown_widget.dart';
import 'package:check_point_v2/features/admin/data/models/tasks/admin_task_model.dart';
import 'package:check_point_v2/features/employee/presentation/cubit/tasks/employee_tasks_cubit.dart';

class EmployeeCreateTaskSheetWidget extends StatefulWidget {
  const EmployeeCreateTaskSheetWidget({super.key});

  @override
  State<EmployeeCreateTaskSheetWidget> createState() =>
      _EmployeeCreateTaskSheetWidgetState();
}

class _EmployeeCreateTaskSheetWidgetState
    extends State<EmployeeCreateTaskSheetWidget> {
  late final TextEditingController titleController;
  late final TextEditingController descriptionController;
  Set<String> selectedEmployeeIds = {};
  bool isSubmitting = false;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController();
    descriptionController = TextEditingController();
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  Future<void> submit() async {
    final title = titleController.text.trim();
    if (title.isEmpty) {
      CustomSnackBar.show(
        context,
        message: 'supervisor.tasks.create.titleRequired'.tr(),
      );
      return;
    }
    setState(() => isSubmitting = true);
    final success = await context.read<EmployeeTasksCubit>().addTask(
      AddTaskRequestBody(
        title: title,
        description: descriptionController.text.trim(),
        assignedEmployeeId: selectedEmployeeIds.isEmpty
            ? null
            : selectedEmployeeIds.first,
        priorityStatus: 'Medium',
        status: 'Pending',
      ),
    );
    if (!mounted) return;
    setState(() => isSubmitting = false);
    if (success) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<EmployeeTasksCubit>();
    final items = cubit.teamMembers
        .where((member) => member.id != null)
        .map(
          (member) => AppMultiSelectItem<String>(
            id: member.id!,
            label:
                member.name ?? member.userName ?? 'employee.team.member'.tr(),
          ),
        )
        .toList();
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.fromLTRB(20.w, 18.h, 20.w, 16.h),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'supervisor.tasks.create.title'.tr(),
                style: AppTextStyles.font18Bold,
              ),
              hSpace(14),
              CustomTextFormField(
                controller: titleController,
                hintText: 'supervisor.tasks.create.titleHint'.tr(),
              ),
              hSpace(12),
              CustomTextFormField(
                controller: descriptionController,
                hintText: 'supervisor.tasks.create.descriptionHint'.tr(),
                maxLines: 3,
              ),
              if (items.isNotEmpty) ...[
                hSpace(12),
                AppMultiSelectDropdownWidget<String>(
                  label: 'supervisor.tasks.create.assignToLabel'.tr(),
                  hint: 'supervisor.tasks.create.selectEmployeesHint'.tr(),
                  items: items,
                  selectedIds: selectedEmployeeIds,
                  onSelectionChanged: (value) =>
                      setState(() => selectedEmployeeIds = value),
                ),
              ],
              hSpace(18),
              CustomButton(
                text: 'supervisor.tasks.create.submit'.tr(),
                isLoading: isSubmitting,
                onTap: submit,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
