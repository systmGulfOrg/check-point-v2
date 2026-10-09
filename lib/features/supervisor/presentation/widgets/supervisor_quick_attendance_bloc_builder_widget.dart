import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/employee/presentation/cubit/attendance/employee_attendance_cubit.dart';
import 'package:check_point_v2/features/employee/presentation/cubit/attendance/employee_attendance_state.dart';
import 'package:check_point_v2/features/employee/presentation/widgets/employee_attendance_location_sheet_widget.dart';
import 'package:check_point_v2/features/leaves/presentation/cubit/upcoming_holiday/upcoming_holiday_cubit.dart';
import 'package:check_point_v2/features/leaves/presentation/cubit/upcoming_holiday/upcoming_holiday_state.dart';

/// Quick clock in / clock out button shown directly on the supervisor home.
class SupervisorQuickAttendanceBlocBuilderWidget extends StatelessWidget {
  const SupervisorQuickAttendanceBlocBuilderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EmployeeAttendanceCubit, EmployeeAttendanceState>(
      builder: (context, state) {
        final cubit = context.read<EmployeeAttendanceCubit>();
        final profile = cubit.employeeProfile;
        final attendance = cubit.todayAttendance;
        final hasIn = cubit.hasClockIn(attendance);
        final hasOut = cubit.hasClockOut(attendance);
        final holidayState = context.read<UpcomingHolidayCubit?>()?.state;
        final isHoliday = holidayState is UpcomingHolidayStateLoaded
            ? holidayState.isTodayHoliday
            : (profile?.todayHoliday?.isHoliday == true);
        final isWeeklyOff = profile?.todayWorkMode == 'off' && !isHoliday;

        // Hide quick attendance on holiday or weekly off if employee hasn't checked in yet
        if (!hasIn && (isHoliday || isWeeklyOff)) {
          return const SizedBox.shrink();
        }

        if (hasIn && hasOut) return const SizedBox.shrink();
        final isCheckOut = hasIn && !hasOut;

        return CustomButton(
          text:
              (isCheckOut
                      ? 'employee.home.checkOutAction'
                      : 'employee.home.checkInAction')
                  .tr(context: context),
          icon: isCheckOut ? Icons.logout_rounded : Icons.login_rounded,
          backgroundColor: isCheckOut
              ? AppColors.error
              : AppColors.brandPrimary,
          isLoading: state is EmployeeAttendanceStateLoading,
          onTap: () {
            if (isHoliday) {
              final holidayName =
                  (holidayState is UpcomingHolidayStateLoaded
                      ? holidayState.todayHoliday?.name
                      : null) ??
                  profile?.todayHoliday?.arabicName ??
                  profile?.todayHoliday?.name ??
                  '';
              showDialog<void>(
                context: context,
                builder: (ctx) => CustomDialogWidget(
                  title: 'holidays.todayHolidayTitle'.tr(context: ctx),
                  message:
                      '${'holidays.todayHolidayTitle'.tr(context: ctx)}: $holidayName\n${'holidays.todayHolidayGreeting'.tr(context: ctx)}\n${'holidays.attendanceNotAllowed'.tr(context: ctx)}',
                  confirmLabel: 'common.gotIt'.tr(context: ctx),
                  onConfirm: () => Navigator.of(ctx).pop(),
                  icon: Icons.celebration_rounded,
                  iconColor: AppColors.success,
                  confirmButtonColor: AppColors.success,
                ),
              );
              return;
            }
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
                  iconColor: AppColors.textSecondary,
                  confirmButtonColor: AppColors.brandPrimary,
                ),
              );
              return;
            }
            showModalBottomSheet<void>(
              context: context,
              isScrollControlled: true,
              useSafeArea: true,
              constraints: BoxConstraints.tightFor(
                height: MediaQuery.sizeOf(context).height,
              ),
              backgroundColor: AppColors.cardBackground,
              builder: (_) => BlocProvider.value(
                value: cubit,
                child: EmployeeAttendanceLocationSheetWidget(
                  isCheckOut: isCheckOut,
                ),
              ),
            );
          },
        );
      },
    );
  }
}
