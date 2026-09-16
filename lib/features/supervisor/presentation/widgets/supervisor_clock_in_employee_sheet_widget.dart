import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/supervisor/data/models/attendance/supervisor_attendance_check_in_request_body.dart';
import 'package:check_point_v2/features/supervisor/data/models/attendance/supervisor_attendance_check_out_request_body.dart';
import 'package:check_point_v2/features/supervisor/presentation/cubit/attendance/supervisor_attendance_cubit.dart';
import 'package:check_point_v2/features/supervisor/presentation/cubit/team/supervisor_team_cubit.dart';
import 'package:check_point_v2/features/supervisor/presentation/cubit/team/supervisor_team_state.dart';
import 'supervisor_create_task_field_widget.dart';

class SupervisorClockInEmployeeSheetWidget extends StatefulWidget {
  const SupervisorClockInEmployeeSheetWidget({super.key});

  @override
  State<SupervisorClockInEmployeeSheetWidget> createState() =>
      _SupervisorClockInEmployeeSheetWidgetState();
}

class _SupervisorClockInEmployeeSheetWidgetState
    extends State<SupervisorClockInEmployeeSheetWidget> {
  String? selectedEmployeeId;
  int actionIndex = 0; // 0: Check In, 1: Check Out
  late final TextEditingController timeController;
  late final TextEditingController dateController;
  bool isSubmitting = false;

  @override
  void initState() {
    super.initState();
    timeController = TextEditingController(
      text: AppDateFormatter.format24Time(DateTime.now()),
    );
    dateController = TextEditingController(
      text: AppDateFormatter.formatYearMonthDay(DateTime.now()),
    );
  }

  @override
  void dispose() {
    timeController.dispose();
    dateController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (selectedEmployeeId == null || selectedEmployeeId!.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('supervisor.attendance.selectEmployee'.tr()),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }

    setState(() => isSubmitting = true);
    final attCubit = context.read<SupervisorAttendanceCubit>();
    final dateTimeIso = '${dateController.text}T${timeController.text}:00Z';

    final bool success = actionIndex == 0
        ? await attCubit.checkIn(
            SupervisorAttendanceCheckInRequestBody(
              employeeIdd: selectedEmployeeId!,
              clockInTime: dateTimeIso,
              attendanceDate: dateController.text,
            ),
          )
        : await attCubit.checkOut(
            SupervisorAttendanceCheckOutRequestBody(
              employeeId: selectedEmployeeId!,
            ),
          );

    if (!mounted) return;
    setState(() => isSubmitting = false);

    if (success) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('supervisor.attendance.recordSuccess'.tr()),
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
                    'supervisor.attendance.recordAttendance'.tr(
                      context: context,
                    ),
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
              BlocBuilder<SupervisorTeamCubit, SupervisorTeamState>(
                builder: (context, state) {
                  final team = switch (state) {
                    SupervisorTeamSuccess(:final members) => members,
                    _ => const [],
                  };
                  final hasEmployee =
                      selectedEmployeeId != null &&
                      team.any((e) => e.id == selectedEmployeeId);
                  return DropdownButtonFormField<String>(
                    key: ValueKey(
                      'sup_clock_emp_${hasEmployee ? selectedEmployeeId : 'none'}',
                    ),
                    initialValue: hasEmployee ? selectedEmployeeId : null,
                    decoration: InputDecoration(
                      labelText: 'supervisor.attendance.employee'.tr(
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
              hSpace(14),
              Row(
                children: [
                  Expanded(
                    child: ChoiceChip(
                      label: Center(
                        child: Text(
                          'supervisor.attendance.checkInAction'.tr(
                            context: context,
                          ),
                        ),
                      ),
                      selected: actionIndex == 0,
                      onSelected: (_) => setState(() => actionIndex = 0),
                    ),
                  ),
                  vSpace(10),
                  Expanded(
                    child: ChoiceChip(
                      label: Center(
                        child: Text(
                          'supervisor.attendance.checkOutAction'.tr(
                            context: context,
                          ),
                        ),
                      ),
                      selected: actionIndex == 1,
                      onSelected: (_) => setState(() => actionIndex = 1),
                    ),
                  ),
                ],
              ),
              hSpace(14),
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
                    dateController.text = AppDateFormatter.formatYearMonthDay(
                      date,
                    );
                  }
                },
                suffixIcon: Icon(Icons.calendar_today_outlined, size: 18.r),
              ),
              hSpace(14),
              SupervisorCreateTaskFieldWidget(
                labelKey: 'supervisor.plans.create.startTimeLabel',
                hintKey: 'supervisor.plans.create.timeHint',
                controller: timeController,
                readOnly: true,
                onTap: () async {
                  final time = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  if (time != null && context.mounted) {
                    final h = time.hour.toString().padLeft(2, '0');
                    final m = time.minute.toString().padLeft(2, '0');
                    timeController.text = '$h:$m';
                  }
                },
                suffixIcon: Icon(Icons.access_time_rounded, size: 18.r),
              ),
              hSpace(20),
              CustomButton(
                text: 'admin.attendance.save'.tr(context: context),
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
