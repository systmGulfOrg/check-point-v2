import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/contractor/data/models/site_boundary_model.dart';
import 'admin_location_action_widget.dart';

class AdminSiteCardWidget extends StatelessWidget {
  const AdminSiteCardWidget({
    required this.site,
    required this.onTap,
    this.onEdit,
    this.onDelete,
    super.key,
  });

  final SiteBoundaryModel site;
  final VoidCallback onTap;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) => Container(
    decoration: AppDecorations.card,
    clipBehavior: Clip.antiAlias,
    child: Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.all(14.r),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 19.r,
                  backgroundColor: AppColors.softBlueBackground,
                  child: Icon(
                    Icons.map_outlined,
                    color: AppColors.info,
                    size: 20.r,
                  ),
                ),
                vSpace(12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              site.siteName.isEmpty ? '-' : site.siteName,
                              style: AppTextStyles.font14SemiBold,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8.w,
                              vertical: 2.h,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.softBlueBackground,
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            child: Text(
                              '${site.workerCount} ${'supervisor.samco.totalWorkers'.tr(context: context)}',
                              style: AppTextStyles.font11Medium.copyWith(
                                color: AppColors.info,
                              ),
                            ),
                          ),
                        ],
                      ),
                      hSpace(4),
                      Text(
                        site.projectName ??
                            (site.boundaryType == 'polygon'
                                ? 'admin.locations.geofenced'.tr(
                                    context: context,
                                  )
                                : 'admin.locations.sites.construction.name'.tr(
                                    context: context,
                                  )),
                        style: AppTextStyles.font12Regular,
                      ),
                      hSpace(2),
                      Text(
                        site.centerLat != null && site.centerLng != null
                            ? '${site.centerLat!.toStringAsFixed(4)}, ${site.centerLng!.toStringAsFixed(4)} • ${site.radiusMeters.toInt()}m'
                            : '${site.radiusMeters.toInt()}m',
                        style: AppTextStyles.font12Regular.copyWith(
                          color: AppColors.placeholder,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 14.r,
                  color: AppColors.textSecondary,
                ),
              ],
            ),
          ),
        ),
        Row(
          children: [
            Expanded(
              child: AdminLocationActionWidget(
                labelKey: 'admin.siteMembers.viewMembers',
                color: AppColors.brandPrimary,
                onTap: onTap,
              ),
            ),
            if (onEdit != null)
              Expanded(
                child: AdminLocationActionWidget(
                  labelKey: 'admin.locations.edit',
                  color: AppColors.textSecondary,
                  onTap: onEdit,
                ),
              ),
            if (onDelete != null)
              Expanded(
                child: AdminLocationActionWidget(
                  labelKey: 'admin.locations.delete',
                  color: AppColors.error,
                  onTap: onDelete,
                ),
              ),
          ],
        ),
      ],
    ),
  );
}
