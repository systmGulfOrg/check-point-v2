import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/admin/data/models/leave_requests/leave_type_model.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/leave_requests/admin_leave_requests_cubit.dart';

class AdminNewLeaveTypeSheetWidget extends StatefulWidget {
  const AdminNewLeaveTypeSheetWidget({this.leaveType, super.key});

  final LeaveTypeModel? leaveType;

  @override
  State<AdminNewLeaveTypeSheetWidget> createState() =>
      _AdminNewLeaveTypeSheetWidgetState();
}

class _AdminNewLeaveTypeSheetWidgetState
    extends State<AdminNewLeaveTypeSheetWidget> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _typeNameController;
  late final TextEditingController _maxDaysController;
  late bool _isPaid;
  late bool _requiresAttachment;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _typeNameController = TextEditingController(
      text: widget.leaveType?.typeName ?? '',
    );
    _maxDaysController = TextEditingController(
      text: widget.leaveType?.maxDaysPerYear?.toString() ?? '',
    );
    _isPaid = widget.leaveType?.isPaid ?? true;
    _requiresAttachment = widget.leaveType?.requiresAttachment ?? false;
  }

  @override
  void dispose() {
    _typeNameController.dispose();
    _maxDaysController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    final typeName = _typeNameController.text.trim();
    final maxDays = int.tryParse(_maxDaysController.text.trim());

    final body = AddLeaveTypeRequestBody(
      typeName: typeName,
      maxDaysPerYear: maxDays,
      isPaid: _isPaid,
      requiresAttachment: _requiresAttachment,
    );

    final cubit = context.read<AdminLeaveRequestsCubit>();
    final bool success;

    if (widget.leaveType?.id != null) {
      success = await cubit.editLeaveType(widget.leaveType!.id!, body);
    } else {
      success = await cubit.addLeaveType(body);
    }

    if (mounted) {
      setState(() => _isLoading = false);
      if (success) {
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.leaveType != null;
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      padding: EdgeInsets.fromLTRB(
        20.w,
        16.h,
        20.w,
        MediaQuery.of(context).viewInsets.bottom + 20.h,
      ),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    isEditing
                        ? 'admin.leaveManagement.editType'.tr(context: context)
                        : 'admin.leaveManagement.addType'.tr(context: context),
                    style: AppTextStyles.font16Bold,
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              hSpace(16),
              Text(
                'admin.leaveManagement.typeName'.tr(context: context),
                style: AppTextStyles.font13SemiBold,
              ),
              hSpace(6),
              CustomTextFormField(
                controller: _typeNameController,
                hintText: 'admin.leaveManagement.typeNameHint'.tr(
                  context: context,
                ),
                validator: AppValidators.required(
                  message: 'validation.required'.tr(context: context),
                  context: context,
                ),
              ),
              hSpace(14),
              Text(
                'admin.leaveManagement.maxDays'.tr(context: context),
                style: AppTextStyles.font13SemiBold,
              ),
              hSpace(6),
              CustomTextFormField(
                controller: _maxDaysController,
                keyboardType: TextInputType.number,
                hintText: 'admin.leaveManagement.maxDaysHint'.tr(
                  context: context,
                ),
                validator: AppValidators.positiveNumber(
                  context: context,
                ),
              ),
              hSpace(14),
              SwitchListTile.adaptive(
                contentPadding: EdgeInsets.zero,
                title: Text(
                  'admin.leaveManagement.isPaid'.tr(context: context),
                  style: AppTextStyles.font14Regular.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
                value: _isPaid,
                activeTrackColor: AppColors.brandPrimary,
                onChanged: (val) => setState(() => _isPaid = val),
              ),
              SwitchListTile.adaptive(
                contentPadding: EdgeInsets.zero,
                title: Text(
                  'admin.leaveManagement.requiresAttachment'.tr(
                    context: context,
                  ),
                  style: AppTextStyles.font14Regular.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
                value: _requiresAttachment,
                activeTrackColor: AppColors.brandPrimary,
                onChanged: (val) => setState(() => _requiresAttachment = val),
              ),
              hSpace(20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.brandPrimary,
                    foregroundColor: AppColors.white,
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                  onPressed: _isLoading ? null : _submit,
                  child: _isLoading
                      ? SizedBox(
                          width: 20.r,
                          height: 20.r,
                          child: const CircularProgressIndicator(
                            color: AppColors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : Text(
                          'common.save'.tr(context: context),
                          style: AppTextStyles.font14SemiBold.copyWith(
                            color: AppColors.white,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
