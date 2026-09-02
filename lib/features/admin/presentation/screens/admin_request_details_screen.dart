import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/core.dart';

class AdminRequestDetailsScreen extends StatelessWidget {
  const AdminRequestDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: AppColors.white,
    appBar: AppBar(
      backgroundColor: AppColors.white,
      elevation: 0,
      foregroundColor: AppColors.brandInk,
      title: Text(
        'admin.requests.detailsTitle'.tr(context: context),
        style: AppTextStyles.font18Bold,
      ),
    ),
    body: SingleChildScrollView(
      padding: EdgeInsetsDirectional.fromSTEB(16.w, 8.h, 16.w, 28.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: EdgeInsets.all(18.r),
            decoration: AppDecorations.card,
            child: Row(
              children: [
                CircleAvatar(
                  radius: 30.r,
                  backgroundColor: AppColors.softBrandBackground,
                  child: Text(
                    'AM',
                    style: AppTextStyles.font16Bold.copyWith(
                      color: AppColors.brandPrimary,
                    ),
                  ),
                ),
                vSpace(14),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'admin.requests.employeeName'.tr(context: context),
                      style: AppTextStyles.font18Bold,
                    ),
                    hSpace(5),
                    Text(
                      'admin.requests.pendingLabel'.tr(context: context),
                      style: AppTextStyles.font13Regular.copyWith(
                        color: AppColors.warningOrange,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          hSpace(16),
          Container(
            padding: EdgeInsets.all(18.r),
            decoration: AppDecorations.card,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'admin.requests.deviceInformation'.tr(context: context),
                  style: AppTextStyles.font16Bold,
                ),
                hSpace(14),
                for (final item in const [
                  ('admin.requests.mobileId', 'xxxxxxxx'),
                  ('admin.requests.deviceToken', 'xxxxxxxx'),
                  ('admin.requests.deviceModel', 'Samsung A54'),
                  ('admin.requests.osVersion', 'Android 15'),
                  ('admin.requests.requestDate', '02/09/2026'),
                ])
                  Padding(
                    padding: EdgeInsets.only(bottom: 13.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            item.$2,
                            style: AppTextStyles.font13SemiBold,
                          ),
                        ),
                        Text(
                          item.$1.tr(context: context),
                          style: AppTextStyles.font13Regular,
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
          hSpace(20),
          OutlinedButton(
            onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('admin.requests.rejected'.tr(context: context)),
              ),
            ),
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.error,
              side: const BorderSide(color: AppColors.error),
              padding: EdgeInsets.symmetric(vertical: 15.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14.r),
              ),
            ),
            child: Text(
              'admin.requests.rejectRequest'.tr(context: context),
              style: AppTextStyles.font14SemiBold.copyWith(
                color: AppColors.error,
              ),
            ),
          ),
          hSpace(10),
          CustomButton(
            text: 'admin.requests.createEmployee'.tr(context: context),
            onTap: () => context.pushNamed(AppRoutes.adminCreateEmployee),
            backgroundColor: AppColors.brandPrimary,
            height: 48,
          ),
        ],
      ),
    ),
  );
}
