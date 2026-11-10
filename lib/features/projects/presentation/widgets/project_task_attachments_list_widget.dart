import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import '../../data/models/project_models.dart';

class ProjectTaskAttachmentsListWidget extends StatelessWidget {
  const ProjectTaskAttachmentsListWidget({
    super.key,
    required this.attachments,
  });

  final List<TaskAttachmentModel> attachments;

  @override
  Widget build(BuildContext context) {
    if (attachments.isEmpty) {
      return Container(
        width: double.infinity,
        padding: EdgeInsets.all(16.r),
        decoration: BoxDecoration(
          color: AppColors.pageBackground,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Text(
          'projects.noAttachments'.tr(context: context),
          style: AppTextStyles.font13Regular.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
      );
    }

    return Column(
      children: attachments.map((file) {
        final fileName = file.fileName ?? 'File';
        final fileSize = file.fileSize;
        final fileUrl = file.fileUrl;

        return Container(
          margin: EdgeInsets.only(bottom: 8.h),
          decoration: BoxDecoration(
            color: AppColors.pageBackground,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: AppColors.border),
          ),
          child: ListTile(
            contentPadding: EdgeInsets.symmetric(
              horizontal: 14.w,
              vertical: 4.h,
            ),
            leading: Icon(
              Icons.insert_drive_file_outlined,
              color: AppColors.brandPrimary,
            ),
            title: Text(
              fileName,
              style: AppTextStyles.font14Bold,
            ),
            subtitle: fileSize != null
                ? Text(
                    '${(fileSize / 1024).toStringAsFixed(1)} KB',
                    style: AppTextStyles.font12Regular.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  )
                : null,
            trailing: Icon(
              Icons.visibility_outlined,
              size: 18.r,
              color: AppColors.brandPrimary,
            ),
            onTap: () => AppDocumentViewerDialogWidget.show(
              context,
              fileName: fileName,
              fileUrl: fileUrl,
              fileSize: fileSize,
            ),
          ),
        );
      }).toList(),
    );
  }
}
