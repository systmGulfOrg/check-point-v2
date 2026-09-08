import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';

class AdminDeleteConfirmationDialogWidget extends StatelessWidget {
  const AdminDeleteConfirmationDialogWidget({
    required this.title,
    required this.message,
    required this.onConfirm,
    this.confirmLabel,
    this.cancelLabel,
    super.key,
  });

  final String title;
  final String message;
  final VoidCallback onConfirm;
  final String? confirmLabel;
  final String? cancelLabel;

  @override
  Widget build(BuildContext context) => Dialog(
    backgroundColor: AppColors.cardBackground,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
    insetPadding: EdgeInsets.symmetric(horizontal: 24.w),
    child: Padding(
      padding: EdgeInsets.all(20.r),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 56.r,
            height: 56.r,
            decoration: const BoxDecoration(
              color: AppColors.softRedBackground,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.delete_outline_rounded,
              color: AppColors.error,
              size: 28.r,
            ),
          ),
          hSpace(16),
          Text(
            title,
            textAlign: TextAlign.center,
            style: AppTextStyles.font18Bold.copyWith(
              color: AppColors.textPrimary,
            ),
          ),
          hSpace(8),
          Text(
            message,
            textAlign: TextAlign.center,
            style: AppTextStyles.font14Regular.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          hSpace(20),
          Row(
            children: [
              Expanded(
                child: CustomButton(
                  text:
                      cancelLabel ??
                      'admin.locations.create.cancel'.tr(context: context),
                  onTap: () => Navigator.pop(context),
                  backgroundColor: AppColors.pageBackground,
                  textColor: AppColors.textPrimary,
                  height: 44,
                ),
              ),
              wSpace(12),
              Expanded(
                child: CustomButton(
                  text:
                      confirmLabel ??
                      'admin.locations.delete'.tr(context: context),
                  onTap: onConfirm,
                  backgroundColor: AppColors.error,
                  textColor: AppColors.white,
                  height: 44,
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
