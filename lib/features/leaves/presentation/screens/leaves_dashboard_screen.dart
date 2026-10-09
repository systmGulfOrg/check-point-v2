import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/core/di/service_locator.dart';
import 'package:check_point_v2/features/admin/data/models/leave_requests/leave_type_model.dart'
    as admin_lt;
import 'package:check_point_v2/features/employee/presentation/widgets/apply_for_leave_sheet_widget.dart';
import 'package:check_point_v2/features/employee/presentation/widgets/apply_for_permission_sheet_widget.dart';
import '../cubit/leaves_cubit.dart';
import '../cubit/leaves_state.dart';
import '../cubit/permit_cubit.dart';
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
  List<dynamic>? _cachedBalances;
  List<LeaveRequestModel>? _cachedRequests;

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
        onSubmit:
            ({
              required startDate,
              required endDate,
              required reason,
              required remark,
              required leaveRequestType,
              attachmentUrl,
            }) {
              cubit.submitLeave(
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

  void _showApplyPermissionSheet(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.transparent,
      builder: (_) => ApplyForPermissionSheetWidget(
        onSubmit: (body) async {
          final permitCubit = sl<PermitCubit>();
          final success = await permitCubit.submit(body);
          if (success && context.mounted) {
            CustomSnackBar.showSuccess(
              context,
              message: 'permissions.request.success'.tr(),
            );
            context.read<LeavesCubit>().loadLeavesData();
          }
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
              state.maybeWhen(
                submitSuccess: () {
                  CustomSnackBar.showSuccess(
                    context,
                    message: 'leaves.request.success'.tr(context: context),
                  );
                },
                actionSuccess: (message) {
                  CustomSnackBar.showSuccess(
                    context,
                    message: message.tr(context: context),
                  );
                },
                error: (message) {
                  CustomSnackBar.showError(
                    context,
                    message: message.tr(context: context),
                  );
                },
                orElse: () {},
              );
            },
            builder: (context, state) {
              state.maybeWhen(
                success: (balances, types, requests) {
                  _cachedBalances = balances;
                  _cachedRequests = requests;
                },
                orElse: () {},
              );

              if (_cachedBalances == null && _cachedRequests == null) {
                return state.maybeWhen(
                  loading: () => Skeletonizer(
                    enabled: true,
                    child: ListView.separated(
                      padding: EdgeInsets.fromLTRB(16.w, 4.h, 16.w, 24.h),
                      itemCount: 4,
                      separatorBuilder: (_, _) => hSpace(12),
                      itemBuilder: (_, _) => Card(
                        child: ListTile(
                          title: const Text('Annual Leave Balance Placeholder'),
                          subtitle: const Text('14 / 21 Days Available'),
                          trailing: const Icon(Icons.arrow_forward_ios),
                        ),
                      ),
                    ),
                  ),
                  error: (message) => SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: EdgeInsets.all(32.r),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.error_outline_rounded,
                            size: 48.r,
                            color: AppColors.error,
                          ),
                          hSpace(12),
                          Text(
                            message.tr(context: context),
                            style: AppTextStyles.font14Regular.copyWith(
                              color: AppColors.error,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          hSpace(16),
                          OutlinedButton(
                            onPressed: () => context.read<LeavesCubit>().loadLeavesData(),
                            child: Text('common.retry'.tr(context: context)),
                          ),
                        ],
                      ),
                    ),
                  ),
                  orElse: () => const SizedBox.shrink(),
                );
              }

              final balances = (_cachedBalances ?? []).cast<dynamic>();
              final requests = _cachedRequests ?? [];

              return SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.fromLTRB(16.w, 4.h, 16.w, 100.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (balances.isNotEmpty) ...[
                      Text(
                        'leaves.dashboard.balanceTitle'.tr(context: context),
                        style: AppTextStyles.font16Bold,
                      ),
                      hSpace(8),
                      Padding(
                        padding: EdgeInsets.only(bottom: 16.h),
                        child: LeaveBalancesListWidget(
                          balances: balances.cast(),
                        ),
                      ),
                    ],
                    LeaveStatusFilterWidget(
                      selectedIndex: _selectedFilterIndex,
                      pendingCount: requests.where((r) {
                        final s = r.status.toLowerCase();
                        return s == 'pending' ||
                            s == 'pendinghr' ||
                            s == 'pendingmanager';
                      }).length,
                      onSelected: (index) =>
                          setState(() => _selectedFilterIndex = index),
                    ),
                    hSpace(16),
                    ..._buildFilteredRequests(requests),
                  ],
                ),
              );
            },
          ),
        ),
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton.extended(
            heroTag: 'employeePermissionBtn',
            onPressed: () => _showApplyPermissionSheet(context),
            backgroundColor: AppColors.brandSecondary,
            icon: const Icon(Icons.timer),
            label: Text('leaves.dashboard.requestPermission'.tr()),
          ),
          SizedBox(height: 12.h),
          FloatingActionButton.extended(
            heroTag: 'employeeLeaveBtn',
            onPressed: () => _showApplyLeaveSheet(context),
            backgroundColor: AppColors.brandPrimary,
            icon: const Icon(Icons.add),
            label: Text('leaves.dashboard.requestLeave'.tr()),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildFilteredRequests(List<LeaveRequestModel> requests) {
    final filtered = requests.where((r) {
      final s = r.status.toLowerCase();
      return switch (_selectedFilterIndex) {
        1 => s == 'pending' || s == 'pendinghr' || s == 'pendingmanager',
        2 => s == 'approved' || s == 'approvedbyhr' || s == 'approvedbymanager',
        3 => s == 'rejected' || s == 'rejectedbymanager' || s == 'rejectedbyhr',
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
                    title: 'admin.leaveManagement.deleteTitle'.tr(
                      context: dialogCtx,
                    ),
                    message: 'admin.leaveManagement.deleteMessage'.tr(
                      context: dialogCtx,
                    ),
                    confirmLabel: 'admin.leaveManagement.deleteConfirm'.tr(
                      context: dialogCtx,
                    ),
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
