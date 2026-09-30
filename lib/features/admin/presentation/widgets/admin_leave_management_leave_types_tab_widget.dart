import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/admin/data/models/leave_requests/leave_type_model.dart';
import 'admin_leave_types_list_widget.dart';

class AdminLeaveManagementLeaveTypesTabWidget extends StatelessWidget {
  const AdminLeaveManagementLeaveTypesTabWidget({
    required this.leaveTypes,
    required this.onAddLeaveType,
    super.key,
  });

  final List<dynamic> leaveTypes;
  final VoidCallback onAddLeaveType;

  @override
  Widget build(BuildContext context) {
    final typedList = leaveTypes.cast<dynamic>();
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 24.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'admin.leaveManagement.count'.tr(
                  context: context,
                  args: ['${leaveTypes.length}'],
                ),
                style: AppTextStyles.font12Regular.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.brandPrimary,
                  foregroundColor: AppColors.white,
                  padding: EdgeInsets.symmetric(
                    horizontal: 14.w,
                    vertical: 8.h,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
                icon: const Icon(Icons.add, size: 18),
                label: Text(
                  'admin.leaveManagement.addType'.tr(context: context),
                  style: AppTextStyles.font12Medium.copyWith(
                    color: AppColors.white,
                  ),
                ),
                onPressed: onAddLeaveType,
              ),
            ],
          ),
          hSpace(12),
          AdminLeaveTypesListWidget(
            leaveTypes: typedList.whereType<LeaveTypeModel>().toList(),
          ),
        ],
      ),
    );
  }
}
