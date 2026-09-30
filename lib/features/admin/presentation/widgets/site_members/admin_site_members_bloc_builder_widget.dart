import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/admin/presentation/widgets/admin_locations_skeleton_widget.dart';
import 'package:check_point_v2/features/contractor/data/models/contractor_company_model.dart';
import 'package:check_point_v2/features/contractor/data/models/contractor_worker_model.dart';
import 'package:check_point_v2/features/contractor/data/models/site_boundary_model.dart';
import 'package:check_point_v2/features/contractor/presentation/cubit/contractor_cubit.dart';
import 'package:check_point_v2/features/contractor/presentation/cubit/contractor_state.dart';
import 'admin_site_contractor_card_widget.dart';
import 'admin_site_members_filter_widget.dart';
import 'admin_site_worker_card_widget.dart';

class AdminSiteMembersBlocBuilderWidget extends StatelessWidget {
  const AdminSiteMembersBlocBuilderWidget({
    required this.site,
    required this.selectedFilter,
    required this.searchQuery,
    super.key,
  });

  final SiteBoundaryModel site;
  final SiteMemberFilterType selectedFilter;
  final String searchQuery;

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<ContractorCubit, ContractorState>(
        builder: (context, state) => state.when(
          initial: () => const AdminLocationsSkeletonWidget(),
          loading: () => const AdminLocationsSkeletonWidget(),
          error: (message) => Padding(
            padding: EdgeInsets.all(24.r),
            child: Center(
              child: Text(
                message.tr(context: context),
                style: AppTextStyles.font14Regular.copyWith(
                  color: AppColors.error,
                ),
              ),
            ),
          ),
          success: (
            contractors,
            workers,
            attendanceLogs,
            corrections,
            sites,
            assignments,
            selectedSiteBoundary,
            customization,
            pendingOfflineCount,
            message,
          ) =>
              _buildContent(
                context,
                contractors: contractors,
                workers: workers,
                assignments: assignments,
              ),
        ),
      );

  Widget _buildContent(
    BuildContext context, {
    required List<ContractorCompanyModel> contractors,
    required List<ContractorWorkerModel> workers,
    required List<dynamic> assignments,
  }) {
    final siteNameLower = site.siteName.trim().toLowerCase();
    final siteIdLower = site.siteId.trim().toLowerCase();

    // 1. Resolve site workers
    final siteWorkers = workers.where((worker) {
      final wSite = worker.siteName.trim().toLowerCase();
      final directMatch =
          wSite == siteNameLower || wSite == siteIdLower && wSite.isNotEmpty;
      final assignmentMatch = assignments.any((a) {
        final aSiteId = (a.branchId as String? ?? '').trim().toLowerCase();
        final aSiteName = (a.siteName as String? ?? '').trim().toLowerCase();
        final aWorkerId = (a.workerId as String? ?? '').trim();
        final isActive = a.isActive as bool? ?? true;
        return isActive &&
            aWorkerId == worker.id &&
            (aSiteId == siteIdLower || aSiteName == siteNameLower);
      });
      return directMatch || assignmentMatch;
    }).toList();

    // 2. Count workers per contractor on this site
    final workersCountByContractor = <String, int>{};
    for (final worker in siteWorkers) {
      final cId = worker.contractorId ?? '';
      workersCountByContractor[cId] =
          (workersCountByContractor[cId] ?? 0) + 1;
    }

    // 3. Resolve contractors on this site
    final siteContractors = contractors.where((c) {
      final hasWorkersOnSite = (workersCountByContractor[c.id] ?? 0) > 0;
      final hasAssignmentOnSite = assignments.any((a) {
        final aSiteId = (a.branchId as String? ?? '').trim().toLowerCase();
        final aSiteName = (a.siteName as String? ?? '').trim().toLowerCase();
        final aContractorId = (a.contractorId as String? ?? '').trim();
        final isActive = a.isActive as bool? ?? true;
        return isActive &&
            aContractorId == c.id &&
            (aSiteId == siteIdLower || aSiteName == siteNameLower);
      });
      return hasWorkersOnSite || hasAssignmentOnSite || siteWorkers.isEmpty;
    }).toList();

    // 4. Apply search filter
    final query = searchQuery.trim().toLowerCase();

    final filteredWorkers = siteWorkers.where((w) {
      if (query.isEmpty) return true;
      final name = w.fullName.toLowerCase();
      final code = w.workerCode.toLowerCase();
      final title = w.jobTitle.toLowerCase();
      final contractor = (w.contractorName ?? '').toLowerCase();
      return name.contains(query) ||
          code.contains(query) ||
          title.contains(query) ||
          contractor.contains(query);
    }).toList();

    final filteredContractors = siteContractors.where((c) {
      if (query.isEmpty) return true;
      final name = c.name.toLowerCase();
      final code = c.code.toLowerCase();
      final contact = (c.contactName ?? '').toLowerCase();
      final phone = (c.contactPhone ?? '').toLowerCase();
      return name.contains(query) ||
          code.contains(query) ||
          contact.contains(query) ||
          phone.contains(query);
    }).toList();

    final showContractors =
        selectedFilter == SiteMemberFilterType.all ||
        selectedFilter == SiteMemberFilterType.contractors;
    final showWorkers =
        selectedFilter == SiteMemberFilterType.all ||
        selectedFilter == SiteMemberFilterType.workers;

    final isEmpty =
        (showContractors && filteredContractors.isEmpty && !showWorkers) ||
        (showWorkers && filteredWorkers.isEmpty && !showContractors) ||
        (showContractors &&
            showWorkers &&
            filteredContractors.isEmpty &&
            filteredWorkers.isEmpty);

    if (isEmpty) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 40.h),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.people_outline_rounded,
                size: 48.r,
                color: AppColors.placeholder,
              ),
              hSpace(12),
              Text(
                'admin.siteMembers.empty'.tr(context: context),
                style: AppTextStyles.font14Regular.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showContractors && filteredContractors.isNotEmpty) ...[
          if (selectedFilter == SiteMemberFilterType.all) ...[
            Padding(
              padding: EdgeInsets.only(bottom: 8.h),
              child: Text(
                'admin.siteMembers.contractors'.tr(context: context),
                style: AppTextStyles.font14SemiBold.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
            ),
          ],
          for (final contractor in filteredContractors) ...[
            AdminSiteContractorCardWidget(
              contractor: contractor,
              assignedWorkersCount:
                  workersCountByContractor[contractor.id] ??
                  contractor.workerCount,
            ),
            hSpace(10),
          ],
          if (showWorkers && filteredWorkers.isNotEmpty) hSpace(10),
        ],
        if (showWorkers && filteredWorkers.isNotEmpty) ...[
          if (selectedFilter == SiteMemberFilterType.all) ...[
            Padding(
              padding: EdgeInsets.only(bottom: 8.h),
              child: Text(
                'admin.siteMembers.workers'.tr(context: context),
                style: AppTextStyles.font14SemiBold.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
            ),
          ],
          for (final worker in filteredWorkers) ...[
            AdminSiteWorkerCardWidget(worker: worker),
            hSpace(10),
          ],
        ],
      ],
    );
  }
}
