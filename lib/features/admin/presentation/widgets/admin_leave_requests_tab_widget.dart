import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/admin/data/models/leave_requests/admin_leave_request_model.dart';
import 'package:check_point_v2/features/admin/presentation/widgets/admin_leave_management_filter_widget.dart';
import 'package:check_point_v2/features/admin/presentation/widgets/admin_leave_requests_list_widget.dart';

class AdminLeaveRequestsTabWidget extends StatelessWidget {
  const AdminLeaveRequestsTabWidget({
    super.key,
    required this.requests,
    required this.selectedFilter,
    required this.onFilterSelected,
  });

  final List<AdminLeaveRequestModel> requests;
  final int selectedFilter;
  final ValueChanged<int> onFilterSelected;

  List<AdminLeaveRequestModel> _filterRequests(
    List<AdminLeaveRequestModel> list,
  ) {
    return switch (selectedFilter) {
      1 => list.where((r) {
        final s = r.status?.toLowerCase() ?? '';
        return s == 'pending' ||
            s == 'pendinghr' ||
            s == 'pendingadmin' ||
            s == 'pendingmanager';
      }).toList(),
      2 => list.where((r) => r.status?.toLowerCase() == 'approved').toList(),
      3 => list.where((r) {
        final s = r.status?.toLowerCase() ?? '';
        return s == 'rejected' ||
            s == 'rejectedbyhr' ||
            s == 'rejectedbymanager';
      }).toList(),
      _ => list,
    };
  }

  @override
  Widget build(BuildContext context) {
    final pendingCount = requests.where((r) {
      final s = r.status?.toLowerCase() ?? '';
      return s == 'pending' ||
          s == 'pendinghr' ||
          s == 'pendingmanager' ||
          s == 'pendingadmin';
    }).length;
    final filtered = _filterRequests(requests);

    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 24.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AdminLeaveManagementFilterWidget(
            selectedIndex: selectedFilter,
            pendingCount: pendingCount,
            onSelected: onFilterSelected,
          ),
          hSpace(14),
          Text(
            'admin.leaveManagement.count'.tr(
              context: context,
              args: ['${filtered.length}'],
            ),
            style: AppTextStyles.font12Regular.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          hSpace(10),
          AdminLeaveRequestsListWidget(requests: filtered),
        ],
      ),
    );
  }
}
