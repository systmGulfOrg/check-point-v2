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
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      backgroundColor: AppColors.cardBackground,
      insetPadding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Padding(
        padding: EdgeInsets.all(20.r),
        child: Form(
          key: _formKey,
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
                  Icons.cancel_outlined,
                  color: AppColors.error,
                  size: 28.r,
                ),
              ),
              hSpace(16),
              Text(
                'admin.requests.rejectRequest'.tr(context: context),
                textAlign: TextAlign.center,
                style: AppTextStyles.font18Bold.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
              hSpace(4),
              Text(
                widget.applicantName,
                textAlign: TextAlign.center,
                style: AppTextStyles.font14Regular.copyWith(
                  color: AppColors.textSecondary,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              hSpace(16),
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
                    child: CustomButton(
                      text: 'admin.locations.create.cancel'.tr(context: context),
                      onTap: () => Navigator.pop(context),
                      backgroundColor: AppColors.pageBackground,
                      textColor: AppColors.textPrimary,
                      height: 44,
                    ),
                  ),
                  wSpace(12),
                  Expanded(
                    child: CustomButton(
                      text: 'admin.requests.reject'.tr(context: context),
                      onTap: _submit,
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
      ),
    );
  }
}
