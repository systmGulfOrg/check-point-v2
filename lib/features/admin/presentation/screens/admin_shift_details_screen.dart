import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/core.dart';
import '../widgets/admin_new_policy_button_widget.dart';

class AdminShiftDetailsScreen extends StatelessWidget {
  const AdminShiftDetailsScreen({required this.shiftKey, super.key});

  final String shiftKey;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        title: Text(
          shiftKey.tr(context: context),
          style: AppTextStyles.font18Bold,
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(16.w, 4.h, 16.w, 24.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'admin.shifts.policies.title'.tr(context: context),
                  style: AppTextStyles.font12Bold,
                ),
                const AdminNewPolicyButtonWidget(
                  labelKey: 'admin.shifts.policies.add',
                ),
              ],
            ),
            hSpace(10),
            for (final policy in const [
              (
                'admin.shifts.policies.a.name',
                'admin.shifts.policies.a.time',
                'admin.shifts.policies.a.days',
              ),
              (
                'admin.shifts.policies.b.name',
                'admin.shifts.policies.b.time',
                'admin.shifts.policies.b.days',
              ),
            ])
              Padding(
                padding: EdgeInsets.only(bottom: 10.h),
                child: Container(
                  padding: EdgeInsets.all(14.r),
                  decoration: BoxDecoration(
                    color: AppColors.cardBackground,
                    borderRadius: BorderRadius.circular(14.r),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            policy.$1.tr(context: context),
                            style: AppTextStyles.font14SemiBold,
                          ),
                          Text(
                            'admin.shifts.policies.delete'.tr(context: context),
                            style: AppTextStyles.font12Regular.copyWith(
                              color: AppColors.error,
                            ),
                          ),
                        ],
                      ),
                      hSpace(4),
                      Text(
                        policy.$2.tr(context: context),
                        style: AppTextStyles.font12Regular,
                      ),
                      hSpace(8),
                      Text(
                        policy.$3.tr(context: context),
                        style: AppTextStyles.font12Regular.copyWith(
                          color: AppColors.info,
                        ),
                      ),
                      hSpace(10),
                      Text(
                        'admin.shifts.policies.assigned'.tr(
                          context: context,
                          args: ['4'],
                        ),
                        style: AppTextStyles.font12Regular.copyWith(
                          color: AppColors.placeholder,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
