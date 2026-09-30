import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:check_point_v2/core/styles/app_colors.dart';
import 'package:check_point_v2/core/styles/app_text_styles.dart';
import 'geofence_boundary_painter.dart';
import 'package:check_point_v2/core/app/app_spaces.dart';

class SupervisorPolygonGeofenceMapWidget extends StatelessWidget {
  const SupervisorPolygonGeofenceMapWidget({
    super.key,
    required this.isPolygonMode,
    required this.siteName,
    required this.insideCount,
    required this.outsideCount,
  });

  final bool isPolygonMode;
  final String siteName;
  final int insideCount;
  final int outsideCount;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 260.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.darkPageBackground,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: AppColors.darkCardBorder),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow.withValues(alpha: 0.2),
            blurRadius: 14.r,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          CustomPaint(
            size: Size.infinite,
            painter: GeofenceBoundaryPainter(isPolygon: isPolygonMode),
          ),
          Positioned(
            top: 14.h,
            left: 14.w,
            right: 14.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                  decoration: BoxDecoration(
                    color: AppColors.darkCardBackground.withValues(alpha: 0.85),
                    borderRadius: BorderRadius.circular(10.r),
                    border: Border.all(color: AppColors.darkCardBorder),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        isPolygonMode ? Icons.polyline_rounded : Icons.radio_button_checked_rounded,
                        color: AppColors.brandPrimary,
                        size: 16.r,
                      ),
                      wSpace(6),
                      Text(
                        isPolygonMode ? 'Polygon Plot Boundary (P1..P4)' : 'Circle Geofence (300m)',
                        style: AppTextStyles.font11Medium.copyWith(
                          color: AppColors.darkTextPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: AppColors.darkStatusGreenBg,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Text(
                    'LIVE GPS',
                    style: AppTextStyles.font10Bold.copyWith(color: AppColors.darkStatusGreenText),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 14.h,
            left: 14.w,
            right: 14.w,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: AppColors.darkCardBackground.withValues(alpha: 0.9),
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: AppColors.darkCardBorder),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      Container(width: 8.r, height: 8.r, decoration: const BoxDecoration(color: AppColors.success, shape: BoxShape.circle)),
                      wSpace(6),
                      Text('$insideCount Inside Boundary', style: AppTextStyles.font11Medium.copyWith(color: AppColors.darkTextPrimary)),
                    ],
                  ),
                  Container(width: 1.w, height: 16.h, color: AppColors.darkCardBorder),
                  Row(
                    children: [
                      Container(width: 8.r, height: 8.r, decoration: const BoxDecoration(color: AppColors.error, shape: BoxShape.circle)),
                      wSpace(6),
                      Text('$outsideCount Outside Geofence', style: AppTextStyles.font11Medium.copyWith(color: AppColors.error)),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
