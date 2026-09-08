import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';

class AdminLocationMapControlsWidget extends StatelessWidget {
  const AdminLocationMapControlsWidget({
    required this.pointsCount,
    required this.onUndo,
    required this.onClear,
    required this.onExpand,
    super.key,
  });

  final int pointsCount;
  final VoidCallback onUndo;
  final VoidCallback onClear;
  final VoidCallback onExpand;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          child: Container(
            key: ValueKey(pointsCount),
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: pointsCount > 0
                  ? AppColors.softGreenBackground
                  : AppColors.softBlueBackground,
              borderRadius: BorderRadius.circular(6.r),
            ),
            child: Text(
              'admin.locations.create.pointsCount'.tr(
                context: context,
                args: [pointsCount.toString()],
              ),
              style: AppTextStyles.font12Medium.copyWith(
                color: pointsCount > 0 ? AppColors.success : AppColors.info,
              ),
            ),
          ),
        ),
        const Spacer(),
        if (pointsCount > 0) ...[
          InkWell(
            onTap: onUndo,
            borderRadius: BorderRadius.circular(6.r),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 4.h),
              child: Row(
                children: [
                  Icon(
                    Icons.undo_rounded,
                    size: 14.r,
                    color: AppColors.textSecondary,
                  ),
                  vSpace(4),
                  Text(
                    'admin.locations.create.undoPoint'.tr(context: context),
                    style: AppTextStyles.font12Regular.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ),
          vSpace(8),
          InkWell(
            onTap: onClear,
            borderRadius: BorderRadius.circular(6.r),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 4.h),
              child: Row(
                children: [
                  Icon(
                    Icons.delete_outline_rounded,
                    size: 14.r,
                    color: AppColors.error,
                  ),
                  vSpace(4),
                  Text(
                    'admin.locations.create.clearPoints'.tr(context: context),
                    style: AppTextStyles.font12Regular.copyWith(
                      color: AppColors.error,
                    ),
                  ),
                ],
              ),
            ),
          ),
          vSpace(8),
        ],
        InkWell(
          onTap: onExpand,
          borderRadius: BorderRadius.circular(6.r),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 4.h),
            child: Row(
              children: [
                Icon(
                  Icons.fullscreen_rounded,
                  size: 16.r,
                  color: AppColors.brandPrimary,
                ),
                vSpace(2),
                Text(
                  'admin.locations.create.fullMap'.tr(context: context),
                  style: AppTextStyles.font12Medium.copyWith(
                    color: AppColors.brandPrimary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
