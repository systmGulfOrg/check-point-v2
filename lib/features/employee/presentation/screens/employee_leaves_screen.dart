import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/core.dart';
import '../widgets/apply_for_leave_sheet_widget.dart';
import '../widgets/employee_leave_card_widget.dart';
import '../widgets/employee_leave_data.dart';

class EmployeeLeavesScreen extends StatefulWidget {
  const EmployeeLeavesScreen({super.key});

  @override
  State<EmployeeLeavesScreen> createState() => _EmployeeLeavesScreenState();
}

class _EmployeeLeavesScreenState extends State<EmployeeLeavesScreen> {
  int _selectedFilterIndex = 0;
  final _filters = ['All', 'Pending', 'Approved', 'Rejected'];

  final List<EmployeeLeaveData> _leaves = [
    const EmployeeLeaveData(
      id: '1',
      leaveType: 'Annual Leave',
      status: 'Pending',
      dateRange: '2026-09-10 – 2026-09-12 (3d)',
      reason: '"Family vacation"',
      appliedDate: 'Applied 2026-09-01',
    ),
  ];

  void _showApplyLeaveSheet(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.transparent,
      builder: (_) => ApplyForLeaveSheetWidget(
        onSubmit:
            ({
              required leaveType,
              required startDate,
              required endDate,
              reason,
            }) {
              setState(() {
                _leaves.insert(
                  0,
                  EmployeeLeaveData(
                    id: DateTime.now().millisecondsSinceEpoch.toString(),
                    leaveType: leaveType,
                    status: 'Pending',
                    dateRange: '$startDate – $endDate',
                    reason: reason != null && reason.isNotEmpty
                        ? '"$reason"'
                        : null,
                    appliedDate: 'Applied 2026-09-01',
                  ),
                );
              });
            },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final pendingCount = _leaves.where((l) => l.status == 'Pending').length;

    final filteredLeaves = switch (_selectedFilterIndex) {
      1 => _leaves.where((l) => l.status == 'Pending').toList(),
      2 => _leaves.where((l) => l.status == 'Approved').toList(),
      3 => _leaves.where((l) => l.status == 'Rejected').toList(),
      _ => _leaves,
    };

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
                          onTap: () => setState(() => _selectedFilterIndex = i),
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 8.h),
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
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  _filters[i],
                                  style: AppTextStyles.font13SemiBold.copyWith(
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
                    '${filteredLeaves.length} request',
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
                child: ListView.separated(
                  itemCount: filteredLeaves.length,
                  separatorBuilder: (_, _) => hSpace(12),
                  itemBuilder: (context, index) => AnimatedListItemWidget(
                    index: index,
                    child: EmployeeLeaveCardWidget(
                      leave: filteredLeaves[index],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
