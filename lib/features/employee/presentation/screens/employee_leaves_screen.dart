import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/employee/presentation/cubit/leave_requests/employee_leave_requests_cubit.dart';
import 'package:check_point_v2/features/employee/presentation/cubit/leave_requests/employee_leave_requests_state.dart';
import 'package:check_point_v2/features/employee/presentation/widgets/apply_for_leave_sheet_widget.dart';
import 'package:check_point_v2/features/employee/presentation/widgets/employee_leave_card_widget.dart';
import 'package:check_point_v2/features/employee/presentation/widgets/employee_leave_data.dart';

class EmployeeLeavesScreen extends StatefulWidget {
  const EmployeeLeavesScreen({super.key});

  @override
  State<EmployeeLeavesScreen> createState() => _EmployeeLeavesScreenState();
}

class _EmployeeLeavesScreenState extends State<EmployeeLeavesScreen> {
  int _selectedFilterIndex = 0;
  final _filters = ['All', 'Pending', 'Approved', 'Rejected'];

  @override
  void initState() {
    super.initState();
    context.read<EmployeeLeaveRequestsCubit>().loadLeaveRequests();
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
          onSubmit:
              ({
                required leaveType,
                required startDate,
                required endDate,
                reason,
              }) {
                cubit.submitOdooLeaveRequest(
                  dateFrom: startDate,
                  dateTo: endDate,
                  reason: reason,
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
              Text(
                'employee.leaves.title'.tr(context: context),
                style: AppTextStyles.font24Bold,
              ),
              hSpace(16),
              BlocConsumer<EmployeeLeaveRequestsCubit, EmployeeLeaveRequestsState>(
                listener: (context, state) {
                  switch (state) {
                    case EmployeeLeaveRequestsStateActionSuccess(:final message):
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(message)),
                      );
                    case EmployeeLeaveRequestsStateError(:final messageKey):
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(messageKey)),
                      );
                    default:
                      break;
                  }
                },
                builder: (context, state) {
                  final allLeaves = switch (state) {
                    EmployeeLeaveRequestsStateSuccess(:final leaveRequests) => leaveRequests
                        .map((l) => EmployeeLeaveData(
                              id: '${l.id ?? 0}',
                              leaveType: l.leaveType ?? 'Leave',
                              status: l.status ?? 'Pending',
                              dateRange: '${l.startDate ?? ''} – ${l.endDate ?? ''}',
                              reason: l.reason != null ? '"${l.reason}"' : null,
                              appliedDate: 'Request #${l.id ?? 0}',
                            ))
                        .toList(),
                    EmployeeLeaveRequestsStateOdooSuccess(:final odooRequests) => odooRequests
                        .map((l) => EmployeeLeaveData(
                              id: '${l.id}',
                              leaveType: l.leaveTypeName,
                              status: l.state.isNotEmpty ? l.state : 'Pending',
                              dateRange: '${l.dateFrom} – ${l.dateTo}',
                              reason: l.reason.isNotEmpty ? '"${l.reason}"' : null,
                              appliedDate: 'Odoo #${l.id}',
                            ))
                        .toList(),
                    _ => const <EmployeeLeaveData>[],
                  };

                  final pendingCount =
                      allLeaves.where((l) => l.status == 'Pending').length;

                  final filteredLeaves = switch (_selectedFilterIndex) {
                    1 => allLeaves.where((l) => l.status == 'Pending').toList(),
                    2 => allLeaves.where((l) => l.status == 'Approved').toList(),
                    3 => allLeaves.where((l) => l.status == 'Rejected').toList(),
                    _ => allLeaves,
                  };

                  if (state is EmployeeLeaveRequestsStateLoading) {
                    return const Expanded(
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }

                  return Expanded(
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(4.r),
                          decoration: BoxDecoration(
                            color: AppColors.pageBackground,
                            borderRadius: BorderRadius.circular(12.r),
                            border: Border.all(color: AppColors.border),
                          ),
                          child: Row(
                            children: [
                              for (int i = 0; i < _filters.length; i++)
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () =>
                                        setState(() => _selectedFilterIndex = i),
                                    child: Container(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 8.h),
                                      decoration: BoxDecoration(
                                        color: _selectedFilterIndex == i
                                            ? AppColors.cardBackground
                                            : AppColors.transparent,
                                        borderRadius: BorderRadius.circular(8.r),
                                        boxShadow: _selectedFilterIndex == i
                                            ? const [
                                                BoxShadow(
                                                  color: AppColors.shadow,
                                                  blurRadius: 4,
                                                  offset: Offset(0, 1),
                                                ),
                                              ]
                                            : null,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            _filters[i],
                                            style: AppTextStyles.font13SemiBold
                                                .copyWith(
                                              color: _selectedFilterIndex == i
                                                  ? AppColors.textPrimary
                                                  : AppColors.textSecondary,
                                            ),
                                          ),
                                          if (i == 1 && pendingCount > 0) ...[
                                            wSpace(4),
                                            Container(
                                              padding: EdgeInsets.all(4.r),
                                              decoration: const BoxDecoration(
                                                color: AppColors.error,
                                                shape: BoxShape.circle,
                                              ),
                                              constraints: BoxConstraints(
                                                minWidth: 14.r,
                                                minHeight: 14.r,
                                              ),
                                              child: Center(
                                                child: Text(
                                                  '$pendingCount',
                                                  style: AppTextStyles.font11Medium
                                                      .copyWith(
                                                    color: AppColors.white,
                                                    fontSize: 9.sp,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
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
                              ? const Center(
                                  child: Text('No leave requests found'),
                                )
                              : ListView.separated(
                                  itemCount: filteredLeaves.length,
                                  separatorBuilder: (_, _) => hSpace(12),
                                  itemBuilder: (context, index) =>
                                      AnimatedListItemWidget(
                                    index: index,
                                    child: EmployeeLeaveCardWidget(
                                      leave: filteredLeaves[index],
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
