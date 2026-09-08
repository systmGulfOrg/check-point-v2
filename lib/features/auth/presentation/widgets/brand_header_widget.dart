import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';

class BrandHeaderWidget extends StatelessWidget {
  const BrandHeaderWidget({
    required this.titleKey,
    required this.subtitleKey,
    super.key,
  });

  final String titleKey;
  final String subtitleKey;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(AppAssets.logo, height: 66.h, fit: BoxFit.contain),
        hSpace(12),
        Text(
          titleKey.tr(context: context),
          textAlign: TextAlign.center,
          style: AppTextStyles.font16Bold,
        ),
        hSpace(4),
        Text(
          subtitleKey.tr(context: context),
          textAlign: TextAlign.center,
          style: AppTextStyles.font14Regular.copyWith(height: 1.5),
        ),
      ],
    );
  }
}
