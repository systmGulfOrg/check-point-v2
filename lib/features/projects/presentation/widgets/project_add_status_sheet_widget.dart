import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';

class ProjectAddStatusSheetWidget extends StatefulWidget {
  const ProjectAddStatusSheetWidget({required this.onSave, super.key});

  final ValueChanged<String> onSave;

  @override
  State<ProjectAddStatusSheetWidget> createState() =>
      _ProjectAddStatusSheetWidgetState();
}

class _ProjectAddStatusSheetWidgetState
    extends State<ProjectAddStatusSheetWidget> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28.r)),
      ),
      padding: EdgeInsets.fromLTRB(20.w, 24.h, 20.w, 20.h),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AppSheetHandleWidget(),
            hSpace(14),
            Text(
              'projects.addStatus'.tr(context: context),
              style: AppTextStyles.font20Bold,
            ),
            SizedBox(height: 16.h),
            CustomTextFormField(
              hintText: 'projects.statusName'.tr(context: context),
              controller: _controller,
            ),
            SizedBox(height: 16.h),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: AppColors.border),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14.r),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                    ),
                    child: Text(
                      'common.cancel'.tr(context: context),
                      style: AppTextStyles.font14Bold.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: CustomButton(
                    text: 'common.save'.tr(context: context),
                    onTap: () {
                      final text = _controller.text.trim();
                      if (text.isNotEmpty) {
                        widget.onSave(text);
                      }
                      Navigator.pop(context);
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
