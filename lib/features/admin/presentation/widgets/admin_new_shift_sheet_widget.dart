import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/admin/data/models/shifts_policies/shift_model.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/shifts_policies/admin_shifts_policies_cubit.dart';
import 'package:check_point_v2/features/supervisor/presentation/widgets/supervisor_create_task_field_widget.dart';

class AdminNewShiftSheetWidget extends StatefulWidget {
  const AdminNewShiftSheetWidget({super.key});

  @override
  State<AdminNewShiftSheetWidget> createState() =>
      _AdminNewShiftSheetWidgetState();
}

class _AdminNewShiftSheetWidgetState extends State<AdminNewShiftSheetWidget> {
  late final TextEditingController nameController;
  late final TextEditingController descriptionController;
  bool isSubmitting = false;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    descriptionController = TextEditingController();
  }

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  Future<void> submit() async {
    final name = nameController.text.trim();
    if (name.isEmpty) {
      CustomSnackBar.showError(
        context,
        message: 'auth.login.required'.tr(context: context),
      );
      return;
    }

    setState(() => isSubmitting = true);
    final saved = await context.read<AdminShiftsPoliciesCubit>().addShift(
      AddShiftRequestBody(
        name: name,
        description: descriptionController.text.trim().isEmpty
            ? null
            : descriptionController.text.trim(),
      ),
    );

    if (!mounted) return;
    setState(() => isSubmitting = false);
    if (saved) {
      Navigator.pop(context);
      CustomSnackBar.showSuccess(
        context,
        message: 'admin.locations.create.successMessage'.tr(context: context),
      );
    }
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
                    onTap: submit,
                    isLoading: isSubmitting,
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
