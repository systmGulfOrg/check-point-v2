import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/leave_requests/admin_leave_requests_cubit.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/leave_requests/admin_leave_requests_state.dart';
import 'package:check_point_v2/features/admin/presentation/widgets/admin_leave_request_card_widget.dart';
import 'package:check_point_v2/features/admin/presentation/widgets/admin_leave_request_data.dart';
import 'package:check_point_v2/features/admin/presentation/widgets/admin_leave_requests_skeleton_widget.dart';

class AdminLeaveManagementScreen extends StatefulWidget {
  const AdminLeaveManagementScreen({super.key});

  @override
  State<AdminLeaveManagementScreen> createState() =>
      _AdminLeaveManagementScreenState();
}

class _AdminLeaveManagementScreenState
    extends State<AdminLeaveManagementScreen> {
  int selectedFilter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        title: Text(
          'admin.leaveManagement.title'.tr(context: context),
          style: AppTextStyles.font18Bold,
        ),
      ),
      body: SafeArea(
        child: RefreshIndicator(
          color: AppColors.brandPrimary,
          onRefresh: context.read<AdminLeaveRequestsCubit>().loadRequests,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.fromLTRB(16.w, 4.h, 16.w, 24.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BlocBuilder<AdminLeaveRequestsCubit, AdminLeaveRequestsState>(
                  builder: (context, state) {
                    return state.when(
                      initial: () => const SizedBox.shrink(),
                      loading: () => const AdminLeaveRequestsSkeletonWidget(),
                      error: (messageKey) => Padding(
                        padding: EdgeInsets.all(24.r),
                        child: Center(
                          child: Text(
                            messageKey.tr(context: context),
                            style: AppTextStyles.font14Regular.copyWith(
                              color: AppColors.error,
                            ),
                          ),
                        ),
                      ),
                      actionSuccess: (_) => const SizedBox.shrink(),
                      success: (requests) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'admin.leaveManagement.count'.tr(
                              context: context,
                              args: ['${requests.length}'],
                            ),
                            style: AppTextStyles.font12Regular,
                          ),
                          hSpace(10),
                          if (requests.isEmpty)
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 32),
                              child: Center(
                                child: Text(
                                  'admin.requests.emptyAll'.tr(
                                    context: context,
                                  ),
                                  style: AppTextStyles.font14Regular,
                                ),
                              ),
                            )
                          else
                            ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: requests.length,
                              separatorBuilder: (_, _) => hSpace(10),
                              itemBuilder: (context, index) {
                                final item = requests[index];
                                final requestData = AdminLeaveRequestData(
                                  initials:
                                      (item.employeeName?.isNotEmpty ?? false)
                                      ? item.employeeName![0]
                                      : 'E',
                                  nameKey: item.employeeName ?? 'Employee',
                                  leaveTypeKey: item.leaveType ?? 'Leave',
                                  dateRange:
                                      '${item.startDate ?? '-'} -> ${item.endDate ?? '-'}',
                                  reasonKey: item.reason ?? '-',
                                  appliedDate: item.startDate ?? '-',
                                  statusKey: item.status ?? 'Pending',
                                  statusColor:
                                      item.status?.toLowerCase() == 'approved'
                                      ? AppColors.success
                                      : item.status?.toLowerCase() == 'rejected'
                                      ? AppColors.error
                                      : AppColors.warningOrange,
                                  statusBackgroundColor:
                                      AppColors.softYellowBackground,
                                );
                                return AdminLeaveRequestCardWidget(
                                  request: requestData,
                                  onApprove: () {
                                    if (item.id != null) {
                                      context
                                          .read<AdminLeaveRequestsCubit>()
                                          .updateStatus(
                                            requestId: item.id!,
                                            status: 'Approved',
                                          );
                                    }
                                  },
                                  onReject: () {
                                    if (item.id != null) {
                                      context
                                          .read<AdminLeaveRequestsCubit>()
                                          .updateStatus(
                                            requestId: item.id!,
                                            status: 'Rejected',
                                          );
                                    }
                                  },
                                );
                              },
                            ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
