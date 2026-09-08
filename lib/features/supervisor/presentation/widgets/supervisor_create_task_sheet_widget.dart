import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/admin/data/models/tasks/admin_task_model.dart';
import 'package:check_point_v2/features/supervisor/presentation/cubit/tasks/supervisor_tasks_cubit.dart';
import 'package:check_point_v2/features/supervisor/presentation/cubit/team/supervisor_team_cubit.dart';
import 'package:check_point_v2/features/supervisor/presentation/cubit/team/supervisor_team_state.dart';
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
  String? selectedEmployeeId;
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
    final tasksCubit = context.read<SupervisorTasksCubit>();

    final success = await tasksCubit.addTask(
      AddTaskRequestBody(
        title: title,
        description: descriptionController.text.trim(),
        assignedEmployeeId: selectedEmployeeId,
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
              BlocBuilder<SupervisorTeamCubit, SupervisorTeamState>(
                builder: (context, state) {
                  final team = switch (state) {
                    SupervisorTeamSuccess(:final members) => members,
                    _ => const [],
                  };
                  return DropdownButtonFormField<String>(
                    initialValue: selectedEmployeeId,
                    decoration: InputDecoration(
                      labelText: 'supervisor.tasks.create.assignToLabel'.tr(
                        context: context,
                      ),
                    ),
                    items: team
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
