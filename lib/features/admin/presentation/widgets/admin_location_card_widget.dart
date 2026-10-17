import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'admin_location_action_widget.dart';
import 'admin_location_data.dart';

class AdminLocationCardWidget extends StatelessWidget {
  const AdminLocationCardWidget({
    required this.location,
    this.onTap,
    this.onEdit,
    this.onDelete,
    super.key,
  });

  final AdminLocationData location;
  final VoidCallback? onTap;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    final isActive = location.statusKey == 'admin.locations.status.active';
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: AppColors.border),
      ),
      clipBehavior: Clip.antiAlias,
      child: Material(
        color: AppColors.transparent,
        child: InkWell(
          onTap: onTap,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(14.r),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 19.r,
                      backgroundColor: location.iconBackgroundColor,
                      child: Icon(
                        location.icon,
                        color: location.iconColor,
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
                                  location.nameKey.tr(context: context),
                                  style: AppTextStyles.font14SemiBold,
                                ),
                              ),
                              if (isActive)
                                Text(
                                  location.statusKey.tr(context: context),
                                  style: AppTextStyles.font11Medium.copyWith(
                                    color: AppColors.success,
                                  ),
                                )
                              else
                                Text(
                                  location.statusKey.tr(context: context),
                                  style: AppTextStyles.font11Medium.copyWith(
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              if (location.isGeofenced) ...[
                                vSpace(8),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 8.w,
                                    vertical: 3.h,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.softBlueBackground,
                                    borderRadius: BorderRadius.circular(10.r),
                                  ),
                                  child: Text(
                                    'admin.locations.geofenced'.tr(
                                      context: context,
                                    ),
                                    style: AppTextStyles.font11Medium.copyWith(
                                      color: AppColors.info,
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                          hSpace(4),
                          Text(
                            location.descriptionKey.tr(context: context),
                            style: AppTextStyles.font12Regular,
                          ),
                          hSpace(2),
                          Text(
                            location.addressKey.tr(context: context),
                            style: AppTextStyles.font12Regular.copyWith(
                              color: AppColors.placeholder,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: AdminLocationActionWidget(
                      labelKey: 'admin.locations.edit',
                      color: AppColors.textSecondary,
                      onTap: onEdit,
                    ),
                  ),
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
        ),
      ),
    );
  }
}
