import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/employee_profile/admin_employee_profile_cubit.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/employee_profile/admin_employee_profile_state.dart';
import 'admin_employee_profile_attendance_tab_widget.dart';
import 'admin_employee_profile_header_widget.dart';
import 'admin_employee_profile_job_tab_widget.dart';
import 'admin_employee_profile_payroll_tab_widget.dart';
import 'admin_employee_profile_security_tab_widget.dart';
import 'admin_employee_profile_skeleton_widget.dart';

class AdminEmployeeProfileBlocBuilderWidget extends StatefulWidget {
  const AdminEmployeeProfileBlocBuilderWidget({super.key});

  @override
  State<AdminEmployeeProfileBlocBuilderWidget> createState() =>
      _AdminEmployeeProfileBlocBuilderWidgetState();
}

class _AdminEmployeeProfileBlocBuilderWidgetState
    extends State<AdminEmployeeProfileBlocBuilderWidget>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

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
                  Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 8.h,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.cardBackground,
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: TabBar(
                      controller: _tabController,
                      isScrollable: true,
                      labelColor: AppColors.brandPrimary,
                      unselectedLabelColor: AppColors.textSecondary,
                      labelStyle: AppTextStyles.font13SemiBold,
                      unselectedLabelStyle: AppTextStyles.font13Medium,
                      indicatorColor: AppColors.brandPrimary,
                      indicatorWeight: 3,
                      tabAlignment: TabAlignment.start,
                      tabs: [
                        Tab(
                          icon: const Icon(Icons.badge_outlined),
                          text: 'employee.profile.tabJobPersonal'.tr(
                            context: context,
                          ),
                        ),
                        Tab(
                          icon: const Icon(Icons.event_available_outlined),
                          text: 'employee.profile.tabAttendanceLeaves'.tr(
                            context: context,
                          ),
                        ),
                        Tab(
                          icon: const Icon(
                            Icons.account_balance_wallet_outlined,
                          ),
                          text: 'employee.profile.tabPayroll'.tr(
                            context: context,
                          ),
                        ),
                        Tab(
                          icon: const Icon(Icons.verified_user_outlined),
                          text: 'employee.profile.tabDocsSecurity'.tr(
                            context: context,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        AdminEmployeeProfileJobTabWidget(employee: employee),
                        AdminEmployeeProfileAttendanceTabWidget(
                          attendance: attendance,
                          selectedMonth: selectedMonth,
                          attendedDays: attendedDays,
                          absentDays: absentDays,
                          lateDays: lateDays,
                          earlyLeaveDays: earlyLeaveDays,
                          totalHours: totalHours,
                          leaveBalances: leaveBalances,
                          leaveRequests: leaveRequests,
                          permissions: permissions,
                          onMonthChanged: (m) => context
                              .read<AdminEmployeeProfileCubit>()
                              .setMonth(m),
                        ),
                        AdminEmployeeProfilePayrollTabWidget(
                          employee: employee,
                        ),
                        AdminEmployeeProfileSecurityTabWidget(
                          employee: employee,
                          devices: devicesHistory,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
        );
      },
    );
  }
}
