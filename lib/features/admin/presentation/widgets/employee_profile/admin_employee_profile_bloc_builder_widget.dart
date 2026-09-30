import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/employee_profile/admin_employee_profile_cubit.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/employee_profile/admin_employee_profile_state.dart';
import 'admin_employee_profile_header_widget.dart';
import 'admin_employee_profile_job_tab_widget.dart';
import 'admin_employee_profile_skeleton_widget.dart';

class AdminEmployeeProfileBlocBuilderWidget extends StatefulWidget {
  const AdminEmployeeProfileBlocBuilderWidget({super.key});

  @override
  State<AdminEmployeeProfileBlocBuilderWidget> createState() =>
      _AdminEmployeeProfileBlocBuilderWidgetState();
}

class _AdminEmployeeProfileBlocBuilderWidgetState
    extends State<AdminEmployeeProfileBlocBuilderWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdminEmployeeProfileCubit, AdminEmployeeProfileState>(
      builder: (context, state) {
        return state.when(
          initial: () => const AdminEmployeeProfileSkeletonWidget(),
          loading: () => const AdminEmployeeProfileSkeletonWidget(),
          error: (messageKey) => Center(
            child: Padding(
              padding: EdgeInsets.all(24.r),
              child: Text(
                messageKey.tr(context: context),
                style: AppTextStyles.font14Regular.copyWith(
                  color: AppColors.error,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          success:
              (
                employee,
                attendance,
                selectedMonth,
                attendedDays,
                absentDays,
                lateDays,
                earlyLeaveDays,
                totalHours,
                devicesHistory,
                leaveRequests,
                leaveBalances,
                permissions,
              ) => Column(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 8.h),
                    child: AdminEmployeeProfileHeaderWidget(employee: employee),
                  ),
                  Expanded(
                    child: AdminEmployeeProfileJobTabWidget(employee: employee),
                  ),
                ],
              ),
        );
      },
    );
  }
}
