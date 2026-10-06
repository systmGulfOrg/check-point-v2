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
    context.read<SupervisorLeaveRequestsCubit>().loadLeaveTypes();
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
            }) async {
              await cubit.submitLeaveRequest(
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
                              'leaves.dashboard.balanceTitle'.tr(context: context),
                              style: AppTextStyles.font16Bold,
                            ),
                            hSpace(8),
                            Padding(
                              padding: EdgeInsets.only(bottom: 16.h),
                              child: LeaveBalancesListWidget(balances: balances),
                            ),
                          ],
                        );
                      },
                      orElse: () => const SizedBox.shrink(),
                    );
                  },
                ),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () => _showApplyLeaveSheet(context),
                        borderRadius: BorderRadius.circular(10.r),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 10.h,
                            horizontal: 10.w,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.softBrandBackground,
                            borderRadius: BorderRadius.circular(10.r),
                            border: Border.all(
                              color: AppColors.brandPrimary.withValues(
                                alpha: 0.3,
                              ),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.add_rounded,
                                size: 18.r,
                                color: AppColors.brandPrimary,
                              ),
                              wSpace(4),
                              Flexible(
                                child: Text(
                                  'leaves.dashboard.requestLeave'.tr(
                                    context: context,
                                  ),
                                  style: AppTextStyles.font13SemiBold.copyWith(
                                    color: AppColors.brandPrimary,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    wSpace(10),
                    Expanded(
                      child: InkWell(
                        onTap: () => Navigator.pushNamed(
                          context,
                          AppRoutes.permissionsRequest,
                        ),
                        borderRadius: BorderRadius.circular(10.r),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 10.h,
                            horizontal: 10.w,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.softBlueBackground,
                            borderRadius: BorderRadius.circular(10.r),
                            border: Border.all(
                              color: AppColors.info.withValues(alpha: 0.3),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.timer_outlined,
                                size: 18.r,
                                color: AppColors.info,
                              ),
                              wSpace(4),
                              Flexible(
                                child: Text(
                                  'leaves.dashboard.requestPermission'.tr(
                                    context: context,
                                  ),
                                  style: AppTextStyles.font13SemiBold.copyWith(
                                    color: AppColors.info,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                hSpace(16),
                LeaveStatusFilterWidget(
                  selectedIndex: selectedFilter,
                  pendingCount: context
                      .read<SupervisorLeaveRequestsCubit>()
                      .pendingCount,
                  onSelected: (index) => setState(() => selectedFilter = index),
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
