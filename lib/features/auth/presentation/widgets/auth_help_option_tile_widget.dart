import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';

class AuthHelpOptionTileWidget extends StatelessWidget {
  const AuthHelpOptionTileWidget({
    required this.icon,
    required this.labelKey,
    required this.onTap,
    super.key,
  });

  final IconData icon;
  final String labelKey;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Padding(
        padding: EdgeInsetsDirectional.symmetric(
          horizontal: 4.w,
          vertical: 14.h,
        ),
        child: Row(
          children: [
            Container(
              width: 40.r,
              height: 40.r,
              decoration: BoxDecoration(
                color: AppColors.softBrandBackground,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Icon(icon, size: 20.r, color: AppColors.brandPrimary),
            ),
            wSpace(14),
            Expanded(
              child: Text(
                labelKey.tr(context: context),
                style: AppTextStyles.font14SemiBold,
              ),
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 14.r,
              color: AppColors.placeholder,
            ),
          ],
        ),
      ),
    );
  }
}
