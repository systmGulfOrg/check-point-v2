import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/employee/presentation/widgets/apply_for_leave_sheet_widget.dart';
import 'package:check_point_v2/features/supervisor/presentation/cubit/leave_requests/supervisor_leave_requests_cubit.dart';
import 'package:check_point_v2/features/supervisor/presentation/cubit/leave_requests/supervisor_leave_requests_state.dart';
import 'package:check_point_v2/features/leaves/presentation/cubit/leaves_cubit.dart';
import 'package:check_point_v2/features/leaves/presentation/cubit/leaves_state.dart';
import 'package:check_point_v2/features/leaves/presentation/widgets/leave_balances_list_widget.dart';
import 'package:check_point_v2/features/leaves/presentation/widgets/leave_status_filter_widget.dart';
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
    final cubit = context.read<SupervisorLeaveRequestsCubit>();
    cubit.loadLeaveTypes();
    cubit.loadRequests();
    context.read<LeavesCubit>().loadLeavesData();
  }

  void _showApplyLeaveSheet(BuildContext context) {
    final cubit = context.read<SupervisorLeaveRequestsCubit>();
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.transparent,
      builder: (_) => ApplyForLeaveSheetWidget(
        leaveTypes: cubit.leaveTypes,
        onSubmit:
            ({
              required startDate,
              required endDate,
              required reason,
              required remark,
              required leaveRequestType,
              attachmentUrl,
            }) {
              cubit.submitLeaveRequest(
                startDate: startDate,
                endDate: endDate,
                reason: reason,
                remark: remark,
                leaveRequestType: leaveRequestType,
                attachmentUrl: attachmentUrl,
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
      ),
      body: SafeArea(
        child: BlocListener<
          SupervisorLeaveRequestsCubit,
          SupervisorLeaveRequestsState
        >(
          listener: (context, state) {
            state.maybeWhen(
              error: (messageKey) {
                CustomSnackBar.showError(
                  context,
                  message: messageKey.tr(context: context),
                );
              },
              actionSuccess: (message) {
                CustomSnackBar.showSuccess(
                  context,
                  message: message.tr(context: context),
                );
              },
              orElse: () {},
            );
          },
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
                        success: (balances, types, requests) {
                          if (balances.isEmpty) return const SizedBox.shrink();
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'leaves.dashboard.balanceTitle'.tr(
                                  context: context,
                                ),
                                style: AppTextStyles.font16Bold,
                              ),
                              hSpace(8),
                              Padding(
                                padding: EdgeInsets.only(bottom: 16.h),
                                child: LeaveBalancesListWidget(
                                  balances: balances,
                                ),
                              ),
                            ],
                          );
                        },
                        orElse: () => const SizedBox.shrink(),
                      );
                    },
                  ),
                  LeaveStatusFilterWidget(
                    selectedIndex: selectedFilter,
                    pendingCount: context
                        .read<SupervisorLeaveRequestsCubit>()
                        .pendingCount,
                    onSelected: (index) =>
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
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton.extended(
            heroTag: 'supervisorPermissionBtn',
            onPressed: () =>
                Navigator.pushNamed(context, AppRoutes.permissionsRequest),
            backgroundColor: AppColors.brandSecondary,
            icon: const Icon(Icons.timer),
            label: Text('leaves.dashboard.requestPermission'.tr()),
          ),
          SizedBox(height: 12.h),
          FloatingActionButton.extended(
            heroTag: 'supervisorLeaveBtn',
            onPressed: () => _showApplyLeaveSheet(context),
            backgroundColor: AppColors.brandPrimary,
            icon: const Icon(Icons.add),
            label: Text('leaves.dashboard.requestLeave'.tr()),
          ),
        ],
      ),
    );
  }
}
