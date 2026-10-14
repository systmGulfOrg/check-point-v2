import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/employee/presentation/cubit/attendance/employee_attendance_cubit.dart';
import 'package:check_point_v2/features/employee/presentation/cubit/attendance/employee_attendance_state.dart';
import 'package:check_point_v2/features/employee/presentation/widgets/employee_attendance_filter_widget.dart';
import 'package:check_point_v2/features/employee/presentation/widgets/employee_attendance_record_card_widget.dart';
import 'package:check_point_v2/features/employee/presentation/widgets/employee_attendance_record_data.dart';
import 'package:check_point_v2/features/employee/presentation/widgets/employee_clock_card_widget.dart';
import 'package:check_point_v2/features/employee/presentation/widgets/employee_attendance_location_sheet_widget.dart';
import 'package:check_point_v2/features/leaves/presentation/cubit/upcoming_holiday/upcoming_holiday_cubit.dart';
import 'package:check_point_v2/features/leaves/presentation/cubit/upcoming_holiday/upcoming_holiday_state.dart';
import 'package:check_point_v2/features/leaves/presentation/widgets/upcoming_holiday_card_bloc_builder_widget.dart';
import 'package:check_point_v2/features/attendance_points/presentation/cubit/points_cubit.dart';
import 'package:check_point_v2/features/attendance_points/presentation/cubit/points_state.dart';
import 'package:check_point_v2/features/attendance_points/presentation/widgets/points_today_card_widget.dart';
import 'package:check_point_v2/features/attendance_points/presentation/widgets/points_day_details_sheet_widget.dart';

import '../../../attendance_points/data/models/points_history_model.dart';

class EmployeeClockScreen extends StatefulWidget {
  const EmployeeClockScreen({super.key});

  @override
  State<EmployeeClockScreen> createState() => _EmployeeClockScreenState();
}

class _EmployeeClockScreenState extends State<EmployeeClockScreen> {
  static const _dummyAttendanceRecords = [
    EmployeeAttendanceRecordData(
      date: '2026-10-10',
      checkIn: '09:00 AM',
      checkOut: '05:00 PM',
      area: 'Main Office',
      status: 'On Time',
      isLate: false,
      isEarly: false,
    ),
    EmployeeAttendanceRecordData(
      date: '2026-10-09',
      checkIn: '09:15 AM',
      checkOut: '05:00 PM',
      area: 'Main Office',
      status: 'Late',
      isLate: true,
      isEarly: false,
    ),
    EmployeeAttendanceRecordData(
      date: '2026-10-08',
      checkIn: '09:00 AM',
      checkOut: '04:45 PM',
      area: 'Main Office',
      status: 'Early Leave',
      isLate: false,
      isEarly: true,
    ),
  ];

  @override
  void initState() {
    super.initState();
    context.read<EmployeeAttendanceCubit>().loadAttendanceHistory();
    context.read<PointsCubit?>()?.loadAllPointsData();
  }

  void _toggleCheckInOut() {
    final cubit = context.read<EmployeeAttendanceCubit>();
    final profile = cubit.employeeProfile;
    final holidayState = context.read<UpcomingHolidayCubit>().state;
    final isHoliday =
        (profile?.todayHoliday != null &&
            profile!.todayHoliday!.isHoliday == true) ||
        (profile?.todayWorkMode == 'off' && profile?.todayHoliday != null) ||
        (holidayState is UpcomingHolidayStateLoaded &&
            holidayState.isTodayHoliday);

    if (isHoliday) {
      final holidayName =
          profile?.todayHoliday?.arabicName ??
          profile?.todayHoliday?.name ??
          (holidayState is UpcomingHolidayStateLoaded
              ? holidayState.todayHoliday?.name
              : null) ??
          '';
      final holidayGreeting =
          profile?.todayHoliday?.greeting ??
          profile?.holidayMessage ??
          'holidays.todayHolidayGreeting'.tr(context: context);

      showDialog<void>(
        context: context,
        builder: (ctx) => CustomDialogWidget(
          title: 'holidays.todayHolidayTitle'.tr(context: ctx),
          message:
              '${'holidays.todayHolidayTitle'.tr(context: ctx)}: $holidayName\n$holidayGreeting\n${'holidays.attendanceNotAllowed'.tr(context: ctx)}',
          confirmLabel: 'core.actions.ok'.tr(context: ctx),
          onConfirm: () => Navigator.of(ctx).pop(),
          icon: Icons.celebration_rounded,
          iconColor: AppColors.success,
          confirmButtonColor: AppColors.success,
        ),
      );
      return;
    }

    final isWeeklyOff = profile?.todayWorkMode == 'off' && !isHoliday;
    if (isWeeklyOff) {
      showDialog<void>(
        context: context,
        builder: (ctx) => CustomDialogWidget(
          title: 'employee.home.todayWeeklyOffTitle'.tr(context: ctx),
          message:
              '${'employee.home.todayWeeklyOffGreeting'.tr(context: ctx)}\n${'employee.home.weeklyOffAttendanceNotAllowed'.tr(context: ctx)}',
          confirmLabel: 'core.actions.ok'.tr(context: ctx),
          onConfirm: () => Navigator.of(ctx).pop(),
          icon: Icons.weekend_rounded,
          iconColor: AppColors.info,
          confirmButtonColor: AppColors.info,
        ),
      );
      return;
    }
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
        child: RefreshIndicator(
          onRefresh: () async {
            await Future.wait([
              context.read<EmployeeAttendanceCubit>().loadAttendanceHistory(),
              context.read<UpcomingHolidayCubit>().loadUpcomingHoliday(),
            ]);
            final pointsCubit = context.read<PointsCubit?>();
            if (pointsCubit != null) {
              await pointsCubit.loadAllPointsData();
            }
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'employee.clock.title'.tr(context: context),
                  style: AppTextStyles.font24Bold,
                ),
                hSpace(16),
                const UpcomingHolidayCardBlocBuilderWidget(),
                hSpace(16),
                BlocConsumer<EmployeeAttendanceCubit, EmployeeAttendanceState>(
                  listener: (context, state) {
                    switch (state) {
                      case EmployeeAttendanceStateCheckInSuccess():
                        final cubit = context.read<EmployeeAttendanceCubit>();
                        unawaited(cubit.loadAttendanceHistory());
                        final pointsCubit = context.read<PointsCubit?>();
                        if (pointsCubit != null) {
                          unawaited(pointsCubit.loadAllPointsData());
                        }
                        CustomSnackBar.show(
                          context,
                          message: 'employee.clock.checkedInSuccess'.tr(
                            context: context,
                          ),
                        );
                      case EmployeeAttendanceStateCheckOutSuccess():
                        final cubit = context.read<EmployeeAttendanceCubit>();
                        unawaited(cubit.loadAttendanceHistory());
                        final pointsCubit = context.read<PointsCubit?>();
                        if (pointsCubit != null) {
                          unawaited(pointsCubit.loadAllPointsData());
                        }
                        CustomSnackBar.show(
                          context,
                          message: 'employee.clock.checkedOutSuccess'.tr(
                            context: context,
                          ),
                        );
                      case EmployeeAttendanceStateError(:final messageKey):
                        CustomSnackBar.show(
                          context,
                          message: messageKey.tr(context: context),
                        );
                      default:
                        break;
                    }
                  },
                  builder: (context, state) {
                    final cubit = context.read<EmployeeAttendanceCubit>();
                    final attendance = cubit.todayAttendance;
                    final profile = cubit.employeeProfile;
                    final isCheckedIn =
                        cubit.hasClockIn(attendance) &&
                        !cubit.hasClockOut(attendance);
                    final hasCheckedOut = cubit.hasClockOut(attendance);
                    final holidayState = context
                        .watch<UpcomingHolidayCubit?>()
                        ?.state;
                    final isHolidayFromCubit =
                        holidayState is UpcomingHolidayStateLoaded &&
                        holidayState.isTodayHoliday;
                    final isTodayHoliday =
                        (profile?.todayHoliday != null &&
                            profile!.todayHoliday!.isHoliday == true) ||
                        isHolidayFromCubit;
                    final isTodayWeeklyOff =
                        profile?.todayWorkMode == 'off' && !isTodayHoliday;
                    final holidayName =
                        profile?.todayHoliday?.arabicName ??
                        profile?.todayHoliday?.name ??
                        (holidayState is UpcomingHolidayStateLoaded
                            ? holidayState.todayHoliday?.name
                            : null);
                    final holidayGreeting =
                        profile?.todayHoliday?.greeting ??
                        profile?.holidayMessage;

                    final isArabic = context.locale.languageCode == 'ar';
                    final policyName =
                        profile?.shiftName ??
                        profile?.workPolicy?.name ??
                        'employee.home.defaultPolicy'.tr(context: context);
                    final rawStart =
                        profile?.todayWorkStart ??
                        profile?.workPolicy?.workingHoursStart ??
                        profile?.clockInTime;
                    final rawEnd =
                        profile?.todayWorkEnd ??
                        profile?.workPolicy?.workingHoursEnd ??
                        profile?.clockOutTime;

                    final policyText = AppDateFormatter.formatPolicySchedule(
                      policyName: policyName,
                      rawStart: rawStart,
                      rawEnd: rawEnd,
                      isArabic: isArabic,
                    );

                    return Skeletonizer(
                      enabled: state is EmployeeAttendanceStateLoading,
                      child: EmployeeClockCardWidget(
                        policyText: policyText,
                        checkInTime: AppDateFormatter.formatTimeString(
                          attendance?.clockInTime,
                          isArabic: isArabic,
                        ),
                        checkOutTime: AppDateFormatter.formatTimeString(
                          attendance?.clockOutTime,
                          isArabic: isArabic,
                        ),
                        isCheckedIn: isCheckedIn,
                        hasCheckedOut: hasCheckedOut,
                        workedHours:
                            cubit.todayWorkedHoursWithOvertime ??
                            attendance?.dayHours,
                        onToggleCheckInOut: _toggleCheckInOut,
                        isTodayHoliday: isTodayHoliday,
                        isTodayWeeklyOff: isTodayWeeklyOff,
                        holidayGreeting: holidayGreeting,
                        holidayName: holidayName,
                      ),
                    );
                  },
                ),
                BlocBuilder<PointsCubit, PointsState>(
                  builder: (context, state) {
                    if (state is PointsLoaded) {
                      return Padding(
                        padding: EdgeInsets.only(top: 16.h),
                        child: PointsTodayCardWidget(
                          summary: state.summary,
                          onTap: () {
                            Navigator.of(context).pushNamed(AppRoutes.myPoints);
                          },
                        ),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
                hSpace(20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'employee.clock.recentAttendance'.tr(context: context),
                      style: AppTextStyles.font18Bold,
                    ),
                    hSpace(12),
                    BlocBuilder<
                      EmployeeAttendanceCubit,
                      EmployeeAttendanceState
                    >(
                      builder: (context, state) {
                        final cubit = context.read<EmployeeAttendanceCubit>();
                        return EmployeeAttendanceFilterWidget(
                          selectedDaysFilter: cubit.selectedDaysFilter,
                          selectedStatusFilters: cubit.selectedStatusFilters,
                          onDaysFilterChanged: cubit.setDaysFilter,
                          onStatusFilterToggled: cubit.toggleStatusFilter,
                          onResetFilters: cubit.resetFilters,
                        );
                      },
                    ),
                    hSpace(12),
                    BlocBuilder<
                      EmployeeAttendanceCubit,
                      EmployeeAttendanceState
                    >(
                      builder: (context, state) {
                        if (state is EmployeeAttendanceStateLoading) {
                          return Skeletonizer(
                            enabled: true,
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppColors.cardBackground,
                                borderRadius: BorderRadius.circular(16.r),
                                border: Border.all(color: AppColors.border),
                              ),
                              child: Column(
                                children: [
                                  for (
                                    int i = 0;
                                    i < _dummyAttendanceRecords.length;
                                    i++
                                  ) ...[
                                    EmployeeAttendanceRecordCardWidget(
                                      record: _dummyAttendanceRecords[i],
                                    ),
                                    if (i < _dummyAttendanceRecords.length - 1)
                                      const Divider(
                                        height: 1,
                                        thickness: 1,
                                        color: AppColors.border,
                                      ),
                                  ],
                                ],
                              ),
                            ),
                          );
                        }

                        final historyRecords = switch (state) {
                          EmployeeAttendanceStateHistoryLoaded(
                            :final history,
                          ) =>
                            history
                                .map(
                                  (item) => EmployeeAttendanceRecordData(
                                    date: AppDateFormatter.formatDateString(
                                      item.attendanceDate,
                                    ),
                                    checkIn: AppDateFormatter.formatTimeString(
                                      item.clockInTime,
                                      use12Hour: true,
                                    ),
                                    checkOut: AppDateFormatter.formatTimeString(
                                      item.clockOutTime,
                                      use12Hour: true,
                                    ),
                                    area: item.area,
                                    status: item.isLate == true
                                        ? 'Late'
                                        : (item.isEarly == true
                                              ? 'Early Leave'
                                              : 'On Time'),
                                    isLate: item.isLate == true,
                                    isEarly: item.isEarly == true,
                                    rawDate: item.attendanceDate,
                                    pointsChip: item.isLate == true
                                        ? '-5'
                                        : (item.isEarly == true ? '-5' : '+5'),
                                    pointsColor: item.isLate == true || item.isEarly == true
                                        ? AppColors.error.value
                                        : AppColors.success.value,
                                  ),
                                )
                                .toList(),
                          _ => const <EmployeeAttendanceRecordData>[],
                        };

                        if (historyRecords.isEmpty) {
                          return Container(
                            padding: EdgeInsets.all(16.r),
                            decoration: BoxDecoration(
                              color: AppColors.cardBackground,
                              borderRadius: BorderRadius.circular(16.r),
                              border: Border.all(color: AppColors.border),
                            ),
                            child: Center(
                              child: Text('employee.attendance.noHistory'.tr()),
                            ),
                          );
                        }

                        return Container(
                          decoration: BoxDecoration(
                            color: AppColors.cardBackground,
                            borderRadius: BorderRadius.circular(16.r),
                            border: Border.all(color: AppColors.border),
                            boxShadow: const [
                              BoxShadow(
                                color: AppColors.shadow,
                                blurRadius: 8,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              for (
                                int i = 0;
                                i < historyRecords.length;
                                i++
                              ) ...[
                                InkWell(
                                  onTap: () {
                                    final pointsState = context.read<PointsCubit?>()?.state;
                                    final pointsForDay = pointsState is PointsLoaded
                                        ? pointsState.history.where((p) {
                                            return p.attendanceDate.startsWith(
                                              historyRecords[i].rawDate ?? '',
                                            );
                                          }).toList()
                                        : <PointsHistoryItemModel>[];
                                    PointsDayDetailsSheetWidget.show(
                                      context,
                                      recordDate: historyRecords[i].date,
                                      dayPoints: pointsForDay,
                                    );
                                  },
                                  child: EmployeeAttendanceRecordCardWidget(
                                    record: historyRecords[i],
                                  ),
                                ),
                                if (i < historyRecords.length - 1)
                                  const Divider(
                                    height: 1,
                                    thickness: 1,
                                    color: AppColors.border,
                                  ),
                              ],
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
