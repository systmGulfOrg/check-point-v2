import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/core.dart';
import 'supervisor_assignee_option_widget.dart';
import 'supervisor_create_task_field_widget.dart';

class SupervisorCreateTaskSheetWidget extends StatefulWidget {
  const SupervisorCreateTaskSheetWidget({super.key});

  @override
  State<SupervisorCreateTaskSheetWidget> createState() =>
      _SupervisorCreateTaskSheetWidgetState();
}

class _SupervisorCreateTaskSheetWidgetState
    extends State<SupervisorCreateTaskSheetWidget> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final dueDateController = TextEditingController();
  String selectedPriority = 'medium';
  final selectedAssignees = <String>{'james', 'priya'};
  bool isAssigneeDropdownOpen = false;

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
                        if (date != null) {
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
                            DropdownMenuItem(
                              value: 'low',
                              child: Text(
                                'supervisor.tasks.priority.low'.tr(
                                  context: context,
                                ),
                              ),
                            ),
                            DropdownMenuItem(
                              value: 'medium',
                              child: Text(
                                'supervisor.tasks.priority.medium'.tr(
                                  context: context,
                                ),
                              ),
                            ),
                            DropdownMenuItem(
                              value: 'high',
                              child: Text(
                                'supervisor.tasks.priority.high'.tr(
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
              InkWell(
                onTap: () => setState(
                  () => isAssigneeDropdownOpen = !isAssigneeDropdownOpen,
                ),
                borderRadius: BorderRadius.circular(10.r),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 12.h,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.pageBackground,
                    borderRadius: BorderRadius.circular(10.r),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          selectedAssignees
                              .map(
                                (key) => 'supervisor.attendance.members.$key'
                                    .tr(context: context),
                              )
                              .join(', '),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.font12Medium,
                        ),
                      ),
                      Icon(
                        isAssigneeDropdownOpen
                            ? Icons.keyboard_arrow_up_rounded
                            : Icons.keyboard_arrow_down_rounded,
                        color: AppColors.textSecondary,
                        size: 20.r,
                      ),
                    ],
                  ),
                ),
              ),
              if (isAssigneeDropdownOpen) ...[
                hSpace(6),
                for (final assignee in const [
                  ('james', 'JM', 'supervisor.attendance.members.james'),
                  ('priya', 'PN', 'supervisor.attendance.members.priya'),
                  ('fatima', 'FA', 'supervisor.attendance.members.fatima'),
                ])
                  SupervisorAssigneeOptionWidget(
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
              ],
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
