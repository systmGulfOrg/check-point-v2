import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/auth/presentation/cubit/profile/auth_profile_cubit.dart';
import 'supervisor_attendance_bloc_builder_widget.dart';
import 'supervisor_attendance_date_bar_widget.dart';
import 'supervisor_attendance_filter_widget.dart';
import 'supervisor_leave_requests_bloc_builder_widget.dart';

class SupervisorAttendancePermissionGateWidget extends StatelessWidget {
  const SupervisorAttendancePermissionGateWidget({
    required this.selectedDate,
    required this.selectedTab,
    required this.onDateChanged,
    required this.onTabSelected,
    required this.onAddPressed,
    super.key,
  });

  final DateTime selectedDate;
  final int selectedTab;
  final ValueChanged<DateTime> onDateChanged;
  final ValueChanged<int> onTabSelected;
  final VoidCallback onAddPressed;

  @override
  Widget build(BuildContext context) {
    final permissions = context.select<AuthProfileCubit, List<String>>(
      (cubit) => cubit.state.maybeWhen(
        success: (
          name,
          userId,
          role,
          username,
          permissions,
        ) => permissions,
        orElse: () => const [],
      ),
    );
    final canEditAttendance = AppPermissions.has(
      permissions,
      AppPermissions.attendanceEdit,
    );
    if (!AppPermissions.has(permissions, AppPermissions.attendanceViewTeam) &&
        !AppPermissions.has(permissions, AppPermissions.attendanceViewAll)) {
      return Padding(
        padding: EdgeInsets.only(top: 36.h),
        child: Center(
          child: Text(
            'errors.noPermission'.tr(context: context),
            textAlign: TextAlign.center,
            style: AppTextStyles.font14Regular.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ),
      );
    }

    return Column(
      children: [
        SupervisorAttendanceDateBarWidget(
          selectedDate: selectedDate,
          onDateChanged: onDateChanged,
          onAddPressed: canEditAttendance ? onAddPressed : null,
        ),
        hSpace(16),
        SupervisorAttendanceFilterWidget(
          selectedIndex: selectedTab,
          onTabSelected: onTabSelected,
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
    );
  }
}
