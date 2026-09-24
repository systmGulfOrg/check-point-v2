import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:check_point_v2/features/leaves/presentation/cubit/leaves_cubit.dart';
import 'package:check_point_v2/features/leaves/presentation/cubit/leaves_state.dart';
import 'package:check_point_v2/features/leaves/presentation/widgets/leave_balances_list_widget.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/employee/presentation/cubit/leave_requests/employee_leave_requests_cubit.dart';
import 'package:check_point_v2/features/employee/presentation/cubit/leave_requests/employee_leave_requests_state.dart';
import 'package:check_point_v2/features/employee/presentation/widgets/apply_for_leave_sheet_widget.dart';
import 'package:check_point_v2/features/employee/presentation/widgets/employee_leave_card_widget.dart';
import 'package:check_point_v2/features/employee/presentation/widgets/employee_leave_data.dart';
import 'package:check_point_v2/features/leaves/presentation/widgets/leave_status_filter_widget.dart';

class EmployeeLeavesScreen extends StatefulWidget {
  const EmployeeLeavesScreen({super.key});

  @override
  State<EmployeeLeavesScreen> createState() => _EmployeeLeavesScreenState();
}

class _EmployeeLeavesScreenState extends State<EmployeeLeavesScreen> {
  int _selectedFilterIndex = 0;
  @override
  void initState() {
    super.initState();
    final cubit = context.read<EmployeeLeaveRequestsCubit>();
    cubit.loadLeaveRequests();
    cubit.loadNativeLeaveTypes();
  }

  void _showApplyLeaveSheet(BuildContext context) {
    final cubit = context.read<EmployeeLeaveRequestsCubit>();
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.transparent,
      builder: (_) => BlocProvider.value(
        value: cubit,
        child: ApplyForLeaveSheetWidget(
          leaveTypes: cubit.nativeLeaveTypes,
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
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlocBuilder<LeavesCubit, LeavesState>(
                builder: (context, state) {
                  return state.maybeWhen(
                    success: (balances, types, requests) {
                      if (balances.isEmpty) return const SizedBox.shrink();
                      return SizedBox(
                        height: 200.h,
                        child: LeaveBalancesListWidget(balances: balances),
                      );
                    },
                    orElse: () => const SizedBox.shrink(),
                  );
                },
              ),
              hSpace(16),
              Text(
                'employee.leaves.title'.tr(context: context),
                style: AppTextStyles.font24Bold,
              ),
              hSpace(16),
              BlocConsumer<
                EmployeeLeaveRequestsCubit,
                EmployeeLeaveRequestsState
              >(
                listener: (context, state) {
                  switch (state) {
                    case EmployeeLeaveRequestsStateActionSuccess(
                      :final message,
                    ):
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(message.tr(context: context))),
                      );
                    case EmployeeLeaveRequestsStateError(:final messageKey):
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(messageKey.tr(context: context)),
                        ),
                      );
                    default:
                      break;
                  }
                },
                builder: (context, state) {
                  final allLeaves = switch (state) {
                    EmployeeLeaveRequestsStateSuccess(:final leaveRequests) =>
                      leaveRequests
                          .map(
                            (l) => EmployeeLeaveData(
                              id: '${l.id ?? 0}',
                              leaveType: l.leaveType ?? 'Leave',
                              status: l.status ?? 'Pending',
                              dateRange:
                                  '${l.startDate ?? ''} – ${l.endDate ?? ''}',
                              reason: l.reason != null ? '"${l.reason}"' : null,
                              appliedDate: 'Request #${l.id ?? 0}',
                              managerName: l.managerName,
                              managerActionAt: l.managerActionAt,
                              managerRejectionReason: l.managerRejectionReason,
                              hrName: l.hrName,
                              hrActionAt: l.hrActionAt,
                              hrRejectionReason: l.hrRejectionReason,
                            ),
                          )
                          .toList(),
                    EmployeeLeaveRequestsStateOdooSuccess(
                      :final odooRequests,
                    ) =>
                      odooRequests
                          .map(
                            (l) => EmployeeLeaveData(
                              id: '${l.id}',
                              leaveType: l.leaveTypeName,
                              status: l.state.isNotEmpty ? l.state : 'Pending',
                              dateRange: '${l.dateFrom} – ${l.dateTo}',
                              reason: l.reason.isNotEmpty
                                  ? '"${l.reason}"'
                                  : null,
                              appliedDate: 'Odoo #${l.id}',
                            ),
                          )
                          .toList(),
                    _ => const <EmployeeLeaveData>[],
                  };

                  final pendingCount = allLeaves
                      .where((l) => l.status.toLowerCase() == 'pending')
                      .length;

                  final filteredLeaves = switch (_selectedFilterIndex) {
                    1 =>
                      allLeaves
                          .where((l) => l.status.toLowerCase() == 'pending')
                          .toList(),
                    2 =>
                      allLeaves
                          .where((l) => l.status.toLowerCase() == 'approved')
                          .toList(),
                    3 =>
                      allLeaves
                          .where((l) => l.status.toLowerCase() == 'rejected')
                          .toList(),
                    _ => allLeaves,
                  };

                  final isLoading = switch (state) {
                    EmployeeLeaveRequestsStateLoading() => true,
                    _ => false,
                  };

                  if (isLoading) {
                    return Expanded(
                      child: Skeletonizer(
                        child: RefreshIndicator(
                          color: AppColors.brandPrimary,
                          onRefresh: context
                              .read<EmployeeLeaveRequestsCubit>()
                              .loadLeaveRequests,
                          child: ListView.separated(
                            physics: const AlwaysScrollableScrollPhysics(),
                            itemCount: 3,
                            separatorBuilder: (_, _) => hSpace(12),
                            itemBuilder: (_, _) => EmployeeLeaveCardWidget(
                              leave: const EmployeeLeaveData(
                                id: '000',
                                leaveType: 'Annual leave',
                                status: 'Pending',
                                dateRange: '2026-01-01 – 2026-01-02',
                                reason: 'Loading reason',
                                appliedDate: 'Loading date',
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }

                  if (state case EmployeeLeaveRequestsStateError(
                    :final messageKey,
                  )) {
                    return Expanded(
                      child: Center(
                        child: Text(messageKey.tr(context: context)),
                      ),
                    );
                  }

                  return Expanded(
                    child: Column(
                      children: [
                        LeaveStatusFilterWidget(
                          selectedIndex: _selectedFilterIndex,
                          pendingCount: pendingCount,
                          onSelected: (index) =>
                              setState(() => _selectedFilterIndex = index),
                        ),
                        hSpace(16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${filteredLeaves.length} requests',
                              style: AppTextStyles.font13Regular.copyWith(
                                color: AppColors.textSecondary,
                              ),
                            ),
                            GestureDetector(
                              onTap: () => _showApplyLeaveSheet(context),
                              child: Text(
                                'employee.leaves.apply'.tr(context: context),
                                style: AppTextStyles.font14SemiBold.copyWith(
                                  color: AppColors.brandPrimary,
                                ),
                              ),
                            ),
                          ],
                        ),
                        hSpace(12),
                        Expanded(
                          child: filteredLeaves.isEmpty
                              ? Center(
                                  child: Text('employee.leaves.noLeaves'.tr()),
                                )
                              : RefreshIndicator(
                                  color: AppColors.brandPrimary,
                                  onRefresh: context
                                      .read<EmployeeLeaveRequestsCubit>()
                                      .loadLeaveRequests,
                                  child: ListView.separated(
                                    physics:
                                        const AlwaysScrollableScrollPhysics(),
                                    itemCount: filteredLeaves.length,
                                    separatorBuilder: (_, _) => hSpace(12),
                                    itemBuilder: (context, index) =>
                                        AnimatedListItemWidget(
                                          index: index,
                                          child: EmployeeLeaveCardWidget(
                                            leave: filteredLeaves[index],
                                            onDelete: () {
                                              final leaveId =
                                                  filteredLeaves[index].id;
                                              final cubit = context.read<
                                                  EmployeeLeaveRequestsCubit>();
                                              showDialog<bool>(
                                                context: context,
                                                builder: (dialogCtx) =>
                                                    AppDeleteConfirmationDialogWidget(
                                                  title:
                                                      'admin.leaveManagement.deleteTitle'
                                                          .tr(
                                                              context:
                                                                  dialogCtx),
                                                  message:
                                                      'admin.leaveManagement.deleteMessage'
                                                          .tr(
                                                              context:
                                                                  dialogCtx),
                                                  confirmLabel:
                                                      'admin.leaveManagement.deleteConfirm'
                                                          .tr(
                                                              context:
                                                                  dialogCtx),
                                                  onConfirm: () async {
                                                    Navigator.of(dialogCtx)
                                                        .pop(true);
                                                  },
                                                ),
                                              ).then((confirmed) {
                                                if (confirmed == true) {
                                                  final idInt =
                                                      int.tryParse(leaveId);
                                                  cubit.deleteLeaveRequest(
                                                      idInt ?? leaveId);
                                                }
                                              });
                                            },
                                          ),
                                        ),
                                  ),
                                ),
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
    );
  }
}
