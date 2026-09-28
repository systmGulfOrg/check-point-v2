import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:check_point_v2/core/styles/app_colors.dart';
import 'package:check_point_v2/core/styles/app_text_styles.dart';
import 'package:check_point_v2/features/contractor/presentation/cubit/contractor_cubit.dart';
import 'package:check_point_v2/features/contractor/presentation/cubit/contractor_state.dart';

class ContractorProfileScreen extends StatelessWidget {
  const ContractorProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      appBar: AppBar(
        title: Text(
          'contractor.nav.profile'.tr(),
          style: AppTextStyles.font16Bold.copyWith(
            color: AppColors.textPrimary,
          ),
        ),
        backgroundColor: AppColors.cardBackground,
        elevation: 0,
      ),
      body: BlocBuilder<ContractorCubit, ContractorState>(
        builder: (context, state) {
          final data = state.mapOrNull(success: (value) => value);
          final contractor = data?.contractors.isNotEmpty == true
              ? data!.contractors.first
              : null;
          final sites = data?.sites ?? const [];
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            child: Column(
              children: [
                Center(
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 36.r,
                        backgroundColor: AppColors.brandPrimary.withValues(
                          alpha: 0.15,
                        ),
                        child: Icon(
                          Icons.business_rounded,
                          color: AppColors.brandPrimary,
                          size: 36.r,
                        ),
                      ),
                      SizedBox(height: 12.h),
                      Text(
                        contractor?.name ??
                            'contractor.profile.companyUnavailable'.tr(),
                        style: AppTextStyles.font16Bold,
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        '${'contractor.profile.code'.tr()}: ${contractor?.code ?? '-'}',
                        style: AppTextStyles.font12Regular.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24.h),
                Container(
                  padding: EdgeInsets.all(16.r),
                  decoration: BoxDecoration(
                    color: AppColors.cardBackground,
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'contractor.profile.assignedSites'.tr(),
                        style: AppTextStyles.font14Bold,
                      ),
                      SizedBox(height: 12.h),
                      Row(
                        children: [
                          const Icon(
                            Icons.train_rounded,
                            color: AppColors.brandPrimary,
                            size: 20,
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            sites
                                .map((site) => site.projectName)
                                .whereType<String>()
                                .toSet()
                                .join(', '),
                            style: AppTextStyles.font14Medium,
                          ),
                        ],
                      ),
                      SizedBox(height: 6.h),
                      Padding(
                        padding: EdgeInsetsDirectional.only(start: 28.w),
                        child: Text(
                          '${'contractor.profile.sites'.tr()}: ${sites.map((site) => site.siteName).join(' · ')}',
                          style: AppTextStyles.font12Regular.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16.h),
                Container(
                  padding: EdgeInsets.all(16.r),
                  decoration: BoxDecoration(
                    color: AppColors.cardBackground,
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'contractor.profile.deviceSecurity'.tr(),
                        style: AppTextStyles.font14Bold,
                      ),
                      SizedBox(height: 10.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'contractor.profile.allowedDevices'.tr(),
                            style: AppTextStyles.font12Regular,
                          ),
                          Text(
                            '-',
                            style: AppTextStyles.font11Medium.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'contractor.profile.currentDevice'.tr(),
                            style: AppTextStyles.font12Regular,
                          ),
                          Text(
                            '-',
                            style: AppTextStyles.font11Medium.copyWith(
                              color: AppColors.success,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
