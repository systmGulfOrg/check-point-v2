import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';

class RequestAccessBrandWidget extends StatelessWidget {
  const RequestAccessBrandWidget({super.key});

  @override
  Widget build(BuildContext context) => Column(
    children: [
      Image.asset(AppAssets.logo, height: 46.h, fit: BoxFit.contain),
      hSpace(10),
      Text(
        'auth.requestAccess.cardTitle'.tr(context: context),
        textAlign: TextAlign.center,
        style: AppTextStyles.font20Bold.copyWith(
          color: AppColors.brandInk,
        ),
      ),
      hSpace(4),
      Text(
        'auth.requestAccess.welcomeDescription'.tr(context: context),
        textAlign: TextAlign.center,
        style: AppTextStyles.font12Regular.copyWith(
          color: AppColors.textSecondary,
        ),
      ),
    ],
  );
}
