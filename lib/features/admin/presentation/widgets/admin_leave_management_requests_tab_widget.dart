import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/admin/data/models/leave_requests/admin_leave_request_model.dart';
import 'admin_leave_management_filter_widget.dart';
import 'admin_leave_requests_list_widget.dart';

class AdminLeaveManagementRequestsTabWidget extends StatelessWidget {
  const AdminLeaveManagementRequestsTabWidget({
    required this.requests,
    required this.selectedFilter,
    required this.onFilterChanged,
    super.key,
  });

  final List<AdminLeaveRequestModel> requests;
  final int selectedFilter;
  final ValueChanged<int> onFilterChanged;

  List<AdminLeaveRequestModel> _filterRequests(List<AdminLeaveRequestModel> all) {
    return switch (selectedFilter) {
      1 => all.where((r) {
        final s = r.status?.toLowerCase() ?? '';
        return s == 'pending' ||
            s == 'pendinghr' ||
            s == 'pendingadmin' ||
            s == 'pendingmanager';
      }).toList(),
      2 => all.where((r) => r.status?.toLowerCase() == 'approved').toList(),
      3 => all.where((r) {
        final s = r.status?.toLowerCase() ?? '';
        return s == 'rejected' ||
            s == 'rejectedbyhr' ||
            s == 'rejectedbymanager';
      }).toList(),
      _ => all,
    };
  }

  @override
  Widget build(BuildContext context) {
    final pendingCount = requests
        .where((r) => r.status?.toLowerCase() == 'pending')
        .length;
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
            onSelected: onFilterChanged,
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
