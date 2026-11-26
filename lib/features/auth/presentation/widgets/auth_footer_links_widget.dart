import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';

class AuthFooterLinksWidget extends StatelessWidget {
  const AuthFooterLinksWidget({
    required this.onPrivacy,
    required this.onTerms,
    required this.onSupport,
    super.key,
  });

  final VoidCallback onPrivacy;
  final VoidCallback onTerms;
  final VoidCallback onSupport;

  @override
  Widget build(BuildContext context) {
    final linkStyle = AppTextStyles.font11Regular.copyWith(
      color: AppColors.placeholder,
    );
    final dot = Text(' • ', style: linkStyle);

    return Column(
      children: [
        Wrap(
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            GestureDetector(
              onTap: onPrivacy,
              child: Text(
                'auth.companyCode.privacyPolicy'.tr(context: context),
                style: linkStyle.copyWith(decoration: TextDecoration.underline),
              ),
            ),
            dot,
            GestureDetector(
              onTap: onTerms,
              child: Text(
                'auth.companyCode.termsOfService'.tr(context: context),
                style: linkStyle.copyWith(decoration: TextDecoration.underline),
              ),
            ),
            dot,
            GestureDetector(
              onTap: onSupport,
              child: Text(
                'auth.companyCode.supportLink'.tr(context: context),
                style: linkStyle.copyWith(decoration: TextDecoration.underline),
              ),
            ),
          ],
        ),
        hSpace(6),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.lock_outline_rounded,
              size: 11.r,
              color: AppColors.placeholder,
            ),
            wSpace(4),
            Text(
              'auth.companyCode.sslSecure'.tr(context: context),
              style: AppTextStyles.font11Regular.copyWith(
                color: AppColors.placeholder,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
