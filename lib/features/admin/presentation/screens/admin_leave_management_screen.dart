import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/leave_requests/admin_leave_requests_cubit.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/leave_requests/admin_leave_requests_state.dart';
import 'package:check_point_v2/features/admin/presentation/widgets/admin_leave_requests_skeleton_widget.dart';
import '../widgets/admin_leave_management_leave_types_tab_widget.dart';
import '../widgets/admin_leave_management_requests_tab_widget.dart';
import '../widgets/admin_new_leave_type_sheet_widget.dart';
import '../widgets/admin_official_holidays_bloc_builder_widget.dart';
import 'package:check_point_v2/features/leaves/presentation/cubit/leaves_cubit.dart';

class AdminLeaveManagementScreen extends StatefulWidget {
  const AdminLeaveManagementScreen({super.key});

  @override
  State<AdminLeaveManagementScreen> createState() =>
      _AdminLeaveManagementScreenState();
}

class _AdminLeaveManagementScreenState extends State<AdminLeaveManagementScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  int _selectedFilter = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    context.read<LeavesCubit>().loadOfficialHolidays();
    _tabController.addListener(() {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _showAddLeaveTypeSheet() {
    final cubit = context.read<AdminLeaveRequestsCubit>();
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => BlocProvider.value(
        value: cubit,
        child: const AdminNewLeaveTypeSheetWidget(),
      ),
    );
  }

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
        bottom: TabBar(
          controller: _tabController,
          labelColor: AppColors.brandPrimary,
          unselectedLabelColor: AppColors.textSecondary,
          indicatorColor: AppColors.brandPrimary,
          labelStyle: AppTextStyles.font13SemiBold,
          tabs: [
            Tab(text: 'admin.leaveManagement.tabRequests'.tr(context: context)),
            Tab(text: 'admin.leaveManagement.tabTypes'.tr(context: context)),
            Tab(text: 'admin.leaveManagement.tabHolidays'.tr(context: context)),
          ],
        ),
      ),
      body: SafeArea(
        child: RefreshIndicator(
          color: AppColors.brandPrimary,
          onRefresh: context.read<AdminLeaveRequestsCubit>().loadAll,
          child: BlocBuilder<AdminLeaveRequestsCubit, AdminLeaveRequestsState>(
            builder: (context, state) {
              return state.when(
                initial: () => const SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: AdminLeaveRequestsSkeletonWidget(),
                  ),
                ),
                loading: () => const SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: AdminLeaveRequestsSkeletonWidget(),
                  ),
                ),
                actionSuccess: (_) => const SizedBox.shrink(),
                error: (messageKey) => SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Padding(
                    padding: EdgeInsets.all(24.r),
                    child: Center(
                      child: Text(
                        messageKey.tr(context: context),
                        style: AppTextStyles.font14Regular.copyWith(
                          color: AppColors.error,
                        ),
                      ),
                    ),
                  ),
                ),
                success: (requests, leaveTypes) => TabBarView(
                  controller: _tabController,
                  children: [
                    AdminLeaveManagementRequestsTabWidget(
                      requests: requests,
                      selectedFilter: _selectedFilter,
                      onFilterChanged: (idx) =>
                          setState(() => _selectedFilter = idx),
                    ),
                    AdminLeaveManagementLeaveTypesTabWidget(
                      leaveTypes: leaveTypes,
                      onAddLeaveType: _showAddLeaveTypeSheet,
                    ),
                    const AdminOfficialHolidaysBlocBuilderWidget(),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
