import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/employee/presentation/cubit/attendance/employee_attendance_cubit.dart';
import 'package:check_point_v2/features/employee/presentation/cubit/attendance/employee_attendance_state.dart';
import 'package:check_point_v2/features/employee/presentation/cubit/plans/employee_plans_cubit.dart';
import 'package:check_point_v2/features/employee/presentation/cubit/plans/employee_plans_state.dart';
import 'package:check_point_v2/features/employee/presentation/cubit/tasks/employee_tasks_cubit.dart';
import 'package:check_point_v2/features/employee/presentation/cubit/tasks/employee_tasks_state.dart';
import 'package:check_point_v2/features/employee/presentation/widgets/employee_header_widget.dart';
import 'package:check_point_v2/features/employee/presentation/widgets/employee_plan_data.dart';
import 'package:check_point_v2/features/employee/presentation/widgets/employee_plans_section_widget.dart';
import 'package:check_point_v2/features/employee/presentation/widgets/employee_stats_row_widget.dart';
import 'package:check_point_v2/features/employee/presentation/widgets/employee_task_data.dart';
import 'package:check_point_v2/features/employee/presentation/widgets/employee_tasks_section_widget.dart';
import 'package:check_point_v2/features/employee/presentation/widgets/employee_today_card_widget.dart';
import 'package:check_point_v2/features/employee/presentation/widgets/employee_attendance_location_sheet_widget.dart';

class EmployeeHomeScreen extends StatefulWidget {
  const EmployeeHomeScreen({
    this.onViewAllTasks,
    this.onViewAllPlans,
    super.key,
  });

  final VoidCallback? onViewAllTasks;
  final VoidCallback? onViewAllPlans;

  @override
  State<EmployeeHomeScreen> createState() => _EmployeeHomeScreenState();
}

class _EmployeeHomeScreenState extends State<EmployeeHomeScreen> {
  bool _isCheckedIn = false;
  bool _hasCheckedOut = true;
  String _checkInTime = '--:--';
  String _checkOutTime = '--:--';
  String? _workedHours;

  @override
  void initState() {
    super.initState();
    context.read<EmployeeAttendanceCubit>().loadAttendanceHistory();
    context.read<EmployeeTasksCubit>().loadMyTasks();
    context.read<EmployeePlansCubit>().loadMyPlans();
  }

  void _toggleCheckInOut() {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      constraints: BoxConstraints.tightFor(
        height: MediaQuery.sizeOf(context).height,
      ),
      backgroundColor: AppColors.cardBackground,
      builder: (_) => BlocProvider.value(
        value: context.read<EmployeeAttendanceCubit>(),
        child: EmployeeAttendanceLocationSheetWidget(isCheckOut: _isCheckedIn),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              EmployeeHeaderWidget(
                titleKey: 'employee.home.title',
                userName: 'Employee',
                dateText: AppDateFormatter.formatFullDate(DateTime.now()),
                notificationCount: 0,
              ),
              hSpace(20),
              BlocConsumer<EmployeeAttendanceCubit, EmployeeAttendanceState>(
                listener: (context, state) {
                  switch (state) {
                    case EmployeeAttendanceStateCheckInSuccess(
                      :final attendance,
                    ):
                      setState(() {
                        _isCheckedIn = true;
                        _hasCheckedOut = false;
                        _checkInTime =
                            attendance.clockInTime ??
                            DateFormat('HH:mm').format(DateTime.now());
                        _checkOutTime = '—';
                        _workedHours = null;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Checked in successfully'),
                        ),
                      );
                    case EmployeeAttendanceStateCheckOutSuccess(
                      :final attendance,
                    ):
                      setState(() {
                        _isCheckedIn = false;
                        _hasCheckedOut = true;
                        _checkOutTime =
                            attendance.clockOutTime ??
                            DateFormat('HH:mm').format(DateTime.now());
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Checked out successfully'),
                        ),
                      );
                    case EmployeeAttendanceStateError(:final messageKey):
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text(messageKey)));
                    default:
                      break;
                  }
                },
                builder: (context, state) {
                  return Skeletonizer(
                    enabled: state is EmployeeAttendanceStateLoading,
                    child: EmployeeTodayCardWidget(
                      policyText: 'Standard Policy — 08:00–16:00',
                      isOnTime: true,
                      checkInTime: _checkInTime,
                      checkOutTime: _checkOutTime,
                      isCheckedIn: _isCheckedIn,
                      hasCheckedOut: _hasCheckedOut,
                      workedHours: _workedHours,
                      onToggleCheckInOut: _toggleCheckInOut,
                    ),
                  );
                },
              ),
              hSpace(20),
              BlocBuilder<EmployeeTasksCubit, EmployeeTasksState>(
                builder: (context, tasksState) {
                  final activeCount = switch (tasksState) {
                    EmployeeTasksStateSuccess(:final tasks) =>
                      tasks
                          .where(
                            (t) =>
                                t.status != 'Completed' && t.status != 'Done',
                          )
                          .length,
                    _ => 0,
                  };
                  return BlocBuilder<EmployeePlansCubit, EmployeePlansState>(
                    builder: (context, plansState) {
                      final upcomingPlans = switch (plansState) {
                        EmployeePlansStateSuccess(:final plans) => plans.length,
                        _ => 0,
                      };
                      return Skeletonizer(
                        enabled:
                            tasksState is EmployeeTasksStateLoading ||
                            plansState is EmployeePlansStateLoading,
                        child: EmployeeStatsRowWidget(
                          activeTasksCount: activeCount,
                          upcomingPlansCount: upcomingPlans,
                          pendingLeavesCount: 0,
                        ),
                      );
                    },
                  );
                },
              ),
              hSpace(20),
              BlocBuilder<EmployeeTasksCubit, EmployeeTasksState>(
                builder: (context, state) {
                  final tasksList = switch (state) {
                    EmployeeTasksStateSuccess(:final tasks) =>
                      tasks
                          .take(3)
                          .map(
                            (t) => EmployeeTaskData(
                              id: '${t.id ?? 0}',
                              title: t.title ?? '',
                              dueDate: 'Task #${t.id ?? 0}',
                              status: t.status ?? 'Pending',
                              priority: 'Normal',
                              description: t.description ?? '',
                              progressPercentage: 50,
                              assignees: const ['EM'],
                            ),
                          )
                          .toList(),
                    _ => const <EmployeeTaskData>[],
                  };
                  return Skeletonizer(
                    enabled: state is EmployeeTasksStateLoading,
                    child: EmployeeTasksSectionWidget(
                      tasks: tasksList,
                      onViewAllTap: widget.onViewAllTasks ?? () {},
                    ),
                  );
                },
              ),
              hSpace(20),
              BlocBuilder<EmployeePlansCubit, EmployeePlansState>(
                builder: (context, state) {
                  final plansList = switch (state) {
                    EmployeePlansStateSuccess(:final plans) =>
                      plans
                          .take(3)
                          .map(
                            (p) => EmployeePlanData(
                              id: '${p.id ?? 0}',
                              title: p.title ?? 'Plan #${p.id ?? 0}',
                              dateTime: p.planDate ?? DateTime.now().toString(),
                              planType: p.planType ?? 'Mission',
                              description: p.notes ?? '',
                              status: p.status ?? 'planned',
                              assignees: const ['EM'],
                            ),
                          )
                          .toList(),
                    _ => const <EmployeePlanData>[],
                  };
                  return Skeletonizer(
                    enabled: state is EmployeePlansStateLoading,
                    child: EmployeePlansSectionWidget(
                      plans: plansList,
                      onViewAllTap: widget.onViewAllPlans ?? () {},
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
