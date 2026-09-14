import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';

class AdminRejectRequestDialogWidget extends StatefulWidget {
  const AdminRejectRequestDialogWidget({
    required this.applicantName,
    super.key,
  });

  final String applicantName;

  static Future<String?> show(BuildContext context, {required String applicantName}) {
    return showDialog<String>(
      context: context,
      builder: (_) => AdminRejectRequestDialogWidget(applicantName: applicantName),
    );
  }

  @override
  State<AdminRejectRequestDialogWidget> createState() =>
      _AdminRejectRequestDialogWidgetState();
}

class _AdminRejectRequestDialogWidgetState
    extends State<AdminRejectRequestDialogWidget> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _reasonController;

  @override
  void initState() {
    super.initState();
    _reasonController = TextEditingController();
  }

  @override
  void dispose() {
    _reasonController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      Navigator.pop(context, _reasonController.text.trim());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
      backgroundColor: AppColors.white,
      insetPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
      child: Padding(
        padding: EdgeInsets.all(22.r),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(10.r),
                    decoration: BoxDecoration(
                      color: AppColors.softRedBackground,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Icon(
                      Icons.cancel_outlined,
                      color: AppColors.error,
                      size: 24.r,
                    ),
                  ),
                  vSpace(12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'admin.requests.rejectRequest'.tr(context: context),
                          style: AppTextStyles.font16Bold,
                        ),
                        hSpace(2),
                        Text(
                          widget.applicantName,
                          style: AppTextStyles.font12Regular.copyWith(
                            color: AppColors.textSecondary,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              hSpace(18),
              Text(
                'admin.requests.rejectReasonLabel'.tr(context: context),
                style: AppTextStyles.font13SemiBold,
              ),
              hSpace(8),
              CustomTextFormField(
                controller: _reasonController,
                hintText: 'admin.requests.rejectReasonHint'.tr(context: context),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'admin.requests.rejectReasonRequired'.tr(context: context);
                  }
                  return null;
                },
              ),
              hSpace(20),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.textPrimary,
                        side: const BorderSide(color: AppColors.border),
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      child: Text(
                        'admin.locations.create.cancel'.tr(context: context),
                        style: AppTextStyles.font14Medium,
                      ),
                    ),
                  ),
                  vSpace(10),
                  Expanded(
                    child: CustomButton(
                      text: 'admin.requests.reject'.tr(context: context),
                      onTap: _submit,
                      backgroundColor: AppColors.error,
                      height: 44,
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
