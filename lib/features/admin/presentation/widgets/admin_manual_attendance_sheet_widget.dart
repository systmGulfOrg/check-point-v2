import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/supervisor/presentation/widgets/supervisor_create_task_field_widget.dart';

class AdminManualAttendanceSheetWidget extends StatefulWidget {
  const AdminManualAttendanceSheetWidget({super.key});

  @override
  State<AdminManualAttendanceSheetWidget> createState() =>
      _AdminManualAttendanceSheetWidgetState();
}

class _AdminManualAttendanceSheetWidgetState
    extends State<AdminManualAttendanceSheetWidget> {
  final dateController = TextEditingController();
  final checkInController = TextEditingController();
  final checkOutController = TextEditingController();
  final reasonController = TextEditingController();
  String selectedEmployee = 'james';

  @override
  void dispose() {
    dateController.dispose();
    checkInController.dispose();
    checkOutController.dispose();
    reasonController.dispose();
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
                    'admin.attendance.manual.title'.tr(context: context),
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
              Text(
                'admin.attendance.manual.employee'.tr(context: context),
                style: AppTextStyles.font12Medium,
              ),
              hSpace(8),
              DropdownButtonFormField<String>(
                initialValue: selectedEmployee,
                decoration: const InputDecoration(),
                items: [
                  for (final employee in const [
                    ('james', 'supervisor.attendance.members.james'),
                    ('priya', 'supervisor.attendance.members.priya'),
                    ('fatima', 'supervisor.attendance.members.fatima'),
                  ])
                    DropdownMenuItem(
                      value: employee.$1,
                      child: Text(employee.$2.tr(context: context)),
                    ),
                ],
                onChanged: (value) => setState(
                  () => selectedEmployee = value ?? selectedEmployee,
                ),
              ),
              hSpace(16),
              SupervisorCreateTaskFieldWidget(
                labelKey: 'admin.attendance.manual.date',
                hintKey: 'supervisor.tasks.create.dueDateHint',
                controller: dateController,
                readOnly: true,
                onTap: () async {
                  final date = await showDatePicker(
                    context: context,
                    firstDate: DateTime(2020),
                    lastDate: DateTime(2030),
                    initialDate: DateTime.now(),
                  );
                  if (date != null && context.mounted) {
                    dateController.text = AppDateFormatter.formatDayMonthYear(
                      date,
                    );
                  }
                },
                suffixIcon: Icon(Icons.calendar_today_outlined, size: 18.r),
              ),
              hSpace(16),
              Row(
                children: [
                  Expanded(
                    child: SupervisorCreateTaskFieldWidget(
                      labelKey: 'admin.attendance.manual.checkIn',
                      hintKey: 'supervisor.plans.create.timeHint',
                      controller: checkInController,
                      readOnly: true,
                      onTap: () async {
                        final time = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );
                        if (time != null && context.mounted) {
                          checkInController.text = time.format(context);
                        }
                      },
                    ),
                  ),
                  vSpace(12),
                  Expanded(
                    child: SupervisorCreateTaskFieldWidget(
                      labelKey: 'admin.attendance.manual.checkOut',
                      hintKey: 'supervisor.plans.create.timeHint',
                      controller: checkOutController,
                      readOnly: true,
                      onTap: () async {
                        final time = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );
                        if (time != null && context.mounted) {
                          checkOutController.text = time.format(context);
                        }
                      },
                    ),
                  ),
                ],
              ),
              hSpace(16),
              SupervisorCreateTaskFieldWidget(
                labelKey: 'admin.attendance.manual.reason',
                hintKey: 'admin.attendance.manual.reasonHint',
                controller: reasonController,
                maxLines: 3,
              ),
              hSpace(16),
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      text: 'admin.attendance.cancel'.tr(context: context),
                      onTap: () => Navigator.pop(context),
                      backgroundColor: AppColors.pageBackground,
                      textColor: AppColors.textPrimary,
                    ),
                  ),
                  vSpace(12),
                  Expanded(
                    child: CustomButton(
                      text: 'admin.attendance.save'.tr(context: context),
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
