import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/core.dart';
import '../widgets/admin_leave_decision_sheet_widget.dart';
import '../widgets/admin_leave_management_filter_widget.dart';
import '../widgets/admin_leave_requests_list_widget.dart';

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
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(16.w, 4.h, 16.w, 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AdminLeaveManagementFilterWidget(
                selectedIndex: selectedFilter,
                onSelected: (index) => setState(() => selectedFilter = index),
              ),
              hSpace(14),
              Text(
                'admin.leaveManagement.count'.tr(context: context, args: ['4']),
                style: AppTextStyles.font12Regular,
              ),
              hSpace(10),
              AdminLeaveRequestsListWidget(
                onApprove: (request) => showModalBottomSheet<void>(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: AppColors.cardBackground,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
                  builder: (_) => AdminLeaveDecisionSheetWidget(
                    request: request,
                    decision: AdminLeaveDecision.approve,
                  ),
                ),
                onReject: (request) => showModalBottomSheet<void>(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: AppColors.cardBackground,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
                  builder: (_) => AdminLeaveDecisionSheetWidget(
                    request: request,
                    decision: AdminLeaveDecision.reject,
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
