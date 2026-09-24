import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/app/app_spaces.dart';
import 'package:check_point_v2/core/styles/app_colors.dart';
import 'package:check_point_v2/core/styles/app_text_styles.dart';
import 'custom_button.dart';
import 'custom_text_form_field.dart';

class AppRejectReasonDialogWidget extends StatefulWidget {
  const AppRejectReasonDialogWidget({
    required this.title,
    required this.onConfirm,
    this.subtitle,
    this.hintText,
    this.confirmLabel,
    this.cancelLabel,
    this.validator,
    super.key,
  });

  final String title;
  final String? subtitle;
  final String? hintText;
  final String? confirmLabel;
  final String? cancelLabel;
  final ValueChanged<String> onConfirm;
  final String? Function(String?)? validator;

  static Future<String?> show(
    BuildContext context, {
    required String title,
    String? subtitle,
    String? hintText,
    String? confirmLabel,
    String? cancelLabel,
    String? Function(String?)? validator,
  }) {
    return showDialog<String>(
      context: context,
      builder: (dialogCtx) => AppRejectReasonDialogWidget(
        title: title,
        subtitle: subtitle,
        hintText: hintText,
        confirmLabel: confirmLabel,
        cancelLabel: cancelLabel,
        validator: validator,
        onConfirm: (reason) => Navigator.pop(dialogCtx, reason),
      ),
    );
  }

  @override
  State<AppRejectReasonDialogWidget> createState() =>
      _AppRejectReasonDialogWidgetState();
}

class _AppRejectReasonDialogWidgetState
    extends State<AppRejectReasonDialogWidget> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      widget.onConfirm(_controller.text.trim());
    }
  }

  @override
  Widget build(BuildContext context) => Dialog(
    backgroundColor: AppColors.cardBackground,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
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
              widget.title,
              textAlign: TextAlign.center,
              style: AppTextStyles.font18Bold.copyWith(
                color: AppColors.textPrimary,
              ),
            ),
            if (widget.subtitle != null) ...[
              hSpace(6),
              Text(
                widget.subtitle!,
                textAlign: TextAlign.center,
                style: AppTextStyles.font14Regular.copyWith(
                  color: AppColors.textSecondary,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
            hSpace(16),
            CustomTextFormField(
              controller: _controller,
              hintText:
                  widget.hintText ??
                  'leaves.rejection.reasonHint'.tr(context: context),
              maxLines: 3,
              validator:
                  widget.validator ??
                  (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'leaves.rejection.reasonRequired'.tr(
                        context: context,
                      );
                    }
                    return null;
                  },
            ),
            hSpace(20),
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    text:
                        widget.cancelLabel ??
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
                        widget.confirmLabel ??
                        'supervisor.leave.reject'.tr(context: context),
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
