import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/core/di/service_locator.dart';
import 'package:check_point_v2/features/support/data/apis/support_ticket_api_service.dart';
import 'package:check_point_v2/features/support/presentation/cubit/support_ticket_cubit.dart';

/// Opens the feedback/bug-report dialog.
///
/// [type] must be `'feedback'` or `'bug'`.
void showSupportTicketDialog(BuildContext context, {required String type}) {
  showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (_) => BlocProvider(
      create: (_) => SupportTicketCubit(api: sl<SupportTicketApiService>()),
      child: SupportTicketDialogWidget(type: type),
    ),
  );
}

// ─────────────────────────────────────────────────────────────────────────────

class SupportTicketDialogWidget extends StatefulWidget {
  const SupportTicketDialogWidget({required this.type, super.key});

  /// 'feedback' or 'bug'
  final String type;

  @override
  State<SupportTicketDialogWidget> createState() =>
      SupportTicketDialogWidgetState();
}

class SupportTicketDialogWidgetState extends State<SupportTicketDialogWidget> {
  final _controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String get _titleKey => widget.type == 'bug'
      ? 'auth.companyCode.reportBug'
      : 'auth.companyCode.sendFeedback';

  String get _hintKey =>
      widget.type == 'bug' ? 'support.bugHint' : 'support.feedbackHint';

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SupportTicketCubit, SupportTicketState>(
      listener: (context, state) {
        if (state is SupportTicketSuccess) {
          Navigator.pop(context);
          CustomSnackBar.showSuccess(
            context,
            message: 'support.successMessage'.tr(context: context),
          );
        } else if (state is SupportTicketFailure) {
          CustomSnackBar.showError(
            context,
            message: 'support.errorMessage'.tr(context: context),
          );
        }
      },
      builder: (context, state) {
        final isLoading = switch (state) {
          SupportTicketLoading() => true,
          _ => false,
        };

        return AlertDialog(
          backgroundColor: AppColors.white,
          surfaceTintColor: AppColors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          title: Text(
            _titleKey.tr(context: context),
            style: AppTextStyles.font16Bold,
          ),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'support.descriptionLabel'.tr(context: context),
                  style: AppTextStyles.font13SemiBold.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
                hSpace(8),
                CustomTextFormField(
                  controller: _controller,
                  hintText: _hintKey.tr(context: context),
                  minLines: 4,
                  maxLines: 6,
                  maxLength: 1000,
                  enabled: !isLoading,
                  style: AppTextStyles.font14Regular,
                  decoration: InputDecoration(
                    hintText: _hintKey.tr(context: context),
                    hintStyle: AppTextStyles.font13Regular.copyWith(
                      color: AppColors.placeholder,
                    ),
                    filled: true,
                    fillColor: AppColors.fieldBackground,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: BorderSide(color: AppColors.border),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: BorderSide(color: AppColors.border),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: BorderSide(
                        color: AppColors.brandPrimary,
                        width: 1.4,
                      ),
                    ),
                    contentPadding: EdgeInsetsDirectional.symmetric(
                      horizontal: 14.w,
                      vertical: 12.h,
                    ),
                  ),
                  validator: (v) {
                    if (v == null || v.trim().length < 5) {
                      return 'support.validationMin'.tr(context: context);
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: isLoading ? null : () => Navigator.pop(context),
              child: Text(
                'core.actions.cancel'.tr(context: context),
                style: AppTextStyles.font14Regular.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ),
            TextButton(
              onPressed: isLoading
                  ? null
                  : () {
                      if (!(_formKey.currentState?.validate() ?? false)) {
                        return;
                      }
                      context.read<SupportTicketCubit>().submit(
                        description: _controller.text.trim(),
                        type: widget.type,
                      );
                    },
              child: isLoading
                  ? SizedBox(
                      width: 18.r,
                      height: 18.r,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: AppColors.brandPrimary,
                      ),
                    )
                  : Text(
                      'support.submitButton'.tr(context: context),
                      style: AppTextStyles.font14SemiBold.copyWith(
                        color: AppColors.brandPrimary,
                      ),
                    ),
            ),
          ],
        );
      },
    );
  }
}
