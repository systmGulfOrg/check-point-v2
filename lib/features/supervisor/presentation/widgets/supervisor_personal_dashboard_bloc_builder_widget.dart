import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/employee/presentation/cubit/attendance/employee_attendance_cubit.dart';
import 'package:check_point_v2/features/employee/presentation/cubit/attendance/employee_attendance_state.dart';
import 'package:check_point_v2/features/leaves/presentation/cubit/upcoming_holiday/upcoming_holiday_cubit.dart';
import 'package:check_point_v2/features/leaves/presentation/cubit/upcoming_holiday/upcoming_holiday_state.dart';
import 'package:check_point_v2/features/employee/presentation/widgets/employee_attendance_location_sheet_widget.dart';
import 'package:check_point_v2/features/admin/presentation/widgets/admin_greeting_widget.dart';
import 'supervisor_personal_summary_widget.dart';

class SupervisorPersonalDashboardBlocBuilderWidget extends StatelessWidget {
  const SupervisorPersonalDashboardBlocBuilderWidget({super.key});

  void _toggleCheckInOut(BuildContext context) {
    final cubit = context.read<EmployeeAttendanceCubit>();
    final profile = cubit.employeeProfile;
    final holidayState = context.read<UpcomingHolidayCubit?>()?.state;
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
    return BlocBuilder<EmployeeAttendanceCubit, EmployeeAttendanceState>(
      builder: (context, state) {
        final cubit = context.read<EmployeeAttendanceCubit>();
        final profile = cubit.employeeProfile;
        final attendance = cubit.todayAttendance;
        final workStart =
            profile?.todayWorkStart ??
            profile?.workPolicy?.workingHoursStart ??
            profile?.clockInTime;
        final workEnd =
            profile?.todayWorkEnd ??
            profile?.workPolicy?.workingHoursEnd ??
            profile?.clockOutTime;
        final workSystem = profile?.workSystem ?? 'onsite';
        final workMode = profile?.todayWorkMode ?? 'onsite';
        final isLoading = state is EmployeeAttendanceStateLoading;
        final isCheckedIn =
            cubit.hasClockIn(attendance) && !cubit.hasClockOut(attendance);
        final hasCheckedOut = cubit.hasClockOut(attendance);

        return Skeletonizer(
          enabled: isLoading,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AdminGreetingWidget(
                greetingKey: 'supervisor.dashboard.greeting',
                userNameKey: 'supervisor.dashboard.user',
                userName: profile?.name,
                dateText: AppDateFormatter.formatFullDate(DateTime.now()),
              ),
              hSpace(20),
              SupervisorPersonalSummaryWidget(
                policyName:
                    profile?.shiftName ??
                    profile?.workPolicy?.name ??
                    'employee.home.defaultPolicy'.tr(context: context),
                workSystem: workSystem.tr(context: context),
                workMode: workMode.tr(context: context),
                workStart: AppDateFormatter.formatTimeString(workStart),
                workEnd: AppDateFormatter.formatTimeString(workEnd),
                checkIn: AppDateFormatter.formatTimeString(
                  attendance?.clockInTime,
                ),
                checkOut: AppDateFormatter.formatTimeString(
                  attendance?.clockOutTime,
                ),
                leaveBalance: '${profile?.leaveBalance ?? '--'}',
                isCheckedIn: isCheckedIn,
                hasCheckedOut: hasCheckedOut,
                onToggleCheckInOut: () => _toggleCheckInOut(context),
              ),
            ],
          ),
        );
      },
    );
  }
}
