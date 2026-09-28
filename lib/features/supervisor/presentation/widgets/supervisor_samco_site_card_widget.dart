import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:check_point_v2/core/styles/app_colors.dart';
import 'package:check_point_v2/core/styles/app_text_styles.dart';
import 'package:check_point_v2/core/routes/routes.dart';
import 'package:check_point_v2/features/contractor/presentation/cubit/contractor_cubit.dart';
import 'package:check_point_v2/features/contractor/presentation/cubit/contractor_state.dart';
import 'supervisor_samco_kpi_card_widget.dart';

class SupervisorSamcoSiteCardWidget extends StatelessWidget {
  const SupervisorSamcoSiteCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.select<ContractorCubit, ContractorState>(
      (cubit) => cubit.state,
    );
    final data = state.mapOrNull(success: (value) => value);
    final site = data?.sites.isNotEmpty == true ? data!.sites.first : null;
    final attendance = data?.attendanceLogs ?? const [];
    final workers = data?.workers.length ?? site?.workerCount ?? 0;
    final present = attendance
        .where((item) => item.status.toLowerCase() == 'present')
        .length;
    final outside = attendance.where((item) => !item.isInsideGeofence).length;
    final absent = workers > attendance.length
        ? workers - attendance.length
        : 0;
    final contractors = data?.contractors.length ?? 0;
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
              Expanded(
                child: Row(
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
                    SizedBox(width: 10.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            site?.siteName ??
                                'supervisor.samco.noAssignedSites'.tr(),
                            style: AppTextStyles.font14Bold,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            site?.projectName ??
                                'supervisor.samco.siteSummaryUnavailable'.tr(),
                            style: AppTextStyles.font11Regular.copyWith(
                              color: AppColors.textSecondary,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
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
          SizedBox(height: 14.h),
          Row(
            children: [
              Expanded(
                child: SupervisorSamcoKpiCardWidget(
                  title: 'supervisor.samco.totalWorkers'.tr(),
                  value: '$workers',
                  icon: Icons.groups_rounded,
                  color: AppColors.info,
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: SupervisorSamcoKpiCardWidget(
                  title: 'contractor.dashboard.presentToday'.tr(),
                  value: '$present',
                  icon: Icons.check_circle_rounded,
                  color: AppColors.success,
                ),
              ),
              SizedBox(width: 10.w),
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
          SizedBox(height: 10.h),
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
              SizedBox(width: 10.w),
              Expanded(
                child: SupervisorSamcoKpiCardWidget(
                  title: 'contractor.dashboard.late'.tr(),
                  value:
                      '${attendance.where((item) => item.status.toLowerCase() == 'late').length}',
                  icon: Icons.access_time_filled_rounded,
                  color: AppColors.warning,
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: SupervisorSamcoKpiCardWidget(
                  title: 'supervisor.samco.contractorsCount'.tr(),
                  value: '$contractors',
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
