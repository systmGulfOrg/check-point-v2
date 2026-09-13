import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';

class BiometricLogoutWarningDialogWidget extends StatelessWidget {
  const BiometricLogoutWarningDialogWidget({super.key});

  @override
  Widget build(BuildContext context) => Dialog(
    backgroundColor: AppColors.infoBackground,
    elevation: 8,
    insetPadding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.r)),
    child: Padding(
      padding: EdgeInsetsDirectional.fromSTEB(20.w, 22.h, 20.w, 18.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'auth.logout.biometricWarningTitle'.tr(context: context),
            textAlign: TextAlign.center,
            style: AppTextStyles.font20Bold.copyWith(height: 1.45),
          ),
          SizedBox(height: 12.h),
          Text(
            'auth.logout.biometricWarningMessage'.tr(context: context),
            textAlign: TextAlign.center,
            style: AppTextStyles.font14Regular.copyWith(height: 1.55),
          ),
          SizedBox(height: 20.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                style: TextButton.styleFrom(
                  foregroundColor: AppColors.brandPrimary,
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  minimumSize: Size(0, 44.h),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Text(
                  'auth.logout.cancel'.tr(context: context),
                  style: AppTextStyles.font14Bold.copyWith(
                    color: AppColors.brandPrimary,
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              FilledButton(
                onPressed: () => Navigator.pop(context, true),
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.error,
                  foregroundColor: AppColors.white,
                  minimumSize: Size(112.w, 44.h),
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(22.r),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  'auth.logout.confirm'.tr(context: context),
                  style: AppTextStyles.font14Medium.copyWith(
                    color: AppColors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
