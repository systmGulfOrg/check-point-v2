import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/core.dart';
import '../../data/models/account_requests_response_model.dart';
import '../cubit/admin_account_requests_cubit.dart';

class AdminRequestDetailsScreen extends StatelessWidget {
  const AdminRequestDetailsScreen({required this.request, super.key});

  final AccountRequestModel request;

  String _getInitials(String? name) {
    if (name == null || name.trim().isEmpty) return '?';
    final parts = name.trim().split(RegExp(r'\s+'));
    if (parts.length == 1) {
      return parts.first
          .substring(0, parts.first.length.clamp(1, 2))
          .toUpperCase();
    }
    return (parts.first[0] + parts.last[0]).toUpperCase();
  }

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
                    _getInitials(request.name),
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
                      request.name?.trim().isNotEmpty == true
                          ? request.name!
                          : '-',
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
                Padding(
                  padding: EdgeInsets.only(bottom: 13.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Flexible(
                              child: Text(
                                request.mobileId?.isNotEmpty == true
                                    ? request.mobileId!
                                    : '-',
                                style: AppTextStyles.font13SemiBold,
                              ),
                            ),
                            if (request.mobileId?.isNotEmpty == true) ...[
                              vSpace(6),
                              InkWell(
                                onTap: () async {
                                  await Clipboard.setData(
                                    ClipboardData(text: request.mobileId!),
                                  );
                                  if (context.mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          'admin.requests.copiedMobileId'.tr(
                                            context: context,
                                          ),
                                        ),
                                        duration: const Duration(seconds: 2),
                                      ),
                                    );
                                  }
                                },
                                borderRadius: BorderRadius.circular(6.r),
                                child: Padding(
                                  padding: EdgeInsets.all(4.r),
                                  child: Icon(
                                    Icons.copy_rounded,
                                    size: 16.r,
                                    color: AppColors.brandPrimary,
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                      Text(
                        'admin.requests.mobileId'.tr(context: context),
                        style: AppTextStyles.font13Regular,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 13.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          request.deviceToken?.isNotEmpty == true
                              ? request.deviceToken!
                              : '-',
                          style: AppTextStyles.font13SemiBold,
                        ),
                      ),
                      Text(
                        'admin.requests.deviceToken'.tr(context: context),
                        style: AppTextStyles.font13Regular,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 13.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          request.createdDate != null
                              ? DateFormat(
                                  'dd/MM/yyyy',
                                ).format(request.createdDate!)
                              : '-',
                          style: AppTextStyles.font13SemiBold,
                        ),
                      ),
                      Text(
                        'admin.requests.requestDate'.tr(context: context),
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
            onPressed: () async {
              if (request.id != null) {
                await context.read<AdminAccountRequestsCubit>().deleteRequest(
                      id: request.id!,
                    );
              }
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'admin.requests.rejected'.tr(context: context),
                    ),
                  ),
                );
                context.pop();
              }
            },
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
