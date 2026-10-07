import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/employee/presentation/cubit/attendance/employee_attendance_cubit.dart';
import 'package:check_point_v2/features/employee/presentation/cubit/attendance/employee_attendance_state.dart';
import 'package:check_point_v2/features/employee/presentation/widgets/employee_home_header_bloc_builder_widget.dart';
import 'package:check_point_v2/features/employee/presentation/widgets/employee_today_card_widget.dart';
import 'package:check_point_v2/features/employee/presentation/widgets/employee_attendance_location_sheet_widget.dart';
import 'package:check_point_v2/features/leaves/presentation/cubit/upcoming_holiday/upcoming_holiday_cubit.dart';
import 'package:check_point_v2/features/leaves/presentation/cubit/upcoming_holiday/upcoming_holiday_state.dart';
import 'package:check_point_v2/features/leaves/presentation/widgets/upcoming_holiday_card_bloc_builder_widget.dart';

class EmployeeHomeScreen extends StatefulWidget {
  const EmployeeHomeScreen({super.key});

  @override
  State<EmployeeHomeScreen> createState() => _EmployeeHomeScreenState();
}

class _EmployeeHomeScreenState extends State<EmployeeHomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<EmployeeAttendanceCubit>().loadAttendanceHistory();
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
                const EmployeeHomeHeaderBlocBuilderWidget(),
                hSpace(16),
                const UpcomingHolidayCardBlocBuilderWidget(),
                hSpace(16),
                BlocConsumer<EmployeeAttendanceCubit, EmployeeAttendanceState>(
                  listener: (context, state) {
                    switch (state) {
                      case EmployeeAttendanceStateCheckInSuccess():
                        unawaited(
                          context
                              .read<EmployeeAttendanceCubit>()
                              .loadAttendanceHistory(),
                        );
                        CustomSnackBar.show(
                          context,
                          message: 'employee.clock.checkedInSuccess'.tr(
                            context: context,
                          ),
                        );
                      case EmployeeAttendanceStateCheckOutSuccess():
                        unawaited(
                          context
                              .read<EmployeeAttendanceCubit>()
                              .loadAttendanceHistory(),
                        );
                        CustomSnackBar.show(
                          context,
                          message: 'employee.clock.checkedOutSuccess'.tr(
                            context: context,
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
                    final holidayState = context
                        .watch<UpcomingHolidayCubit?>()
                        ?.state;
                    final isHolidayFromCubit =
                        holidayState is UpcomingHolidayStateLoaded &&
                        holidayState.isTodayHoliday;
                    final isTodayHoliday =
                        (profile?.todayHoliday != null &&
                            profile!.todayHoliday!.isHoliday == true) ||
                        (profile?.todayWorkMode == 'off' &&
                            profile?.todayHoliday != null) ||
                        isHolidayFromCubit;
                    final holidayName =
                        profile?.todayHoliday?.arabicName ??
                        profile?.todayHoliday?.name ??
                        (holidayState is UpcomingHolidayStateLoaded
                            ? holidayState.todayHoliday?.name
                            : null);
                    final holidayGreeting =
                        profile?.todayHoliday?.greeting ??
                        profile?.holidayMessage;

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
                        isTodayHoliday: isTodayHoliday,
                        holidayGreeting: holidayGreeting,
                        holidayName: holidayName,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
