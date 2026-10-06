import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/supervisor/presentation/widgets/supervisor_polygon_geofence_map_widget.dart';
import 'package:check_point_v2/features/supervisor/presentation/widgets/supervisor_violation_tile_widget.dart';
import 'package:check_point_v2/features/contractor/presentation/cubit/contractor_cubit.dart';
import 'package:check_point_v2/features/contractor/presentation/cubit/contractor_state.dart';
import 'package:check_point_v2/features/contractor/data/models/site_boundary_model.dart';

class SupervisorSiteMapScreen extends StatefulWidget {
  const SupervisorSiteMapScreen({super.key});

  @override
  State<SupervisorSiteMapScreen> createState() =>
      _SupervisorSiteMapScreenState();
}

class _SupervisorSiteMapScreenState extends State<SupervisorSiteMapScreen> {
  String? _selectedSiteId;

  @override
  void initState() {
    super.initState();
    context.read<ContractorCubit>().loadDashboardData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      appBar: AppBar(
        title: Text(
          'supervisor.samco.liveMap'.tr(context: context),
          style: AppTextStyles.font16Bold.copyWith(
            color: AppColors.textPrimary,
          ),
        ),
        backgroundColor: AppColors.cardBackground,
        elevation: 0,
        leading: Navigator.canPop(context)
            ? IconButton(
                icon: const Icon(Icons.arrow_back_rounded, color: AppColors.textPrimary),
                onPressed: () => Navigator.pop(context),
              )
            : null,
      ),
      body: BlocBuilder<ContractorCubit, ContractorState>(
        builder: (context, state) {
          final isLoading = state.maybeMap(
            loading: (_) => true,
            orElse: () => false,
          );

          final data = state.mapOrNull(success: (value) => value);
          final sites = data?.sites ?? const <SiteBoundaryModel>[];
          final selectedSite = sites.isNotEmpty
              ? sites.firstWhere(
                  (s) => s.siteId == _selectedSiteId,
                  orElse: () => sites.first,
                )
              : null;

          final allLogs = data?.attendanceLogs ?? const [];
          final siteLogs = selectedSite == null
              ? allLogs
              : allLogs
                  .where((item) =>
                      item.siteId == selectedSite.siteId ||
                      item.siteName == selectedSite.siteName)
                  .toList();

          final outside = siteLogs.where((item) => !item.isInsideGeofence).toList();
          final insideCount = siteLogs.length - outside.length;

          return RefreshIndicator(
            color: AppColors.brandPrimary,
            onRefresh: () => context.read<ContractorCubit>().loadDashboardData(),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Site Selector (if multiple sites available)
                  if (sites.length > 1) ...[
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: sites.map((siteItem) {
                          final isSelected =
                              (selectedSite?.siteId == siteItem.siteId);
                          return Padding(
                            padding: EdgeInsetsDirectional.only(end: 8.w),
                            child: AppInteractiveScaleWidget(
                              onTap: () {
                                setState(() {
                                  _selectedSiteId = siteItem.siteId;
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 14.w,
                                  vertical: 8.h,
                                ),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? AppColors.brandPrimary
                                      : AppColors.cardBackground,
                                  borderRadius: BorderRadius.circular(12.r),
                                  border: Border.all(
                                    color: isSelected
                                        ? AppColors.brandPrimary
                                        : AppColors.border,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColors.shadow.withValues(alpha: 0.04),
                                      blurRadius: 6,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.location_city_rounded,
                                      size: 14.r,
                                      color: isSelected
                                          ? AppColors.white
                                          : AppColors.textSecondary,
                                    ),
                                    wSpace(6),
                                    Text(
                                      siteItem.siteName,
                                      style: AppTextStyles.font12Medium.copyWith(
                                        color: isSelected
                                            ? AppColors.white
                                            : AppColors.textPrimary,
                                        fontWeight: isSelected
                                            ? FontWeight.w700
                                            : FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    hSpace(14),
                  ],

                  // Real Interactive Google Map Widget
                  Skeletonizer(
                    enabled: isLoading,
                    child: SupervisorPolygonGeofenceMapWidget(
                      site: selectedSite,
                      attendance: siteLogs,
                      insideCount: insideCount,
                      outsideCount: outside.length,
                    ),
                  ),

                  hSpace(20),

                  // Violations Header with Count Badge
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'supervisor.samco.geofenceViolations'.tr(context: context),
                        style: AppTextStyles.font16Bold,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.w,
                          vertical: 4.h,
                        ),
                        decoration: BoxDecoration(
                          color: outside.isNotEmpty
                              ? AppColors.softRedBackground
                              : AppColors.softGreenBackground,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Text(
                          outside.isNotEmpty
                              ? '${outside.length} ${'supervisor.samco.outsideGeofenceShort'.tr(context: context)}'
                              : 'supervisor.samco.insideBoundary'.tr(context: context),
                          style: AppTextStyles.font12Bold.copyWith(
                            color: outside.isNotEmpty
                                ? AppColors.error
                                : AppColors.success,
                          ),
                        ),
                      ),
                    ],
                  ),

                  hSpace(12),

                  // Violations List or Clean 100% Compliance State
                  if (outside.isNotEmpty)
                    ...outside.map(
                      (item) => SupervisorViolationTileWidget(
                        name: item.workerName,
                        trade: item.jobTitle.isNotEmpty ? item.jobTitle : item.workerCode,
                        contractor: item.projectName.isNotEmpty
                            ? item.projectName
                            : (item.contractorId ?? '-'),
                        distance: item.checkInTime != null
                            ? item.checkInTime!
                            : 'supervisor.samco.outsideBoundary'.tr(context: context),
                      ),
                    )
                  else
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(20.r),
                      decoration: BoxDecoration(
                        color: AppColors.cardBackground,
                        borderRadius: BorderRadius.circular(16.r),
                        border: Border.all(
                          color: AppColors.success.withValues(alpha: 0.3),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.shadow.withValues(alpha: 0.03),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(12.r),
                            decoration: const BoxDecoration(
                              color: AppColors.softGreenBackground,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.verified_user_rounded,
                              color: AppColors.success,
                              size: 32.r,
                            ),
                          ),
                          hSpace(12),
                          Text(
                            'supervisor.samco.noViolationsTitle'.tr(context: context),
                            style: AppTextStyles.font16Bold.copyWith(
                              color: AppColors.textPrimary,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          hSpace(4),
                          Text(
                            'supervisor.samco.noViolationsSubtitle'.tr(context: context),
                            style: AppTextStyles.font12Regular.copyWith(
                              color: AppColors.textSecondary,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
