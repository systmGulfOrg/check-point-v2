import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:check_point_v2/core/app/app_spaces.dart';
import 'package:check_point_v2/core/routes/routes.dart';
import 'package:check_point_v2/core/styles/app_colors.dart';
import 'package:check_point_v2/core/styles/app_text_styles.dart';
import 'package:check_point_v2/features/contractor/data/models/contractor_company_model.dart';
import 'package:check_point_v2/features/contractor/data/models/contractor_worker_model.dart';
import 'package:check_point_v2/features/contractor/data/models/contractor_attendance_model.dart';
import 'package:check_point_v2/features/contractor/data/models/site_boundary_model.dart';
import 'package:check_point_v2/features/contractor/presentation/cubit/contractor_cubit.dart';
import 'package:check_point_v2/features/contractor/presentation/cubit/contractor_state.dart';
import 'package:check_point_v2/features/contractor/presentation/widgets/contractor_batch_attendance_sheet_widget.dart';
import 'package:check_point_v2/features/contractor/presentation/widgets/contractor_details_sheet_widget.dart';
import 'package:check_point_v2/features/contractor/presentation/widgets/contractor_offline_sync_banner_widget.dart';
import 'package:check_point_v2/features/supervisor/presentation/widgets/supervisor_contractor_headcount_card_widget.dart';

class SupervisorSiteContractorsScreen extends StatelessWidget {
  const SupervisorSiteContractorsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: Text(
          'supervisor.nav.contractors'.tr(),
          style: AppTextStyles.font16Bold.copyWith(
            color: AppColors.textPrimary,
          ),
        ),
        backgroundColor: AppColors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(
              Icons.person_add_alt_1_rounded,
              color: AppColors.brandPrimary,
              size: 22.r,
            ),
            tooltip: 'contractor.addWorker.title'.tr(),
            onPressed: () => Navigator.pushNamed(
              context,
              AppRoutes.contractorAddWorker,
            ),
          ),
        ],
      ),
      body: BlocBuilder<ContractorCubit, ContractorState>(
        builder: (context, state) {
          return state.when(
            initial: () => const SizedBox.shrink(),
            loading: () => const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(color: AppColors.brandPrimary),
                  SizedBox(height: 12),
                  Text(
                    'جاري تحميل بيانات المقاولين والعمالة...',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            error: (message) => Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_outline_rounded,
                      size: 48.r,
                      color: AppColors.error,
                    ),
                    hSpace(12),
                    Text(
                      message.tr(),
                      style: AppTextStyles.font14Medium.copyWith(
                        color: AppColors.textPrimary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    hSpace(16),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.brandPrimary,
                        foregroundColor: AppColors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                      ),
                      onPressed: () => context
                          .read<ContractorCubit>()
                          .loadDashboardData(),
                      icon: const Icon(Icons.refresh_rounded),
                      label: const Text('إعادة المحاولة'),
                    ),
                  ],
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
            ) => _buildContent(
              context,
              contractors: contractors,
              workers: workers,
              attendanceLogs: attendanceLogs,
              sites: sites,
              pendingOfflineCount: pendingOfflineCount,
            ),
          );
        },
      ),
    );
  }

  Widget _buildContent(
    BuildContext context, {
    required List<ContractorCompanyModel> contractors,
    required List<ContractorWorkerModel> workers,
    required List<ContractorAttendanceModel> attendanceLogs,
    required List<SiteBoundaryModel> sites,
    required int pendingOfflineCount,
  }) {
    final workersByContractor = <String, int>{};
    for (final worker in workers) {
      final id = worker.contractorId ?? '';
      workersByContractor[id] = (workersByContractor[id] ?? 0) + 1;
    }

    return RefreshIndicator(
      color: AppColors.brandPrimary,
      onRefresh: () => context.read<ContractorCubit>().loadDashboardData(),
      child: ListView(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        children: [
          ContractorOfflineSyncBannerWidget(
            pendingCount: pendingOfflineCount,
            onSyncTap: () => context.read<ContractorCubit>().syncOfflineBatch(),
          ),
          hSpace(12),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.brandPrimary,
                    foregroundColor: AppColors.white,
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  onPressed: () {
                    showModalBottomSheet<void>(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (_) => BlocProvider.value(
                        value: context.read<ContractorCubit>(),
                        child: ContractorBatchAttendanceSheetWidget(
                          workers: workers,
                          sites: sites,
                          contractors: contractors,
                          contractorId: contractors.firstOrNull?.id ?? '',
                        ),
                      ),
                    );
                  },
                  icon: Icon(Icons.qr_code_scanner_rounded, size: 20.r),
                  label: Text(
                    'contractor.quickActions.batchAttendance'.tr(),
                    style: AppTextStyles.font13SemiBold.copyWith(
                      color: AppColors.white,
                    ),
                  ),
                ),
              ),
              wSpace(10),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.softBrandBackground,
                  foregroundColor: AppColors.brandPrimaryDark,
                  elevation: 0,
                  padding: EdgeInsets.symmetric(
                    horizontal: 14.w,
                    vertical: 12.h,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                onPressed: () => Navigator.pushNamed(
                  context,
                  AppRoutes.contractorAddWorker,
                ),
                icon: Icon(Icons.add_rounded, size: 20.r),
                label: Text(
                  'contractor.quickActions.addWorker'.tr(),
                  style: AppTextStyles.font13Medium.copyWith(
                    color: AppColors.brandPrimaryDark,
                  ),
                ),
              ),
            ],
          ),
          hSpace(16),
          Text(
            'supervisor.samco.contractorsCount'.tr(),
            style: AppTextStyles.font16Bold,
          ),
          hSpace(10),
          if (contractors.isEmpty)
            Padding(
              padding: EdgeInsets.symmetric(vertical: 32.h),
              child: Center(
                child: Text(
                  'supervisor.samco.noAssignedSites'.tr(),
                  style: AppTextStyles.font13Regular.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
            )
          else
            ...contractors.map((contractor) {
              final logs = attendanceLogs
                  .where((item) => item.contractorId == contractor.id)
                  .toList();
              final contractorWorkers = workers
                  .where((w) => w.contractorId == contractor.id)
                  .toList();
              return SupervisorContractorHeadcountCardWidget(
                contractorName: contractor.name,
                code: contractor.code,
                presentCount: logs
                    .where((item) => item.status.toLowerCase() == 'present')
                    .length,
                totalCount: workersByContractor[contractor.id] ??
                    contractor.workerCount,
                lateCount: logs
                    .where((item) => item.status.toLowerCase() == 'late')
                    .length,
                outsideGeofenceCount: logs
                    .where((item) => !item.isInsideGeofence)
                    .length,
                onTap: () {
                  showModalBottomSheet<void>(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    builder: (_) => BlocProvider.value(
                      value: context.read<ContractorCubit>(),
                      child: ContractorDetailsSheetWidget(
                        contractor: contractor,
                        workers: contractorWorkers,
                        attendanceLogs: logs,
                        sites: sites,
                      ),
                    ),
                  );
                },
              );
            }),
        ],
      ),
    );
  }
}
