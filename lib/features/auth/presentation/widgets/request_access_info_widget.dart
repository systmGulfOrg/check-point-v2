import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/core.dart';

class RequestAccessInfoWidget extends StatelessWidget {
  const RequestAccessInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: AppColors.infoBackground,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(
          color: AppColors.brandPrimary.withValues(alpha: 0.3),
        ),
      ),
      child: Text(
        'auth.requestAccess.info'.tr(context: context),
        style: AppTextStyles.font12Bold.copyWith(
          color: AppColors.brandInk,
          height: 1.5,
        ),
      ),
    );
  }
}
