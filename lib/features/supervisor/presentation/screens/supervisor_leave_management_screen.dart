import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/core.dart';
import '../widgets/supervisor_leave_management_filter_widget.dart';
import '../widgets/supervisor_leave_requests_list_widget.dart';

class SupervisorLeaveManagementScreen extends StatefulWidget {
  const SupervisorLeaveManagementScreen({super.key});

  @override
  State<SupervisorLeaveManagementScreen> createState() =>
      _SupervisorLeaveManagementScreenState();
}

class _SupervisorLeaveManagementScreenState
    extends State<SupervisorLeaveManagementScreen> {
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
          'supervisor.leaveManagement.title'.tr(context: context),
          style: AppTextStyles.font18Bold,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(16.w, 4.h, 16.w, 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SupervisorLeaveManagementFilterWidget(
                selectedIndex: selectedFilter,
                onFilterSelected: (index) =>
                    setState(() => selectedFilter = index),
              ),
              hSpace(14),
              Text(
                'supervisor.leaveManagement.count'.tr(
                  context: context,
                  args: ['3'],
                ),
                style: AppTextStyles.font12Regular,
              ),
              hSpace(10),
              const SupervisorLeaveRequestsListWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
