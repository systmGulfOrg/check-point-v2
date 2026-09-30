import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:check_point_v2/core/styles/app_colors.dart';
import 'package:check_point_v2/core/styles/app_text_styles.dart';
import 'package:check_point_v2/core/routes/routes.dart';
import 'package:check_point_v2/features/contractor/presentation/cubit/contractor_cubit.dart';
import 'package:check_point_v2/features/contractor/presentation/cubit/contractor_state.dart';
import 'package:check_point_v2/features/contractor/presentation/widgets/contractor_kpi_card_widget.dart';
import 'package:check_point_v2/features/contractor/presentation/widgets/contractor_quick_action_widget.dart';
import 'package:check_point_v2/features/contractor/presentation/widgets/contractor_attendance_tile_widget.dart';
import 'package:check_point_v2/features/contractor/presentation/widgets/contractor_offline_sync_banner_widget.dart';
import 'package:check_point_v2/features/contractor/presentation/widgets/contractor_punch_sheet_widget.dart';

class ContractorHomeScreen extends StatelessWidget {
  const ContractorHomeScreen({
    super.key,
    this.onViewWorkersTap,
    this.onViewAttendanceTap,
  });

  final VoidCallback? onViewWorkersTap;
  final VoidCallback? onViewAttendanceTap;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContractorCubit, ContractorState>(
      builder: (context, state) {
        final data = state.mapOrNull(success: (value) => value);
        final attendance = data?.attendanceLogs ?? const [];
        final presentCount = attendance
            .where((item) => item.status.toLowerCase() == 'present')
            .length;
        final lateCount = attendance
            .where((item) => item.status.toLowerCase() == 'late')
            .length;
        final absentCount = attendance
            .where((item) => item.status.toLowerCase() == 'absent')
            .length;

        return Scaffold(
          backgroundColor: AppColors.pageBackground,
          appBar: AppBar(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'contractor.dashboard.title'.tr(),
                  style: AppTextStyles.font16Bold.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
                Text(
                  'contractor.dashboard.subtitle'.tr(),
                  style: AppTextStyles.font11Regular.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
            backgroundColor: AppColors.cardBackground,
            elevation: 0,
            actions: [
              IconButton(
                icon: const Icon(
                  Icons.notifications_none_rounded,
                  color: AppColors.brandPrimary,
                ),
                onPressed: () => Navigator.pushNamed(
                  context,
                  AppRoutes.supervisorNotifications,
                ),
              ),
              IconButton(
                icon: const Icon(
                  Icons.refresh_rounded,
                  color: AppColors.brandPrimary,
                ),
                onPressed: () =>
                    context.read<ContractorCubit>().loadDashboardData(),
              ),
            ],
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ContractorOfflineSyncBannerWidget(
                  pendingCount: data?.pendingOfflineCount ?? 0,
                  onSyncTap: () =>
                      context.read<ContractorCubit>().syncOfflineBatch(),
                ),
                Row(
                  children: [
                    Expanded(
                      child: ContractorKpiCardWidget(
                        title: 'contractor.dashboard.myWorkers'.tr(),
                        value: '${data?.workers.length ?? 0}',
                        icon: Icons.groups_rounded,
                        color: AppColors.info,
                        onTap: onViewWorkersTap,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: ContractorKpiCardWidget(
                        title: 'contractor.dashboard.presentToday'.tr(),
                        value: '$presentCount',
                        icon: Icons.check_circle_rounded,
                        color: AppColors.success,
                        onTap: onViewAttendanceTap,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12.h),
                Row(
                  children: [
                    Expanded(
                      child: ContractorKpiCardWidget(
                        title: 'contractor.dashboard.absent'.tr(),
                        value: '$absentCount',
                        icon: Icons.cancel_rounded,
                        color: AppColors.error,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: ContractorKpiCardWidget(
                        title: 'contractor.dashboard.late'.tr(),
                        value: '$lateCount',
                        icon: Icons.access_time_filled_rounded,
                        color: AppColors.warning,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: ContractorKpiCardWidget(
                        title: 'contractor.dashboard.notCheckedIn'.tr(),
                        value:
                            '${(data?.workers.length ?? 0) - attendance.length < 0 ? 0 : (data?.workers.length ?? 0) - attendance.length}',
                        icon: Icons.person_off_rounded,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      ContractorQuickActionWidget(
                        title: 'contractor.dashboard.addWorker'.tr(),
                        icon: Icons.person_add_rounded,
                        color: AppColors.brandPrimary,
                        onTap: () => Navigator.pushNamed(
                          context,
                          AppRoutes.contractorAddWorker,
                        ),
                      ),
                      SizedBox(width: 10.w),
                      ContractorQuickActionWidget(
                        title: 'contractor.dashboard.requestCorrection'.tr(),
                        icon: Icons.edit_calendar_rounded,
                        color: AppColors.info,
                        onTap: () => Navigator.pushNamed(
                          context,
                          AppRoutes.contractorCorrectionRequest,
                        ),
                      ),
                      SizedBox(width: 10.w),
                      ContractorQuickActionWidget(
                        title: 'attendancePoints.title'.tr(),
                        icon: Icons.stars_rounded,
                        color: AppColors.warning,
                        onTap: () => Navigator.pushNamed(
                          context,
                          AppRoutes.attendancePoints,
                        ),
                      ),
                      SizedBox(width: 10.w),
                      ContractorQuickActionWidget(
                        title: 'contractor.punch.title'.tr(),
                        icon: Icons.location_on_outlined,
                        color: AppColors.success,
                        onTap: () {
                          final current = context
                              .read<ContractorCubit>()
                              .state
                              .mapOrNull(success: (value) => value);
                          showModalBottomSheet<void>(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor: AppColors.cardBackground,
                            builder: (_) => ContractorPunchSheetWidget(
                              workers: current?.workers ?? const [],
                              assignments: current?.assignments ?? const [],
                              onPunch: (workerId, siteId) => context
                                  .read<ContractorCubit>()
                                  .punchWorkerAtCurrentLocation(
                                    workerId: workerId,
                                    siteId: siteId,
                                  ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'contractor.dashboard.recentAttendance'.tr(),
                      style: AppTextStyles.font14Bold.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
                    TextButton(
                      onPressed: onViewAttendanceTap,
                      child: Text(
                        'contractor.nav.attendance'.tr(),
                        style: AppTextStyles.font12Bold.copyWith(
                          color: AppColors.brandPrimary,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                ...attendance
                    .take(5)
                    .map(
                      (att) => ContractorAttendanceTileWidget(attendance: att),
                    ),
              ],
            ),
          ),
        );
      },
    );
  }
}
