import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/admin/data/models/locations/department_request_model.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/locations/admin_departments_cubit.dart';

class AdminCreateDepartmentSheetWidget extends StatefulWidget {
  const AdminCreateDepartmentSheetWidget({
    this.departmentId,
    this.initialName,
    super.key,
  });

  final int? departmentId;
  final String? initialName;

  @override
  State<AdminCreateDepartmentSheetWidget> createState() =>
      _AdminCreateDepartmentSheetWidgetState();
}

class _AdminCreateDepartmentSheetWidgetState
    extends State<AdminCreateDepartmentSheetWidget> {
  late final TextEditingController _nameController;
  final _formKey = GlobalKey<FormState>();
  bool _isSaving = false;

  bool get _isEditing => widget.departmentId != null;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.initialName ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _onSave() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    setState(() => _isSaving = true);

    final name = _nameController.text.trim();
    final request = DepartmentRequestModel(departmentName: name);
    final cubit = context.read<AdminDepartmentsCubit>();

    final success = _isEditing
        ? await cubit.editDepartment(
            widget.departmentId!,
            request,
          )
        : await cubit.addDepartment(request);

    if (!mounted) return;
    setState(() => _isSaving = false);

    if (success) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'admin.locations.create.successMessage'.tr(context: context),
          ),
          backgroundColor: AppColors.success,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.viewInsetsOf(context).bottom;
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 16.h + bottomInset),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: AppColors.border,
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
            ),
            hSpace(14),
            Row(
              children: [
                Container(
                  width: 36.r,
                  height: 36.r,
                  decoration: BoxDecoration(
                    color: AppColors.softBrandBackground,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Icon(
                    _isEditing
                        ? Icons.edit_note_outlined
                        : Icons.domain_add_outlined,
                    color: AppColors.brandPrimary,
                    size: 20.r,
                  ),
                ),
                vSpace(10),
                Expanded(
                  child: Text(
                    (_isEditing
                            ? 'admin.departments.editTitle'
                            : 'admin.departments.addTitle')
                        .tr(context: context),
                    style: AppTextStyles.font16Bold.copyWith(
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close_rounded),
                  color: AppColors.textSecondary,
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            Text(
              'admin.departments.nameLabel'.tr(context: context),
              style: AppTextStyles.font12Medium,
            ),
            hSpace(8),
            CustomTextFormField(
              controller: _nameController,
              hintText: 'admin.departments.nameHint'.tr(context: context),
              prefixIcon: const Icon(
                Icons.corporate_fare_outlined,
                color: AppColors.textSecondary,
              ),
              validator: (val) {
                if (val == null || val.trim().isEmpty) {
                  return 'admin.departments.nameRequired'.tr(context: context);
                }
                return null;
              },
            ),
            hSpace(20),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: _isSaving ? null : () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.textSecondary,
                      side: const BorderSide(color: AppColors.border),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                    ),
                    child: Text(
                      'admin.locations.create.cancel'.tr(context: context),
                      style: AppTextStyles.font14Medium.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),
                ),
                vSpace(12),
                Expanded(
                  flex: 2,
                  child: CustomButton(
                    text: 'admin.departments.save'.tr(context: context),
                    isLoading: _isSaving,
                    onTap: _onSave,
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
