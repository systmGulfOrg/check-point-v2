import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/core.dart';

class RequestAccessBrandWidget extends StatelessWidget {
  const RequestAccessBrandWidget({super.key});

  @override
  Widget build(BuildContext context) => Column(
    children: [
      Image.asset(AppAssets.logo, height: 64.h, fit: BoxFit.contain),
      hSpace(8),
      Text(
        'auth.requestAccess.brandSubtitle'.tr(context: context),
        textAlign: TextAlign.center,
        style: AppTextStyles.font12Medium.copyWith(
          color: AppColors.textSecondary,
          letterSpacing: 0.1,
        ),
      ),
    ],
  );
}
