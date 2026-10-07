import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:check_point_v2/core/core.dart';

class AdminCustomerVisitDocViewerDialogWidget extends StatelessWidget {
  const AdminCustomerVisitDocViewerDialogWidget({
    required this.fileName,
    this.fileUrl,
    super.key,
  });

  final String fileName;
  final String? fileUrl;

  IconData _getFileIcon(String ext) {
    switch (ext) {
      case 'pdf':
        return Icons.picture_as_pdf_rounded;
      case 'png':
      case 'jpg':
      case 'jpeg':
        return Icons.image_rounded;
      case 'doc':
      case 'docx':
        return Icons.article_rounded;
      case 'xls':
      case 'xlsx':
        return Icons.table_chart_rounded;
      default:
        return Icons.insert_drive_file_rounded;
    }
  }

  Color _getFileColor(String ext) {
    switch (ext) {
      case 'pdf':
        return AppColors.error;
      case 'png':
      case 'jpg':
      case 'jpeg':
        return AppColors.brandPrimary;
      case 'doc':
      case 'docx':
        return const Color(0xFF2B579A);
      case 'xls':
      case 'xlsx':
        return const Color(0xFF217346);
      default:
        return AppColors.brandPrimary;
    }
  }

  @override
  Widget build(BuildContext context) {
    final ext = fileName.contains('.')
        ? fileName.split('.').last.toLowerCase()
        : 'file';

    return Dialog(
      backgroundColor: AppColors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      insetPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
      child: Padding(
        padding: EdgeInsets.all(20.r),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8.r),
                      decoration: BoxDecoration(
                        color: AppColors.softBrandBackground,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Icon(
                        Icons.description_outlined,
                        color: AppColors.brandPrimary,
                        size: 22.r,
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Text(
                      'admin.visits.document'.tr(context: context),
                      style: AppTextStyles.font16Bold,
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(Icons.close_rounded, size: 20.r),
                ),
              ],
            ),
            const Divider(color: AppColors.border),
            SizedBox(height: 16.h),
            Container(
              padding: EdgeInsets.all(16.r),
              decoration: BoxDecoration(
                color: AppColors.cardBackground,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: AppColors.border),
              ),
              child: Column(
                children: [
                  Icon(
                    _getFileIcon(ext),
                    color: _getFileColor(ext),
                    size: 48.r,
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    fileName,
                    style: AppTextStyles.font14Bold,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    '${ext.toUpperCase()} • ${'admin.visits.attachedDoc'.tr(context: context)}',
                    style: AppTextStyles.font12Regular.copyWith(
                      color: AppColors.placeholder,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h),
            CustomButton(
              text: 'admin.visits.viewDoc'.tr(context: context),
              icon: Icons.open_in_new_rounded,
              onTap: () async {
                Navigator.pop(context);
                if (fileUrl != null && fileUrl!.isNotEmpty) {
                  final uri = Uri.tryParse(fileUrl!);
                  if (uri != null &&
                      (uri.scheme == 'http' || uri.scheme == 'https')) {
                    await launchUrl(uri, mode: LaunchMode.externalApplication);
                    return;
                  }
                }
                if (context.mounted) {
                  CustomSnackBar.show(
                    context,
                    message: 'تم فتح المستند بنجاح',
                    backgroundColor: AppColors.brandPrimary,
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
