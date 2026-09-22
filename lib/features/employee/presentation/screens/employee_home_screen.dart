import 'dart:async';

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
import 'package:check_point_v2/features/employee/presentation/widgets/employee_home_header_bloc_builder_widget.dart';
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
  @override
  void initState() {
    super.initState();
    context.read<EmployeeAttendanceCubit>().loadAttendanceHistory();
    context.read<EmployeeTasksCubit>().loadMyTasks();
    context.read<EmployeePlansCubit>().loadMyPlans();
  }

  void _toggleCheckInOut() {
    final attendanceCubit = context.read<EmployeeAttendanceCubit>();
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      constraints: BoxConstraints.tightFor(
        height: MediaQuery.sizeOf(context).height,
      ),
      backgroundColor: AppColors.cardBackground,
      builder: (_) => BlocProvider.value(
        value: attendanceCubit,
        child: EmployeeAttendanceLocationSheetWidget(
          isCheckOut:
              attendanceCubit.hasClockIn(attendanceCubit.todayAttendance) &&
              !attendanceCubit.hasClockOut(attendanceCubit.todayAttendance),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: MultiBlocListener(
          listeners: const [],
          child: RefreshIndicator(
            onRefresh: () async {
              await Future.wait([
                context.read<EmployeeAttendanceCubit>().loadAttendanceHistory(),
                context.read<EmployeeTasksCubit>().loadMyTasks(),
                context.read<EmployeePlansCubit>().loadMyPlans(),
              ]);
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const EmployeeHomeHeaderBlocBuilderWidget(),
                  hSpace(20),
                  BlocConsumer<
                    EmployeeAttendanceCubit,
                    EmployeeAttendanceState
                  >(
                    listener: (context, state) {
                      switch (state) {
                        case EmployeeAttendanceStateCheckInSuccess():
                          unawaited(
                            context
                                .read<EmployeeAttendanceCubit>()
                                .loadAttendanceHistory(),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'employee.clock.checkedInSuccess'.tr(
                                  context: context,
                                ),
                              ),
                            ),
                          );
                        case EmployeeAttendanceStateCheckOutSuccess():
                          unawaited(
                            context
                                .read<EmployeeAttendanceCubit>()
                                .loadAttendanceHistory(),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'employee.clock.checkedOutSuccess'.tr(
                                  context: context,
                                ),
                              ),
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
                      final attendance = context
                          .read<EmployeeAttendanceCubit>()
                          .todayAttendance;
                      final profile = context
                          .read<EmployeeAttendanceCubit>()
                          .employeeProfile;
                      final cubit = context.read<EmployeeAttendanceCubit>();
                      final workMode = profile?.todayWorkMode ?? 'onsite';
                      final workSystem = profile?.workSystem ?? 'onsite';
                      final clockIn =
                          profile?.todayWorkStart ??
                          profile?.workPolicy?.workingHoursStart ??
                          profile?.clockInTime;
                      final clockOut =
                          profile?.todayWorkEnd ??
                          profile?.workPolicy?.workingHoursEnd ??
                          profile?.clockOutTime;
                      final isCheckedIn =
                          cubit.hasClockIn(attendance) &&
                          !cubit.hasClockOut(attendance);
                      final hasCheckedOut = cubit.hasClockOut(attendance);
                      return Skeletonizer(
                        enabled: state is EmployeeAttendanceStateLoading,
                        child: EmployeeTodayCardWidget(
                          policyText:
                              '${profile?.shiftName ?? 'employee.home.defaultPolicy'.tr(context: context)} — '
                              '${AppDateFormatter.formatTimeString(clockIn)}–${AppDateFormatter.formatTimeString(clockOut)}',
                          isOnTime: attendance?.isLate != true,
                          checkInTime: AppDateFormatter.formatTimeString(
                            attendance?.clockInTime,
                          ),
                          checkOutTime: AppDateFormatter.formatTimeString(
                            attendance?.clockOutTime,
                          ),
                          isCheckedIn: isCheckedIn,
                          hasCheckedOut: hasCheckedOut,
                          workedHours: attendance?.dayHours,
                          leaveBalance: profile?.leaveBalance,
                          workModeText: workMode.tr(context: context),
                          workSystemText: workSystem.tr(context: context),
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
                                    t.status != 'Completed' &&
                                    t.status != 'Done',
                              )
                              .length,
                        _ => 0,
                      };
                      return BlocBuilder<
                        EmployeePlansCubit,
                        EmployeePlansState
                      >(
                        builder: (context, plansState) {
                          final upcomingPlans = switch (plansState) {
                            EmployeePlansStateSuccess(:final plans) =>
                              plans.length,
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
                                  dateTime:
                                      p.planDate ?? DateTime.now().toString(),
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
        ),
      ),
    );
  }
}
