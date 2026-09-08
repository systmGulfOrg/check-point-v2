import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';

class AttendanceTargetDetailsWidget extends StatelessWidget {
  const AttendanceTargetDetailsWidget({
    required this.name,
    required this.address,
    required this.coordinates,
    required this.isAddressLoading,
    required this.onCopyAddress,
    required this.onCopyCoordinates,
    super.key,
  });

  final String name;
  final String? address;
  final String coordinates;
  final bool isAddressLoading;
  final VoidCallback onCopyAddress;
  final VoidCallback onCopyCoordinates;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(14.r),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8.r),
                decoration: BoxDecoration(
                  color: AppColors.iconTileBackground,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Icon(
                  Icons.location_on_rounded,
                  color: AppColors.brandPrimary,
                  size: 20.r,
                ),
              ),
              wSpace(10),
              Expanded(
                child: Text(
                  name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.font14SemiBold,
                ),
              ),
            ],
          ),
          hSpace(12),
          Divider(height: 1.h, color: AppColors.border),
          hSpace(10),
          Text(
            'attendance.address'.tr(),
            style: AppTextStyles.font12Medium.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          hSpace(3),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: isAddressLoading
                    ? Align(
                        alignment: AlignmentDirectional.centerStart,
                        child: SizedBox(
                          width: 16.r,
                          height: 16.r,
                          child: const CircularProgressIndicator(
                            strokeWidth: 2,
                          ),
                        ),
                      )
                    : Text(
                        address ?? 'attendance.addressUnavailable'.tr(),
                        style: AppTextStyles.font13Regular,
                      ),
              ),
              if (address != null)
                IconButton(
                  tooltip: 'attendance.copyAddress'.tr(),
                  visualDensity: VisualDensity.compact,
                  icon: Icon(Icons.copy_rounded, size: 18.r),
                  color: AppColors.brandPrimary,
                  onPressed: onCopyAddress,
                ),
            ],
          ),
          hSpace(8),
          Text(
            'attendance.coordinates'.tr(),
            style: AppTextStyles.font12Medium.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          hSpace(3),
          Row(
            children: [
              Expanded(
                child: Text(coordinates, style: AppTextStyles.font13Regular),
              ),
              IconButton(
                tooltip: 'attendance.copyCoordinates'.tr(),
                visualDensity: VisualDensity.compact,
                icon: Icon(Icons.copy_rounded, size: 18.r),
                color: AppColors.brandPrimary,
                onPressed: onCopyCoordinates,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
