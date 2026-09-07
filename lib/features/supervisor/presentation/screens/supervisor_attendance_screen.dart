import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/core.dart';
import '../cubit/supervisor_attendance_cubit.dart';
import '../cubit/supervisor_team_cubit.dart';
import '../widgets/supervisor_attendance_bloc_builder_widget.dart';
import '../widgets/supervisor_attendance_date_bar_widget.dart';
import '../widgets/supervisor_attendance_filter_widget.dart';
import '../widgets/supervisor_clock_in_employee_sheet_widget.dart';
import '../widgets/supervisor_leave_requests_bloc_builder_widget.dart';

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
      child: SingleChildScrollView(
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
                Image.asset(AppAssets.logo, height: 32.h, fit: BoxFit.contain),
              ],
            ),
            hSpace(16),
            SupervisorAttendanceDateBarWidget(
              selectedDate: selectedDate,
              onDateChanged: _onDateChanged,
              onAddPressed: _openClockInSheet,
            ),
            hSpace(16),
            SupervisorAttendanceFilterWidget(
              selectedIndex: selectedTab,
              onTabSelected: (index) => setState(() => selectedTab = index),
            ),
            hSpace(16),
            if (selectedTab < 3)
              SupervisorAttendanceBlocBuilderWidget(
                selectedFilterIndex: selectedTab,
              )
            else
              const SupervisorLeaveRequestsBlocBuilderWidget(
                selectedFilterIndex: 0,
              ),
          ],
        ),
      ),
    );
  }
}
