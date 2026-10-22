import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/admin/data/models/locations/customer_visit_model.dart';

class AdminCancelCustomerVisitDialogWidget extends StatefulWidget {
  const AdminCancelCustomerVisitDialogWidget({
    required this.visit,
    required this.onConfirm,
    super.key,
  });

  final CustomerVisitModel visit;
  final Future<void> Function(String? reason) onConfirm;

  @override
  State<AdminCancelCustomerVisitDialogWidget> createState() =>
      _AdminCancelCustomerVisitDialogWidgetState();
}

class _AdminCancelCustomerVisitDialogWidgetState
    extends State<AdminCancelCustomerVisitDialogWidget> {
  late final TextEditingController reasonController;
  bool isSubmitting = false;

  @override
  void initState() {
    super.initState();
    reasonController = TextEditingController();
  }

  @override
  void dispose() {
    reasonController.dispose();
    super.dispose();
  }

  Future<void> _handleConfirm() async {
    setState(() => isSubmitting = true);
    try {
      final reason = reasonController.text.trim();
      await widget.onConfirm(reason.isNotEmpty ? reason : null);
      if (mounted) {
        Navigator.of(context).pop();
      }
    } finally {
      if (mounted) {
        setState(() => isSubmitting = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.cardBackground,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
      insetPadding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 24.h),
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.r),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(10.r),
                    decoration: BoxDecoration(
                      color: AppColors.error.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Icon(
                      Icons.event_busy_rounded,
                      color: AppColors.error,
                      size: 24.r,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'إلغاء زيارة العميل',
                          style: AppTextStyles.font16Bold.copyWith(
                            color: AppColors.textPrimary,
                          ),
                        ),
                        if (widget.visit.customerName != null) ...[
                          SizedBox(height: 2.h),
                          Text(
                            widget.visit.customerName!,
                            style: AppTextStyles.font12Medium.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: Icon(
                      Icons.close_rounded,
                      color: AppColors.textSecondary,
                      size: 20.r,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h),

              Container(
                padding: EdgeInsets.all(12.r),
                decoration: BoxDecoration(
                  color: AppColors.error.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(10.r),
                  border: Border.all(
                    color: AppColors.error.withValues(alpha: 0.25),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.info_outline_rounded,
                      color: AppColors.error,
                      size: 18.r,
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: Text(
                        'هل أنت متأكد من رغبتك في إلغاء هذه الزيارة؟ سيتم تحديث حالة الزيارة إلى "ملغاة" وتسجيل الإجراء في سجل نشاط الزيارة.',
                        style: AppTextStyles.font12Medium.copyWith(
                          color: AppColors.error,
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.h),

              Text(
                'سبب الإلغاء (اختياري)',
                style: AppTextStyles.font14Bold.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
              SizedBox(height: 8.h),
              CustomTextFormField(
                controller: reasonController,
                hintText: 'اكتب سبب إلغاء الزيارة إن وجد...',
                maxLines: 3,
                keyboardType: TextInputType.multiline,
              ),
              SizedBox(height: 24.h),

              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        side: const BorderSide(color: AppColors.border),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                      ),
                      onPressed: isSubmitting
                          ? null
                          : () => Navigator.of(context).pop(),
                      child: Text(
                        'common.cancel'.tr(context: context),
                        style: AppTextStyles.font14Medium.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.error,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        elevation: 0,
                      ),
                      onPressed: isSubmitting ? null : _handleConfirm,
                      child: isSubmitting
                          ? SizedBox(
                              width: 18.r,
                              height: 18.r,
                              child: const CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : Text(
                              'تأكيد الإلغاء',
                              style: AppTextStyles.font14Bold.copyWith(
                                color: Colors.white,
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
