import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/supervisor/presentation/cubit/attendance/supervisor_attendance_cubit.dart';
import 'package:check_point_v2/features/supervisor/presentation/cubit/team/supervisor_team_cubit.dart';
import 'package:check_point_v2/features/supervisor/presentation/widgets/supervisor_clock_in_employee_sheet_widget.dart';
import 'package:check_point_v2/features/supervisor/presentation/widgets/supervisor_attendance_permission_gate_widget.dart';

class SupervisorAttendanceScreen extends StatefulWidget {
  const SupervisorAttendanceScreen({super.key});

  @override
  State<SupervisorAttendanceScreen> createState() =>
      _SupervisorAttendanceScreenState();
}

class _SupervisorAttendanceScreenState
    extends State<SupervisorAttendanceScreen> {
  int selectedTab = 0;
  DateTime selectedDate = DateTime.now();

  void _onDateChanged(DateTime newDate) {
    setState(() => selectedDate = newDate);
    final formatted = AppDateFormatter.formatYearMonthDay(newDate);
    context.read<SupervisorAttendanceCubit>().loadAttendance(date: formatted);
  }

  void _openClockInSheet() {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.cardBackground,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => MultiBlocProvider(
        providers: [
          BlocProvider.value(value: context.read<SupervisorAttendanceCubit>()),
          BlocProvider.value(value: context.read<SupervisorTeamCubit>()),
        ],
        child: const SupervisorClockInEmployeeSheetWidget(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: RefreshIndicator(
        color: AppColors.brandPrimary,
        onRefresh: () =>
            context.read<SupervisorAttendanceCubit>().loadAttendance(
              date: AppDateFormatter.formatYearMonthDay(selectedDate),
            ),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'supervisor.nav.attendance'.tr(context: context),
                    style: AppTextStyles.font20Bold.copyWith(
                      color: AppColors.textPrimary,
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.offline_pin_outlined,
                          color: AppColors.brandPrimary,
                        ),
                        tooltip: 'offline.pendingVerificationTitle'.tr(
                          context: context,
                        ),
                        onPressed: () => Navigator.pushNamed(
                          context,
                          AppRoutes.pendingAttendanceVerification,
                        ),
                      ),
                      Image.asset(
                        AppAssets.logo,
                        height: 32.h,
                        fit: BoxFit.contain,
                      ),
                    ],
                  ),
                ],
              ),
              SupervisorAttendancePermissionGateWidget(
                selectedDate: selectedDate,
                selectedTab: selectedTab,
                onDateChanged: _onDateChanged,
                onTabSelected: (index) => setState(() => selectedTab = index),
                onAddPressed: _openClockInSheet,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
