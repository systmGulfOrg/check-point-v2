import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/core.dart';

class SupervisorAlertBannerWidget extends StatelessWidget {
  const SupervisorAlertBannerWidget({
    required this.messageKey,
    super.key,
    this.onTap,
  });

  final String messageKey;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.softYellowBackground,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: AppColors.warningOrange.withValues(alpha: 0.4),
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16.r),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
          child: Row(
            children: [
              Icon(
                Icons.error_outline_rounded,
                color: AppColors.warningOrange,
                size: 22.r,
              ),
              vSpace(12),
              Expanded(
                child: Text(
                  messageKey.tr(context: context),
                  style: AppTextStyles.font14SemiBold.copyWith(
                    color: AppColors.warningOrange,
                  ),
                ),
              ),
              Icon(
                Icons.chevron_right_rounded,
                color: AppColors.warningOrange,
                size: 20.r,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
