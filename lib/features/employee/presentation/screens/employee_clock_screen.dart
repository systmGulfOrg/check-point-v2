import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

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

class EmployeeClockScreen extends StatefulWidget {
  const EmployeeClockScreen({super.key});

  @override
  State<EmployeeClockScreen> createState() => _EmployeeClockScreenState();
}

class _EmployeeClockScreenState extends State<EmployeeClockScreen> {
  @override
  void initState() {
    super.initState();
    context.read<EmployeeAttendanceCubit>().loadAttendanceHistory();
  }

  void _toggleCheckInOut() {
    final cubit = context.read<EmployeeAttendanceCubit>();
    final profile = cubit.employeeProfile;
    final holidayState = context.read<UpcomingHolidayCubit>().state;
    final isHoliday = (profile?.todayHoliday != null &&
            profile!.todayHoliday!.isHoliday == true) ||
        (profile?.todayWorkMode == 'off' && profile?.todayHoliday != null) ||
        (holidayState is UpcomingHolidayStateLoaded &&
            holidayState.isTodayHoliday);

    if (isHoliday) {
      final holidayName = profile?.todayHoliday?.arabicName ??
          profile?.todayHoliday?.name ??
          (holidayState is UpcomingHolidayStateLoaded
              ? holidayState.todayHoliday?.name
              : null) ??
          '';
      final holidayGreeting = profile?.todayHoliday?.greeting ??
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
                        final cubit = context.read<EmployeeAttendanceCubit>();
                        unawaited(cubit.loadAttendanceHistory());
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
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(messageKey.tr(context: context)),
                          ),
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
                    return EmployeeClockCardWidget(
                      policyText:
                          '${profile?.shiftName ?? 'employee.home.defaultPolicy'.tr(context: context)} — '
                          '${AppDateFormatter.formatTimeString(profile?.clockInTime)}–${AppDateFormatter.formatTimeString(profile?.clockOutTime)}',
                      checkInTime: AppDateFormatter.formatTimeString(
                        attendance?.clockInTime,
                      ),
                      checkOutTime: AppDateFormatter.formatTimeString(
                        attendance?.clockOutTime,
                      ),
                      isCheckedIn: isCheckedIn,
                      hasCheckedOut: hasCheckedOut,
                      workedHours: attendance?.dayHours,
                      onToggleCheckInOut: _toggleCheckInOut,
                    );
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
                                EmployeeAttendanceRecordCardWidget(
                                  record: historyRecords[i],
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
