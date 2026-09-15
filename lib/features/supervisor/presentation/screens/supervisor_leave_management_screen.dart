import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/employee/presentation/widgets/apply_for_leave_sheet_widget.dart';
import 'package:check_point_v2/features/supervisor/presentation/cubit/leave_requests/supervisor_leave_requests_cubit.dart';
import 'package:check_point_v2/features/leaves/presentation/cubit/leaves_cubit.dart';
import 'package:check_point_v2/features/leaves/presentation/cubit/leaves_state.dart';
import 'package:check_point_v2/features/leaves/presentation/widgets/leave_balances_list_widget.dart';
import 'package:check_point_v2/features/supervisor/presentation/widgets/supervisor_leave_management_filter_widget.dart';
import 'package:check_point_v2/features/supervisor/presentation/widgets/supervisor_leave_requests_bloc_builder_widget.dart';

class SupervisorLeaveManagementScreen extends StatefulWidget {
  const SupervisorLeaveManagementScreen({super.key});

  @override
  State<SupervisorLeaveManagementScreen> createState() =>
      _SupervisorLeaveManagementScreenState();
}

class _SupervisorLeaveManagementScreenState
    extends State<SupervisorLeaveManagementScreen> {
  int selectedFilter = 0;

  @override
  void initState() {
    super.initState();
    context.read<SupervisorLeaveRequestsCubit>().loadLeaveTypes();
    context.read<LeavesCubit>().loadDashboardData();
  }

  void _showApplyLeaveSheet(BuildContext context) {
    final cubit = context.read<SupervisorLeaveRequestsCubit>();
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.transparent,
      builder: (_) => ApplyForLeaveSheetWidget(
        leaveTypes: cubit.leaveTypes,
        onSubmit: ({
          required startDate,
          required endDate,
          required reason,
          required remark,
          required leaveRequestType,
        }) {
          cubit.submitLeaveRequest(
            startDate: startDate,
            endDate: endDate,
            reason: reason,
            remark: remark,
            leaveRequestType: leaveRequestType,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        title: Text(
          'supervisor.leaveManagement.title'.tr(context: context),
          style: AppTextStyles.font18Bold,
        ),
        actions: [
          IconButton(
            onPressed: () => _showApplyLeaveSheet(context),
            icon: const Icon(Icons.add_circle_outline_rounded),
            tooltip: 'employee.leaves.applyTitle'.tr(context: context),
          ),
        ],
      ),
      body: SafeArea(
        child: RefreshIndicator(
          color: AppColors.brandPrimary,
          onRefresh: context.read<SupervisorLeaveRequestsCubit>().loadRequests,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.fromLTRB(16.w, 4.h, 16.w, 24.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BlocBuilder<LeavesCubit, LeavesState>(
                  builder: (context, state) {
                    return state.maybeWhen(
                      success: (balances, types) {
                        if (balances.isEmpty) return const SizedBox.shrink();
                        return Container(
                          height: 200.h,
                          margin: EdgeInsets.only(bottom: 16.h),
                          child: LeaveBalancesListWidget(balances: balances),
                        );
                      },
                      orElse: () => const SizedBox.shrink(),
                    );
                  },
                ),
                SupervisorLeaveManagementFilterWidget(
                  selectedIndex: selectedFilter,
                  onFilterSelected: (index) =>
                      setState(() => selectedFilter = index),
                ),
                hSpace(16),
                SupervisorLeaveRequestsBlocBuilderWidget(
                  selectedFilterIndex: selectedFilter,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
