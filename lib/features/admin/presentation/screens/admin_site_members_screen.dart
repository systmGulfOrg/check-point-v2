import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/admin/presentation/widgets/site_members/admin_site_members_bloc_builder_widget.dart';
import 'package:check_point_v2/features/admin/presentation/widgets/site_members/admin_site_members_filter_widget.dart';
import 'package:check_point_v2/features/admin/presentation/widgets/site_members/admin_site_members_header_widget.dart';
import 'package:check_point_v2/features/contractor/data/models/site_boundary_model.dart';
import 'package:check_point_v2/features/contractor/presentation/cubit/contractor_cubit.dart';
import 'package:check_point_v2/features/contractor/presentation/cubit/contractor_state.dart';

class AdminSiteMembersArgs {
  const AdminSiteMembersArgs({required this.site});

  final SiteBoundaryModel site;
}

class AdminSiteMembersScreen extends StatefulWidget {
  const AdminSiteMembersScreen({required this.args, super.key});

  final AdminSiteMembersArgs args;

  @override
  State<AdminSiteMembersScreen> createState() => _AdminSiteMembersScreenState();
}

class _AdminSiteMembersScreenState extends State<AdminSiteMembersScreen> {
  late final TextEditingController _searchController;
  SiteMemberFilterType _selectedFilter = SiteMemberFilterType.all;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final site = widget.args.site;

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        centerTitle: true,
        title: Text(
          site.siteName.isEmpty
              ? 'admin.siteMembers.title'.tr(context: context)
              : site.siteName,
          style: AppTextStyles.font18Bold,
        ),
      ),
      body: SafeArea(
        child: RefreshIndicator(
          color: AppColors.brandPrimary,
          onRefresh: () => context.read<ContractorCubit>().loadDashboardData(),
          child: BlocBuilder<ContractorCubit, ContractorState>(
            builder: (context, state) {
              final data = state.mapOrNull(success: (s) => s);
              final siteNameLower = site.siteName.trim().toLowerCase();
              final siteIdLower = site.siteId.trim().toLowerCase();

              final siteWorkers = (data?.workers ?? const []).where((worker) {
                final wSite = (worker.siteName ?? '').trim().toLowerCase();
                final directMatch =
                    wSite == siteNameLower ||
                    wSite == siteIdLower && wSite.isNotEmpty;
                final assignmentMatch = (data?.assignments ?? const []).any((
                  a,
                ) {
                  final aSiteId = (a.branchId).trim().toLowerCase();
                  final aSiteName = (a.siteName).trim().toLowerCase();
                  return a.isActive &&
                      a.workerId == worker.id &&
                      (aSiteId == siteIdLower || aSiteName == siteNameLower);
                });
                return directMatch || assignmentMatch;
              }).toList();

              final workersCountByContractor = <String, int>{};
              for (final worker in siteWorkers) {
                final cId = worker.contractorId ?? '';
                workersCountByContractor[cId] =
                    (workersCountByContractor[cId] ?? 0) + 1;
              }

              final siteContractors = (data?.contractors ?? const []).where((
                c,
              ) {
                final hasWorkers =
                    (workersCountByContractor[c.id] ?? 0) > 0;
                final hasAssignment = (data?.assignments ?? const []).any((
                  a,
                ) {
                  final aSiteId = (a.branchId).trim().toLowerCase();
                  final aSiteName = (a.siteName).trim().toLowerCase();
                  return a.isActive &&
                      a.contractorId == c.id &&
                      (aSiteId == siteIdLower || aSiteName == siteNameLower);
                });
                return hasWorkers || hasAssignment || siteWorkers.isEmpty;
              }).toList();

              final contractorsCount = siteContractors.length;
              final workersCount = siteWorkers.length;
              final allCount = contractorsCount + workersCount;

              return SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 24.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AdminSiteMembersHeaderWidget(
                      site: site,
                      contractorCount: contractorsCount,
                      workerCount: workersCount,
                    ),
                    hSpace(14),
                    CustomTextFormField(
                      controller: _searchController,
                      hintText: 'admin.siteMembers.searchHint'.tr(
                        context: context,
                      ),
                      prefixIcon: const Icon(
                        Icons.search_rounded,
                        color: AppColors.textSecondary,
                      ),
                      onChanged: (value) => setState(() => _searchQuery = value),
                    ),
                    hSpace(12),
                    AdminSiteMembersFilterWidget(
                      selectedFilter: _selectedFilter,
                      allCount: allCount,
                      contractorsCount: contractorsCount,
                      workersCount: workersCount,
                      onFilterSelected: (filter) =>
                          setState(() => _selectedFilter = filter),
                    ),
                    hSpace(14),
                    AdminSiteMembersBlocBuilderWidget(
                      site: site,
                      selectedFilter: _selectedFilter,
                      searchQuery: _searchQuery,
                    ),
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
