import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:check_point_v2/core/styles/app_colors.dart';
import 'package:check_point_v2/core/styles/app_text_styles.dart';
import 'package:check_point_v2/core/routes/routes.dart';
import 'package:check_point_v2/features/contractor/data/models/contractor_company_model.dart';
import 'package:check_point_v2/features/contractor/data/models/contractor_worker_model.dart';
import 'package:check_point_v2/features/contractor/data/models/contractor_attendance_model.dart';
import 'package:check_point_v2/features/contractor/data/models/site_boundary_model.dart';
import 'package:check_point_v2/features/contractor/data/models/worker_site_assignment_model.dart';
import 'package:check_point_v2/features/contractor/presentation/cubit/contractor_cubit.dart';
import 'package:check_point_v2/features/employee/presentation/cubit/attendance/employee_attendance_cubit.dart';
import 'supervisor_samco_kpi_card_widget.dart';
import 'package:check_point_v2/core/app/app_spaces.dart';

class SupervisorSamcoSiteCardWidget extends StatefulWidget {
  const SupervisorSamcoSiteCardWidget({super.key});

  @override
  State<SupervisorSamcoSiteCardWidget> createState() =>
      _SupervisorSamcoSiteCardWidgetState();
}

class _SupervisorSamcoSiteCardWidgetState
    extends State<SupervisorSamcoSiteCardWidget> {
  String? _selectedSiteId;
  bool _showAllSites = false;

  @override
  Widget build(BuildContext context) {
    final state = context.watch<ContractorCubit>().state;

    return state.maybeWhen(
      loading: () => _buildLoadingCard(),
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
      ) => _buildSuccessCard(
        context,
        contractors: contractors,
        workers: workers,
        attendanceLogs: attendanceLogs,
        sites: sites,
        assignments: assignments,
      ),
      orElse: () => const SizedBox.shrink(),
    );
  }

  Widget _buildLoadingCard() {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(color: AppColors.border.withValues(alpha: 0.7)),
      ),
      child: Center(
        child: Column(
          children: [
            const CircularProgressIndicator(color: AppColors.brandPrimary),
            hSpace(10),
            Text(
              'جاري تحديث إحصائيات الموقع والعمالة...',
              style: AppTextStyles.font12Medium.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSuccessCard(
    BuildContext context, {
    required List<ContractorCompanyModel> contractors,
    required List<ContractorWorkerModel> workers,
    required List<ContractorAttendanceModel> attendanceLogs,
    required List<SiteBoundaryModel> sites,
    required List<WorkerSiteAssignmentModel> assignments,
  }) {
    final profile = context.read<EmployeeAttendanceCubit>().employeeProfile;
    final userBranchId = profile?.branchId?.toString();

    // Default site resolution: match supervisor branch if not set
    if (_selectedSiteId == null && !_showAllSites && sites.isNotEmpty) {
      final matchingBranchSite = sites.where((s) => s.siteId == userBranchId).firstOrNull;
      _selectedSiteId = matchingBranchSite?.siteId ?? sites.first.siteId;
    }

    final selectedSite = _showAllSites
        ? null
        : sites.where((s) => s.siteId == _selectedSiteId).firstOrNull ??
            sites.firstOrNull;

    // Filter workers by site
    final siteWorkers = _showAllSites || selectedSite == null
        ? workers
        : workers.where((w) {
            if (w.siteName != null && w.siteName == selectedSite.siteName) {
              return true;
            }
            return assignments.any((a) =>
                a.workerId == w.id &&
                (a.branchId == selectedSite.siteId ||
                    a.siteName == selectedSite.siteName));
          }).toList();

    final totalWorkersCount = _showAllSites
        ? workers.length
        : (siteWorkers.isNotEmpty
            ? siteWorkers.length
            : (selectedSite?.workerCount ?? 0));

    // Filter attendance by site
    final siteAttendance = _showAllSites || selectedSite == null
        ? attendanceLogs
        : attendanceLogs.where((item) {
            return item.siteId == selectedSite.siteId ||
                item.siteName == selectedSite.siteName;
          }).toList();

    final present = siteAttendance
        .where((item) => item.status.toLowerCase() == 'present')
        .length;
    final outside =
        siteAttendance.where((item) => !item.isInsideGeofence).length;
    final absent = totalWorkersCount > siteAttendance.length
        ? totalWorkersCount - siteAttendance.length
        : 0;
    final lateCount = siteAttendance
        .where((item) => item.status.toLowerCase() == 'late')
        .length;

    // Filter contractors present at this site
    final siteContractorIds = siteWorkers
        .map((w) => w.contractorId)
        .where((id) => id != null && id.isNotEmpty)
        .toSet();

    final contractorsCount = _showAllSites
        ? contractors.length
        : (siteContractorIds.isNotEmpty
            ? siteContractorIds.length
            : contractors.length);

    final displayName = _showAllSites
        ? 'جميع مواقع الشركة (إجمالي)'
        : (selectedSite?.siteName ??
            'supervisor.samco.noAssignedSites'.tr());
    final displayProject = _showAllSites
        ? 'عرض تراكمي لكافة المواقع المسندة'
        : (selectedSite?.projectName ??
            'supervisor.samco.siteSummaryUnavailable'.tr());

    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(color: AppColors.border.withValues(alpha: 0.7)),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow.withValues(alpha: 0.04),
            blurRadius: 10.r,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8.r),
                decoration: BoxDecoration(
                  color: AppColors.brandPrimary.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Icon(
                  Icons.location_city_rounded,
                  color: AppColors.brandPrimary,
                  size: 22.r,
                ),
              ),
              wSpace(10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            displayName,
                            style: AppTextStyles.font14Bold,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        wSpace(4),
                        if (sites.length > 1)
                          PopupMenuButton<String>(
                            icon: Icon(
                              Icons.arrow_drop_down_circle_outlined,
                              size: 18.r,
                              color: AppColors.brandPrimary,
                            ),
                            tooltip: 'تغيير الموقع المعروض',
                            onSelected: (val) {
                              setState(() {
                                if (val == '__all__') {
                                  _showAllSites = true;
                                  _selectedSiteId = null;
                                } else {
                                  _showAllSites = false;
                                  _selectedSiteId = val;
                                }
                              });
                            },
                            itemBuilder: (context) => [
                              const PopupMenuItem(
                                value: '__all__',
                                child: Text('جميع المواقع (إجمالي الشركة)'),
                              ),
                              ...sites.map(
                                (s) => PopupMenuItem(
                                  value: s.siteId,
                                  child: Text(s.siteName),
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                    hSpace(2),
                    Text(
                      displayProject,
                      style: AppTextStyles.font11Regular.copyWith(
                        color: AppColors.textSecondary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.map_rounded,
                  color: AppColors.brandPrimary,
                  size: 24.r,
                ),
                tooltip: 'Live Geofence Map',
                onPressed: () =>
                    Navigator.pushNamed(context, AppRoutes.supervisorSiteMap),
              ),
            ],
          ),
          hSpace(14),
          Row(
            children: [
              Expanded(
                child: SupervisorSamcoKpiCardWidget(
                  title: 'supervisor.samco.totalWorkers'.tr(),
                  value: '$totalWorkersCount',
                  icon: Icons.groups_rounded,
                  color: AppColors.info,
                ),
              ),
              wSpace(10),
              Expanded(
                child: SupervisorSamcoKpiCardWidget(
                  title: 'contractor.dashboard.presentToday'.tr(),
                  value: '$present',
                  icon: Icons.check_circle_rounded,
                  color: AppColors.success,
                ),
              ),
              wSpace(10),
              Expanded(
                child: SupervisorSamcoKpiCardWidget(
                  title: 'supervisor.samco.outsideGeofence'.tr(),
                  value: '$outside',
                  icon: Icons.location_off_rounded,
                  color: AppColors.error,
                  onTap: () =>
                      Navigator.pushNamed(context, AppRoutes.supervisorSiteMap),
                ),
              ),
            ],
          ),
          hSpace(10),
          Row(
            children: [
              Expanded(
                child: SupervisorSamcoKpiCardWidget(
                  title: 'contractor.dashboard.absent'.tr(),
                  value: '$absent',
                  icon: Icons.cancel_rounded,
                  color: AppColors.error,
                ),
              ),
              wSpace(10),
              Expanded(
                child: SupervisorSamcoKpiCardWidget(
                  title: 'contractor.dashboard.late'.tr(),
                  value: '$lateCount',
                  icon: Icons.access_time_filled_rounded,
                  color: AppColors.warning,
                ),
              ),
              wSpace(10),
              Expanded(
                child: SupervisorSamcoKpiCardWidget(
                  title: 'supervisor.samco.contractorsCount'.tr(),
                  value: '$contractorsCount',
                  icon: Icons.business_center_rounded,
                  color: AppColors.brandPrimary,
                  onTap: () => Navigator.pushNamed(
                    context,
                    AppRoutes.supervisorContractors,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
