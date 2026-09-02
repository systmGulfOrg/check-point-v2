import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/core.dart';
import '../../../supervisor/presentation/widgets/supervisor_assignee_option_widget.dart';
import '../../../supervisor/presentation/widgets/supervisor_create_task_field_widget.dart';

class AdminCreateTaskSheetWidget extends StatefulWidget {
  const AdminCreateTaskSheetWidget({super.key});

  @override
  State<AdminCreateTaskSheetWidget> createState() =>
      _AdminCreateTaskSheetWidgetState();
}

class _AdminCreateTaskSheetWidgetState
    extends State<AdminCreateTaskSheetWidget> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final dueDateController = TextEditingController();
  String selectedPriority = 'medium';
  final selectedAssignees = <String>{};

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    dueDateController.dispose();
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
                          dueDateController.text = DateFormat(
                            'dd/MM/yyyy',
                          ).format(date);
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
              Text(
                'supervisor.tasks.create.assignToLabel'.tr(context: context),
                style: AppTextStyles.font12Medium,
              ),
              hSpace(8),
              for (final assignee in const [
                ('sarah', 'SJ', 'admin.permissions.supervisors.sarah.name'),
                ('ali', 'AH', 'admin.permissions.supervisors.ali.name'),
                ('james', 'JM', 'supervisor.attendance.members.james'),
                ('priya', 'PN', 'supervisor.attendance.members.priya'),
              ])
                Padding(
                  padding: EdgeInsets.only(bottom: 6.h),
                  child: SupervisorAssigneeOptionWidget(
                    initials: assignee.$2,
                    nameKey: assignee.$3,
                    isSelected: selectedAssignees.contains(assignee.$1),
                    onTap: () => setState(() {
                      if (selectedAssignees.contains(assignee.$1)) {
                        selectedAssignees.remove(assignee.$1);
                      } else {
                        selectedAssignees.add(assignee.$1);
                      }
                    }),
                  ),
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
