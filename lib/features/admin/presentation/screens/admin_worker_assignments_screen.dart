import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/contractor/data/models/worker_site_assignment_model.dart';
import 'package:check_point_v2/features/contractor/presentation/cubit/contractor_cubit.dart';
import 'package:check_point_v2/features/contractor/presentation/cubit/contractor_state.dart';
import '../widgets/admin_assign_worker_sheet_widget.dart';
import '../widgets/admin_worker_assignment_card_widget.dart';

class AdminWorkerAssignmentsScreen extends StatefulWidget {
  const AdminWorkerAssignmentsScreen({super.key});

  @override
  State<AdminWorkerAssignmentsScreen> createState() =>
      _AdminWorkerAssignmentsScreenState();
}

class _AdminWorkerAssignmentsScreenState
    extends State<AdminWorkerAssignmentsScreen> {
  late final TextEditingController _searchController;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    context.read<ContractorCubit>().loadDashboardData();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _openAssignSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => BlocProvider.value(
        value: context.read<ContractorCubit>(),
        child: const AdminAssignWorkerSheetWidget(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: Text(
          'admin.assignments.title'.tr(context: context),
          style: AppTextStyles.font18Bold.copyWith(
            color: AppColors.textPrimary,
          ),
        ),
        backgroundColor: AppColors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          color: AppColors.textPrimary,
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: RefreshIndicator(
          color: AppColors.brandPrimary,
          onRefresh: () => context.read<ContractorCubit>().loadDashboardData(),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.fromLTRB(16.w, 4.h, 16.w, 24.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextFormField(
                  hintText: 'admin.contractors.search'.tr(context: context),
                  controller: _searchController,
                  prefixIcon: const Icon(
                    Icons.search_rounded,
                    color: AppColors.textSecondary,
                  ),
                  onChanged: (val) =>
                      setState(() => _searchQuery = val.trim().toLowerCase()),
                ),
                hSpace(14),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'admin.assignments.title'.tr(context: context),
                      style: AppTextStyles.font14SemiBold.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
                    InkWell(
                      onTap: _openAssignSheet,
                      borderRadius: BorderRadius.circular(8.r),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.w,
                          vertical: 6.h,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.softBrandBackground,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.add,
                              size: 16.r,
                              color: AppColors.brandPrimary,
                            ),
                            wSpace(4),
                            Text(
                              'admin.assignments.newAssignment'.tr(
                                context: context,
                              ),
                              style: AppTextStyles.font12SemiBold.copyWith(
                                color: AppColors.brandPrimary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                hSpace(12),
                BlocBuilder<ContractorCubit, ContractorState>(
                  builder: (context, state) {
                    final isLoading = state.maybeMap(
                      loading: (_) => true,
                      initial: (_) => true,
                      orElse: () => false,
                    );

                    if (isLoading) {
                      return Skeletonizer(
                        enabled: true,
                        child: ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: 4,
                          separatorBuilder: (_, _) => hSpace(12),
                          itemBuilder: (_, index) =>
                              const AdminWorkerAssignmentCardWidget(
                            assignment: WorkerSiteAssignmentModel(
                              id: 'skeleton-assignment-id',
                              workerId: 'sk-worker',
                              workerName: 'Loading Worker Name...',
                              contractorName: 'Loading Contractor Name...',
                              branchId: 'sk-branch',
                              siteName: 'Loading Site Location...',
                              validFrom: '2026-01-01',
                              isActive: true,
                            ),
                          ),
                        ),
                      );
                    }

                    final assignments = state.mapOrNull(
                          success: (s) => s.assignments,
                        ) ??
                        const [];

                    final filtered = assignments.where((a) {
                      if (_searchQuery.isEmpty) return true;
                      final matchWorker = a.workerName.toLowerCase().contains(
                            _searchQuery,
                          );
                      final matchContractor = (a.contractorName ?? '')
                          .toLowerCase()
                          .contains(_searchQuery);
                      final matchSite = a.siteName
                          .toLowerCase()
                          .contains(_searchQuery);
                      return matchWorker || matchContractor || matchSite;
                    }).toList();

                    if (filtered.isEmpty) {
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 40.h),
                        child: Center(
                          child: Text(
                            'no_data'.tr(context: context),
                            style: AppTextStyles.font14Regular.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ),
                      );
                    }

                    return ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: filtered.length,
                      separatorBuilder: (context, index) => hSpace(12),
                      itemBuilder: (context, index) {
                        final assignment = filtered[index];
                        return AdminWorkerAssignmentCardWidget(
                          assignment: assignment,
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
