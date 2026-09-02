import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/core.dart';

class AdminRequestsEmptyStateWidget extends StatelessWidget {
  const AdminRequestsEmptyStateWidget({required this.messageKey, super.key});

  final String messageKey;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 80.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 64.r,
              height: 64.r,
              decoration: BoxDecoration(
                color: AppColors.softBrandBackground,
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Icon(
                Icons.person_outline_rounded,
                color: AppColors.brandPrimary,
                size: 32.r,
              ),
            ),
            hSpace(16),
            Text(
              messageKey.tr(context: context),
              style: AppTextStyles.font14Regular.copyWith(
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
