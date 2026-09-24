import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';

class AdminEmployeeDocumentItemWidget extends StatelessWidget {
  const AdminEmployeeDocumentItemWidget({
    required this.title,
    required this.fileName,
    required this.isUploaded,
    required this.isUploading,
    required this.onUpload,
    this.onDelete,
    this.uploadDate,
    super.key,
  });

  final String title;
  final String? fileName;
  final bool isUploaded;
  final bool isUploading;
  final VoidCallback onUpload;
  final VoidCallback? onDelete;
  final String? uploadDate;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: AppColors.pageBackground,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: isUploaded ? AppColors.brandPrimary.withValues(alpha: 0.3) : AppColors.border,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10.r),
            decoration: BoxDecoration(
              color: isUploaded ? AppColors.softBrandBackground : AppColors.cardBackground,
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(
                color: isUploaded ? AppColors.brandPrimary.withValues(alpha: 0.3) : AppColors.border,
              ),
            ),
            child: Icon(
              Icons.picture_as_pdf_outlined,
              size: 22.r,
              color: isUploaded ? AppColors.brandPrimary : AppColors.textSecondary,
            ),
          ),
          wSpace(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.font14Regular.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                hSpace(3),
                Text(
                  isUploaded
                      ? (fileName ?? 'Uploaded Document')
                      : 'employee.profile.notUploaded'.tr(context: context),
                  style: AppTextStyles.font12Regular.copyWith(
                    color: isUploaded ? AppColors.textSecondary : AppColors.placeholder,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                if (uploadDate != null && uploadDate!.isNotEmpty) ...[
                  hSpace(2),
                  Text(
                    uploadDate!,
                    style: AppTextStyles.font10Medium.copyWith(
                      color: AppColors.placeholder,
                    ),
                  ),
                ],
              ],
            ),
          ),
          wSpace(8),
          if (isUploading)
            SizedBox(
              width: 24.r,
              height: 24.r,
              child: const CircularProgressIndicator(
                strokeWidth: 2.5,
                color: AppColors.brandPrimary,
              ),
            )
          else if (isUploaded)
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                  decoration: BoxDecoration(
                    color: AppColors.success.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: Text(
                    'employee.profile.docUploaded'.tr(context: context),
                    style: AppTextStyles.font11Medium.copyWith(
                      color: AppColors.success,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                wSpace(4),
                IconButton(
                  onPressed: onUpload,
                  icon: const Icon(Icons.sync_rounded),
                  color: AppColors.brandPrimary,
                  tooltip: 'employee.profile.replaceDoc'.tr(context: context),
                  padding: EdgeInsets.zero,
                  constraints: BoxConstraints(minWidth: 32.r, minHeight: 32.r),
                ),
                if (onDelete != null)
                  IconButton(
                    onPressed: onDelete,
                    icon: const Icon(Icons.delete_outline_rounded),
                    color: AppColors.error,
                    tooltip: 'employee.profile.deleteDoc'.tr(context: context),
                    padding: EdgeInsets.zero,
                    constraints: BoxConstraints(minWidth: 32.r, minHeight: 32.r),
                  ),
              ],
            )
          else
            ElevatedButton.icon(
              onPressed: onUpload,
              icon: Icon(Icons.cloud_upload_outlined, size: 16.r),
              label: Text(
                'employee.profile.uploadDoc'.tr(context: context),
                style: AppTextStyles.font12Medium.copyWith(
                  color: AppColors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.brandPrimary,
                foregroundColor: AppColors.white,
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                minimumSize: Size(0, 32.h),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
                elevation: 0,
              ),
            ),
        ],
      ),
    );
  }
}
