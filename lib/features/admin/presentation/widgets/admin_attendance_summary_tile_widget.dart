import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';

class AdminAttendanceSummaryTileWidget extends StatelessWidget {
  const AdminAttendanceSummaryTileWidget({
    required this.count,
    required this.labelKey,
    required this.icon,
    required this.color,
    required this.backgroundColor,
    required this.isLoading,
    this.onTap,
    super.key,
  });

  final int count;
  final String labelKey;
  final IconData icon;
  final Color color;
  final Color backgroundColor;
  final bool isLoading;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isLoading ? null : onTap,
      borderRadius: BorderRadius.circular(10.r),
      child: Row(
        children: [
          Container(
            width: 32.r,
            height: 32.r,
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(9.r),
            ),
            child: Icon(icon, color: color, size: 18.r),
          ),
          wSpace(8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Text(
                      isLoading ? '00' : '$count',
                      style: AppTextStyles.font16Bold.copyWith(color: color),
                    ),
                    if (!isLoading && onTap != null) ...[
                      wSpace(4),
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 10.r,
                        color: color,
                      ),
                    ],
                  ],
                ),
                Text(
                  labelKey.tr(context: context),
                  style: AppTextStyles.font11Medium.copyWith(
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
    );
  }
}
