import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';

class AdminCustomerVisitDocViewerDialogWidget extends StatelessWidget {
  const AdminCustomerVisitDocViewerDialogWidget({
    required this.fileName,
    this.fileUrl,
    super.key,
  });

  final String fileName;
  final String? fileUrl;

  @override
  Widget build(BuildContext context) {
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
                    Icons.picture_as_pdf_rounded,
                    color: AppColors.error,
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
                    'PDF • 1.8 MB • مستند معتمد',
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
              onTap: () {
                Navigator.pop(context);
                CustomSnackBar.show(
                  context,
                  message: 'تم فتح المستند بنجاح',
                  backgroundColor: AppColors.brandPrimary,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
