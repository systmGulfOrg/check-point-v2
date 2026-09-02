import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/core.dart';
import 'supervisor_create_task_field_widget.dart';

class SupervisorCreatePlanSheetWidget extends StatefulWidget {
  const SupervisorCreatePlanSheetWidget({super.key});

  @override
  State<SupervisorCreatePlanSheetWidget> createState() =>
      _SupervisorCreatePlanSheetWidgetState();
}

class _SupervisorCreatePlanSheetWidgetState
    extends State<SupervisorCreatePlanSheetWidget> {
  final nameController = TextEditingController();
  final dateController = TextEditingController();
  final startController = TextEditingController();
  final endController = TextEditingController();
  final locationController = TextEditingController();
  final descriptionController = TextEditingController();
  String selectedType = 'mission';
  String selectedAssignee = 'fatima';

  @override
  void dispose() {
    nameController.dispose();
    dateController.dispose();
    startController.dispose();
    endController.dispose();
    locationController.dispose();
    descriptionController.dispose();
    super.dispose();
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
              DropdownButtonFormField<String>(
                initialValue: selectedType,
                decoration: InputDecoration(
                  labelText: 'supervisor.plans.create.typeLabel'.tr(
                    context: context,
                  ),
                ),
                items: [
                  DropdownMenuItem(
                    value: 'mission',
                    child: Text(
                      'supervisor.plans.type.mission'.tr(context: context),
                    ),
                  ),
                  DropdownMenuItem(
                    value: 'customerVisit',
                    child: Text(
                      'supervisor.plans.type.customerVisit'.tr(
                        context: context,
                      ),
                    ),
                  ),
                ],
                onChanged: (value) =>
                    setState(() => selectedType = value ?? selectedType),
              ),
              hSpace(16),
              SupervisorCreateTaskFieldWidget(
                labelKey: 'supervisor.plans.create.dateLabel',
                hintKey: 'supervisor.tasks.create.dueDateHint',
                controller: dateController,
                readOnly: true,
                onTap: () async {
                  final date = await showDatePicker(
                    context: context,
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2030),
                    initialDate: DateTime.now(),
                  );
                  if (date != null) {
                    dateController.text = DateFormat('dd/MM/yyyy').format(date);
                  }
                },
                suffixIcon: Icon(Icons.calendar_today_outlined, size: 18.r),
              ),
              hSpace(16),
              Row(
                children: [
                  Expanded(
                    child: SupervisorCreateTaskFieldWidget(
                      labelKey: 'supervisor.plans.create.startTimeLabel',
                      hintKey: 'supervisor.plans.create.timeHint',
                      controller: startController,
                      readOnly: true,
                      onTap: () async {
                        final time = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );
                        if (time != null && context.mounted) {
                          startController.text = time.format(context);
                        }
                      },
                    ),
                  ),
                  vSpace(12),
                  Expanded(
                    child: SupervisorCreateTaskFieldWidget(
                      labelKey: 'supervisor.plans.create.endTimeLabel',
                      hintKey: 'supervisor.plans.create.timeHint',
                      controller: endController,
                      readOnly: true,
                      onTap: () async {
                        final time = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );
                        if (time != null && context.mounted) {
                          endController.text = time.format(context);
                        }
                      },
                    ),
                  ),
                ],
              ),
              hSpace(16),
              SupervisorCreateTaskFieldWidget(
                labelKey: 'supervisor.plans.create.locationLabel',
                hintKey: 'supervisor.plans.create.locationHint',
                controller: locationController,
              ),
              hSpace(16),
              SupervisorCreateTaskFieldWidget(
                labelKey: 'supervisor.plans.create.descriptionLabel',
                hintKey: 'supervisor.plans.create.descriptionHint',
                controller: descriptionController,
                maxLines: 3,
              ),
              hSpace(16),
              Text(
                'supervisor.tasks.create.assignToLabel'.tr(context: context),
                style: AppTextStyles.font12Medium,
              ),
              hSpace(8),
              DropdownButtonFormField<String>(
                key: ValueKey(selectedAssignee),
                initialValue: selectedAssignee,
                decoration: const InputDecoration(),
                items: [
                  for (final assignee in const [
                    ('james', 'supervisor.attendance.members.james'),
                    ('priya', 'supervisor.attendance.members.priya'),
                    ('fatima', 'supervisor.attendance.members.fatima'),
                  ])
                    DropdownMenuItem(
                      value: assignee.$1,
                      child: Text(assignee.$2.tr(context: context)),
                    ),
                ],
                onChanged: (value) => setState(() {
                  selectedAssignee = value ?? selectedAssignee;
                }),
              ),
              hSpace(10),
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
                      onTap: () => Navigator.pop(context),
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
