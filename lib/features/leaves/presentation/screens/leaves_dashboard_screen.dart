import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/admin/data/models/leave_requests/leave_type_model.dart'
    as admin_lt;
import 'package:check_point_v2/features/employee/presentation/widgets/apply_for_leave_sheet_widget.dart';
import '../cubit/leaves_cubit.dart';
import '../cubit/leaves_state.dart';
import '../../data/models/leave_balance_model.dart';
import '../../data/models/leave_request_body.dart';
import '../../data/models/leave_request_model.dart';
import '../widgets/leave_balances_list_widget.dart';
import '../widgets/leave_request_card_widget.dart';
import '../widgets/leave_status_filter_widget.dart';

class LeavesDashboardScreen extends StatefulWidget {
  const LeavesDashboardScreen({super.key});

  @override
  State<LeavesDashboardScreen> createState() => _LeavesDashboardScreenState();
}

class _LeavesDashboardScreenState extends State<LeavesDashboardScreen> {
  int _selectedFilterIndex = 0;

  @override
  void initState() {
    super.initState();
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
              ),
            )
            .toList(),
        onSubmit: ({
          required startDate,
          required endDate,
          required reason,
          required remark,
          required leaveRequestType,
          attachmentUrl,
        }) async {
          await cubit.submitLeave(
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'leaves.dashboard.title'.tr(context: context),
          style: AppTextStyles.font18Bold,
        ),
        backgroundColor: AppColors.white,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
      ),
      body: SafeArea(
        child: RefreshIndicator(
          color: AppColors.brandPrimary,
          onRefresh: context.read<LeavesCubit>().loadLeavesData,
          child: BlocConsumer<LeavesCubit, LeavesState>(
            listener: (context, state) {
              final cubit = context.read<LeavesCubit>();
              state.maybeWhen(
                error: (message) {
                  if (cubit.cachedBalances.isNotEmpty ||
                      cubit.cachedRequests.isNotEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(message.tr(context: context)),
                        backgroundColor: AppColors.error,
                      ),
                    );
                  }
                },
                orElse: () {},
              );
            },
            builder: (context, state) {
              final cubit = context.read<LeavesCubit>();
              final hasCachedData = cubit.cachedBalances.isNotEmpty ||
                  cubit.cachedRequests.isNotEmpty;

              return state.maybeWhen(
                loading: () => hasCachedData
                    ? _buildDashboardContent(
                        context,
                        cubit.cachedBalances,
                        cubit.cachedRequests,
                      )
                    : Skeletonizer(
                        enabled: true,
                        child: ListView.separated(
                          padding: EdgeInsets.fromLTRB(16.w, 4.h, 16.w, 24.h),
                          itemCount: 4,
                          separatorBuilder: (_, _) => hSpace(12),
                          itemBuilder: (_, _) => Card(
                            child: ListTile(
                              title: const Text(
                                'Annual Leave Balance Placeholder',
                              ),
                              subtitle: const Text('14 / 21 Days Available'),
                              trailing: const Icon(Icons.arrow_forward_ios),
                            ),
                          ),
                        ),
                      ),
                success: (balances, types, requests) =>
                    _buildDashboardContent(context, balances, requests),
                error: (message) => hasCachedData
                    ? _buildDashboardContent(
                        context,
                        cubit.cachedBalances,
                        cubit.cachedRequests,
                      )
                    : SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        padding: EdgeInsets.all(32.r),
                        child: Center(
                          child: Text(
                            message.tr(context: context),
                            style: AppTextStyles.font14Regular.copyWith(
                              color: AppColors.error,
                            ),
                          ),
                        ),
                      ),
                orElse: () => hasCachedData
                    ? _buildDashboardContent(
                        context,
                        cubit.cachedBalances,
                        cubit.cachedRequests,
                      )
                    : const SizedBox.shrink(),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildDashboardContent(
    BuildContext context,
    List<LeaveBalanceModel> balances,
    List<LeaveRequestModel> requests,
  ) {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 32.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
                        color: AppColors.brandPrimary.withValues(alpha: 0.3),
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
          if (balances.isNotEmpty) ...[
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
          LeaveStatusFilterWidget(
            selectedIndex: _selectedFilterIndex,
            pendingCount: requests
                .where((r) {
                  final s = r.status.toLowerCase();
                  return s == 'pending' ||
                      s == 'pendinghr' ||
                      s == 'pendingmanager';
                })
                .length,
            onSelected: (index) => setState(() => _selectedFilterIndex = index),
          ),
          hSpace(16),
          ..._buildFilteredRequests(requests),
        ],
      ),
    );
  }

  List<Widget> _buildFilteredRequests(List<LeaveRequestModel> requests) {
    final filtered = requests.where((r) {
      final s = r.status.toLowerCase();
      return switch (_selectedFilterIndex) {
        1 => s == 'pending' || s == 'pendinghr' || s == 'pendingmanager',
        2 => s == 'approved' ||
            s == 'approvedbyhr' ||
            s == 'approvedbymanager',
        3 => s == 'rejected' ||
            s == 'rejectedbymanager' ||
            s == 'rejectedbyhr',
        _ => true,
      };
    }).toList();

    if (filtered.isEmpty) {
      return [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 32.h),
          child: Center(
            child: Text(
              'employee.leaves.noLeaves'.tr(context: context),
              style: AppTextStyles.font14Regular.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ),
        ),
      ];
    }

    return filtered
        .map(
          (req) => Padding(
            padding: EdgeInsets.only(bottom: 12.h),
            child: LeaveRequestCardWidget(
              request: req,
              onDelete: () {
                final cubit = context.read<LeavesCubit>();
                showDialog<bool>(
                  context: context,
                  builder: (dialogCtx) => AppDeleteConfirmationDialogWidget(
                    title: 'admin.leaveManagement.deleteTitle'
                        .tr(context: dialogCtx),
                    message: 'admin.leaveManagement.deleteMessage'
                        .tr(context: dialogCtx),
                    confirmLabel: 'admin.leaveManagement.deleteConfirm'
                        .tr(context: dialogCtx),
                    onConfirm: () async {
                      Navigator.of(dialogCtx).pop(true);
                    },
                  ),
                ).then((confirmed) {
                  if (confirmed == true) {
                    cubit.deleteLeaveRequest(req.id);
                  }
                });
              },
            ),
          ),
        )
        .toList();
  }
}
