import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/core.dart';

class RequestAccessHeaderWidget extends StatelessWidget {
  const RequestAccessHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 42.w,
          height: 42.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            color: AppColors.iconTileBackground,
            border: Border.all(
              color: AppColors.brandPrimary.withValues(alpha: 0.35),
            ),
          ),
          child: Icon(
            Icons.check_circle_outline_rounded,
            color: AppColors.brandPrimary,
            size: 22.r,
          ),
        ),
        vSpace(12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'auth.requestAccess.title'.tr(context: context),
                style: AppTextStyles.font24Bold,
              ),
              hSpace(4),
              Text(
                'auth.requestAccess.subtitle'.tr(context: context),
                style: AppTextStyles.font14Regular,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
