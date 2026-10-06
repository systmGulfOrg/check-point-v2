import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/admin/data/models/account_requests/account_requests_response_model.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/account_requests/admin_account_requests_cubit.dart';
import 'package:check_point_v2/features/admin/presentation/widgets/admin_reject_request_dialog_widget.dart';

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

  Color _getStatusBackgroundColor() {
    if (request.isApproved) return AppColors.softGreenBackground;
    if (request.isRejected) return AppColors.softRedBackground;
    return AppColors.softYellowBackground;
  }

  Color _getStatusTextColor() {
    if (request.isApproved) return AppColors.success;
    if (request.isRejected) return AppColors.error;
    return AppColors.warningOrange;
  }

  String _getStatusText(BuildContext context) {
    if (request.isApproved) {
      return 'admin.requests.filterApproved'.tr(context: context);
    }
    if (request.isRejected) {
      return 'admin.requests.filterRejected'.tr(context: context);
    }
    return 'admin.requests.filterPending'.tr(context: context);
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
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        request.name?.trim().isNotEmpty == true
                            ? request.name!
                            : '-',
                        style: AppTextStyles.font18Bold,
                      ),
                      hSpace(5),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.w,
                          vertical: 4.h,
                        ),
                        decoration: BoxDecoration(
                          color: _getStatusBackgroundColor(),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Text(
                          _getStatusText(context),
                          style: AppTextStyles.font12Bold.copyWith(
                            color: _getStatusTextColor(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (request.rejectReason != null &&
              request.rejectReason!.isNotEmpty) ...[
            hSpace(14),
            Container(
              padding: EdgeInsets.all(16.r),
              decoration: BoxDecoration(
                color: AppColors.softRedBackground,
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(
                  color: AppColors.error.withValues(alpha: 0.3),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.info_outline,
                        color: AppColors.error,
                        size: 18.r,
                      ),
                      vSpace(6),
                      Text(
                        'admin.requests.rejectionReason'.tr(context: context),
                        style: AppTextStyles.font14Bold.copyWith(
                          color: AppColors.error,
                        ),
                      ),
                    ],
                  ),
                  hSpace(6),
                  Text(
                    request.rejectReason!,
                    style: AppTextStyles.font13Regular.copyWith(
                      color: AppColors.brandInk,
                    ),
                  ),
                ],
              ),
            ),
          ],
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
                                    CustomSnackBar.show(
                                      context,
                                      message: 'admin.requests.copiedMobileId'
                                          .tr(context: context),
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
                if (request.phone != null && request.phone!.isNotEmpty)
                  Padding(
                    padding: EdgeInsets.only(bottom: 13.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            request.phone!,
                            style: AppTextStyles.font13SemiBold,
                          ),
                        ),
                        Text(
                          'admin.employeeWizard.phone'.tr(context: context),
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
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
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
                              ? AppDateFormatter.formatDayMonthYear(
                                  request.createdDate!,
                                )
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
          if (request.isPending) ...[
            OutlinedButton(
              onPressed: () async {
                final reason = await AdminRejectRequestDialogWidget.show(
                  context,
                  applicantName: request.name ?? '-',
                );
                if (reason != null && context.mounted && request.id != null) {
                  final success = await context
                      .read<AdminAccountRequestsCubit>()
                      .rejectRequest(id: request.id!, reason: reason);
                  if (context.mounted && success == null) {
                    CustomSnackBar.showError(
                      context,
                      message: 'admin.requests.rejected'.tr(context: context),
                    );
                    context.pop();
                  }
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
              onTap: () async {
                final created = await context.pushNamed(
                  AppRoutes.adminCreateEmployee,
                  arguments: request,
                );
                if (created == true && context.mounted) {
                  await context
                      .read<AdminAccountRequestsCubit>()
                      .loadRequests();
                  if (context.mounted) context.pop();
                }
              },
              backgroundColor: AppColors.brandPrimary,
              height: 48,
            ),
          ],
        ],
      ),
    ),
  );
}
