import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';

class TenantLookupHeaderWidget extends StatelessWidget {
  const TenantLookupHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(AppAssets.logo, height: 66.h, fit: BoxFit.contain),
        hSpace(16),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
          decoration: BoxDecoration(
            color: AppColors.softBrandBackground,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.business_rounded,
                size: 18.r,
                color: AppColors.brandPrimary,
              ),
              wSpace(6),
              Text(
                'tenant.lookup.badge'.tr(context: context),
                style: AppTextStyles.font12Medium.copyWith(
                  color: AppColors.brandPrimaryDark,
                ),
              ),
            ],
          ),
        ),
        hSpace(12),
        Text(
          'tenant.lookup.title'.tr(context: context),
          textAlign: TextAlign.center,
          style: AppTextStyles.font18Bold,
        ),
        hSpace(6),
        Text(
          'tenant.lookup.subtitle'.tr(context: context),
          textAlign: TextAlign.center,
          style: AppTextStyles.font14Regular.copyWith(height: 1.5),
        ),
      ],
    );
  }
}
