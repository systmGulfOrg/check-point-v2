import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:check_point_v2/core/core.dart';

class DisciplinaryAppealDialogWidget extends StatefulWidget {
  const DisciplinaryAppealDialogWidget({
    super.key,
    required this.violationDescription,
    required this.onSubmit,
  });

  final String violationDescription;
  final ValueChanged<String> onSubmit;

  @override
  State<DisciplinaryAppealDialogWidget> createState() =>
      _DisciplinaryAppealDialogWidgetState();
}

class _DisciplinaryAppealDialogWidgetState
    extends State<DisciplinaryAppealDialogWidget> {
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

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
      ),
      backgroundColor: AppColors.cardBackground,
      child: Padding(
        padding: EdgeInsets.all(20.r),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 36.r,
                  height: 36.r,
                  decoration: BoxDecoration(
                    color: AppColors.softBrandBackground,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.edit_note_rounded,
                    size: 20.r,
                    color: AppColors.brandPrimary,
                  ),
                ),
                wSpace(10),
                Expanded(
                  child: Text(
                    'تقديم تظلم إداري',
                    style: AppTextStyles.font16Bold,
                  ),
                ),
              ],
            ),
            if (widget.violationDescription.isNotEmpty) ...[
              hSpace(12),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(10.r),
                decoration: BoxDecoration(
                  color: AppColors.fieldBackground,
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(color: AppColors.border),
                ),
                child: Text(
                  widget.violationDescription,
                  style: AppTextStyles.font12Medium.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
            ],
            hSpace(16),
            CustomTextFormField(
              controller: _reasonController,
              hintText: 'اكتب سبب التظلم والاعتراض بالتفصيل...',
              maxLines: 4,
            ),
            hSpace(20),
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    text: 'إلغاء',
                    backgroundColor: AppColors.border,
                    textColor: AppColors.textPrimary,
                    onTap: () => Navigator.of(context).pop(),
                  ),
                ),
                wSpace(12),
                Expanded(
                  child: CustomButton(
                    text: 'إرسال التظلم',
                    backgroundColor: AppColors.brandPrimary,
                    textColor: AppColors.white,
                    onTap: () {
                      final text = _reasonController.text.trim();
                      if (text.isNotEmpty) {
                        Navigator.of(context).pop();
                        widget.onSubmit(text);
                      }
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
