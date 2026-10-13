import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/core/di/service_locator.dart';
import 'package:check_point_v2/features/admin/data/models/leave_requests/leave_type_model.dart'
    as admin_lt;
import 'package:check_point_v2/features/employee/presentation/cubit/attendance/employee_attendance_cubit.dart';
import 'package:check_point_v2/features/employee/presentation/cubit/attendance/employee_attendance_state.dart';
import 'package:check_point_v2/features/employee/presentation/widgets/apply_for_leave_sheet_widget.dart';
import 'package:check_point_v2/features/employee/presentation/widgets/apply_for_permission_sheet_widget.dart';
import 'package:check_point_v2/features/employee/presentation/widgets/employee_attendance_location_sheet_widget.dart';
import 'package:check_point_v2/features/employee/presentation/widgets/employee_home_header_bloc_builder_widget.dart';
import 'package:check_point_v2/features/employee/presentation/widgets/employee_home_leaves_bloc_builder_widget.dart';
import 'package:check_point_v2/features/employee/presentation/widgets/employee_home_quick_actions_widget.dart';
import 'package:check_point_v2/features/employee/presentation/widgets/employee_home_request_shortcuts_widget.dart';
import 'package:check_point_v2/features/employee/presentation/widgets/employee_today_card_widget.dart';
import 'package:check_point_v2/features/leaves/data/models/leave_request_body.dart';
import 'package:check_point_v2/features/leaves/presentation/cubit/leaves_cubit.dart';
import 'package:check_point_v2/features/leaves/presentation/cubit/permit_cubit.dart';
import 'package:check_point_v2/features/leaves/presentation/cubit/upcoming_holiday/upcoming_holiday_cubit.dart';
import 'package:check_point_v2/features/leaves/presentation/cubit/upcoming_holiday/upcoming_holiday_state.dart';
import 'package:check_point_v2/features/leaves/presentation/widgets/upcoming_holiday_card_bloc_builder_widget.dart';
import 'package:check_point_v2/features/attendance_points/presentation/cubit/points_cubit.dart';
import 'package:check_point_v2/features/attendance_points/presentation/cubit/points_state.dart';
import 'package:check_point_v2/features/attendance_points/presentation/widgets/points_today_card_widget.dart';

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
    context.read<LeavesCubit>().loadLeavesData();
  }

  void _showApplyLeaveSheet(BuildContext context) {
    final cubit = context.read<LeavesCubit>();
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.transparent,
      builder: (_) => ApplyForLeaveSheetWidget(
        leaveTypes: cubit.leaveTypes
            .map(
              (t) => admin_lt.LeaveTypeModel(
                id: int.tryParse(t.id),
                typeName: t.typeName,
                isPaid: t.isPaid,
                requiresAttachment: t.requiresAttachment,
                maxDaysPerYear: t.maxDaysPerYear,
                isCasual: t.isCasual,
              ),
            )
            .toList(),
        onSubmit:
            ({
              required startDate,
              required endDate,
              required reason,
              required remark,
              required leaveRequestType,
              attachmentUrl,
            }) {
              cubit.submitLeave(
                LeaveRequestBody(
                  leaveTypeId: leaveRequestType,
                  startDate: DateTime.parse(startDate),
                  endDate: DateTime.parse(endDate),
                  reason: reason,
                  attachmentUrl: attachmentUrl,
                ),
              );
            },
      ),
    );
  }

  void _showApplyPermissionSheet(BuildContext context) {
    final profile = context.read<EmployeeAttendanceCubit>().employeeProfile;
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.transparent,
      builder: (_) => ApplyForPermissionSheetWidget(
        shiftStart:
            profile?.todayWorkStart ?? profile?.workPolicy?.workingHoursStart,
        shiftEnd: profile?.todayWorkEnd ?? profile?.workPolicy?.workingHoursEnd,
        allowedLateMinutes:
            profile?.todayAllowedDelayTime ??
            profile?.workPolicy?.allowedDelayTime,
        onSubmit: (body) async {
          final permitCubit = sl<PermitCubit>();
          final success = await permitCubit.submit(body);
          if (success && context.mounted) {
            CustomSnackBar.showSuccess(
              context,
              message: 'permissions.request.success'.tr(),
            );
            context.read<LeavesCubit>().loadLeavesData();
          }
        },
      ),
    );
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
              context.read<LeavesCubit>().loadLeavesData(),
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
                      child: EmployeeTodayCardWidget(
                        policyText: policyText,
                        isOnTime: attendance?.isLate != true,
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
                        workedHours: attendance?.dayHours,
                        leaveBalance: profile?.leaveBalance,
                        workModeText: workMode.tr(context: context),
                        workSystemText: workSystem.tr(context: context),
                        onToggleCheckInOut: _toggleCheckInOut,
                        isTodayHoliday: isTodayHoliday,
                        isTodayWeeklyOff: isTodayWeeklyOff,
                        holidayGreeting: holidayGreeting,
                        holidayName: holidayName,
                      ),
                    );
                  },
                ),
                hSpace(12),
                const EmployeeHomeRequestShortcutsWidget(),
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
                EmployeeHomeQuickActionsWidget(
                  onRequestLeave: () => _showApplyLeaveSheet(context),
                  onRequestPermission: () => _showApplyPermissionSheet(context),
                  onCustomerVisitsTap: () =>
                      Navigator.pushNamed(context, AppRoutes.adminLocations),
                ),
                hSpace(20),
                EmployeeHomeLeavesBlocBuilderWidget(
                  onViewAllLeaves: () =>
                      Navigator.pushNamed(context, AppRoutes.leavesDashboard),
                  onRequestLeave: () => _showApplyLeaveSheet(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
