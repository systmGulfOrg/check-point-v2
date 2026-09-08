import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/admin/data/models/plans/admin_plan_model.dart';
import 'package:check_point_v2/features/supervisor/presentation/cubit/plans/supervisor_plans_cubit.dart';
import 'package:check_point_v2/features/supervisor/presentation/cubit/team/supervisor_team_cubit.dart';
import 'package:check_point_v2/features/supervisor/presentation/cubit/team/supervisor_team_state.dart';
import 'supervisor_create_task_field_widget.dart';

class SupervisorCreatePlanSheetWidget extends StatefulWidget {
  const SupervisorCreatePlanSheetWidget({super.key});

  @override
  State<SupervisorCreatePlanSheetWidget> createState() =>
      _SupervisorCreatePlanSheetWidgetState();
}

class _SupervisorCreatePlanSheetWidgetState
    extends State<SupervisorCreatePlanSheetWidget> {
  late final TextEditingController nameController;
  late final TextEditingController startDateController;
  late final TextEditingController endDateController;
  late final TextEditingController descriptionController;
  String? selectedEmployeeId;
  bool isSubmitting = false;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    startDateController = TextEditingController(
      text: AppDateFormatter.formatYearMonthDay(DateTime.now()),
    );
    endDateController = TextEditingController(
      text: AppDateFormatter.formatYearMonthDay(
        DateTime.now().add(const Duration(days: 1)),
      ),
    );
    descriptionController = TextEditingController();
  }

  @override
  void dispose() {
    nameController.dispose();
    startDateController.dispose();
    endDateController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final title = nameController.text.trim();
    if (title.isEmpty || selectedEmployeeId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('supervisor.plans.create.requiredFields'.tr()),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }

    setState(() => isSubmitting = true);
    final plansCubit = context.read<SupervisorPlansCubit>();

    final success = await plansCubit.createPlan(
      CreatePlanRequestBody(
        title: title,
        description: descriptionController.text.trim(),
        startDate: startDateController.text.trim(),
        endDate: endDateController.text.trim(),
        assignedEmployeeId: selectedEmployeeId!,
      ),
    );

    if (!mounted) return;
    setState(() => isSubmitting = false);

    if (success) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('supervisor.plans.create.success'.tr()),
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
                    'supervisor.plans.create.title'.tr(context: context),
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
                labelKey: 'supervisor.plans.create.nameLabel',
                hintKey: 'supervisor.plans.create.nameHint',
                controller: nameController,
              ),
              hSpace(16),
              SupervisorCreateTaskFieldWidget(
                labelKey: 'supervisor.plans.create.descriptionLabel',
                hintKey: 'supervisor.plans.create.descriptionHint',
                controller: descriptionController,
                maxLines: 3,
              ),
              hSpace(16),
              Row(
                children: [
                  Expanded(
                    child: SupervisorCreateTaskFieldWidget(
                      labelKey: 'supervisor.plans.create.startDateLabel',
                      hintKey: 'supervisor.tasks.create.dueDateHint',
                      controller: startDateController,
                      readOnly: true,
                      onTap: () async {
                        final date = await showDatePicker(
                          context: context,
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2030),
                          initialDate: DateTime.now(),
                        );
                        if (date != null && context.mounted) {
                          startDateController.text =
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
                    child: SupervisorCreateTaskFieldWidget(
                      labelKey: 'supervisor.plans.create.endDateLabel',
                      hintKey: 'supervisor.tasks.create.dueDateHint',
                      controller: endDateController,
                      readOnly: true,
                      onTap: () async {
                        final date = await showDatePicker(
                          context: context,
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2030),
                          initialDate: DateTime.now(),
                        );
                        if (date != null && context.mounted) {
                          endDateController.text =
                              AppDateFormatter.formatYearMonthDay(date);
                        }
                      },
                      suffixIcon: Icon(
                        Icons.calendar_today_outlined,
                        size: 18.r,
                      ),
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
