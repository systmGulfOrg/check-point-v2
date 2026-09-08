import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/supervisor/presentation/widgets/supervisor_create_task_field_widget.dart';

class AdminNewShiftSheetWidget extends StatefulWidget {
  const AdminNewShiftSheetWidget({super.key});

  @override
  State<AdminNewShiftSheetWidget> createState() =>
      _AdminNewShiftSheetWidgetState();
}

class _AdminNewShiftSheetWidgetState extends State<AdminNewShiftSheetWidget> {
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.fromLTRB(20.w, 18.h, 20.w, 16.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'admin.shifts.create.title'.tr(context: context),
                  style: AppTextStyles.font18Bold,
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(Icons.close_rounded, size: 20.r),
                ),
              ],
            ),
            const Divider(color: AppColors.border),
            hSpace(14),
            SupervisorCreateTaskFieldWidget(
              labelKey: 'admin.shifts.create.nameLabel',
              hintKey: 'admin.shifts.create.nameHint',
              controller: nameController,
            ),
            hSpace(16),
            SupervisorCreateTaskFieldWidget(
              labelKey: 'admin.shifts.create.descriptionLabel',
              hintKey: 'admin.shifts.create.descriptionHint',
              controller: descriptionController,
              maxLines: 2,
            ),
            hSpace(16),
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    text: 'admin.locations.create.cancel'.tr(context: context),
                    onTap: () => Navigator.pop(context),
                    backgroundColor: AppColors.pageBackground,
                    textColor: AppColors.textPrimary,
                  ),
                ),
                vSpace(12),
                Expanded(
                  child: CustomButton(
                    text: 'admin.locations.create.save'.tr(context: context),
                    onTap: () => Navigator.pop(context),
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
