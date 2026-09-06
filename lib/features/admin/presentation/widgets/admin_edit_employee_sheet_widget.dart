import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/core.dart';
import '../../data/models/edit_employee_request_body.dart';
import '../../data/models/employee_model.dart';

class AdminEditEmployeeSheetWidget extends StatefulWidget {
  const AdminEditEmployeeSheetWidget({
    required this.employee,
    required this.onSave,
    super.key,
  });

  final EmployeeModel employee;
  final ValueChanged<EditEmployeeRequestBody> onSave;

  @override
  State<AdminEditEmployeeSheetWidget> createState() =>
      _AdminEditEmployeeSheetWidgetState();
}

class _AdminEditEmployeeSheetWidgetState
    extends State<AdminEditEmployeeSheetWidget> {
  late final TextEditingController _nameController;
  late final TextEditingController _userNameController;
  late final TextEditingController _positionController;
  late final TextEditingController _mobileIdController;
  late String _selectedRole;

  static const List<String> _roles = ['Employee', 'Supervisor', 'Admin'];

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.employee.name ?? '');
    _userNameController = TextEditingController(
      text: widget.employee.userName ?? '',
    );
    _positionController = TextEditingController(
      text: widget.employee.position ?? '',
    );
    _mobileIdController = TextEditingController(
      text: widget.employee.mobileId ?? '',
    );
    _selectedRole = _resolveRole(widget.employee.role);
  }

  String _resolveRole(String? role) {
    final lower = (role ?? '').toLowerCase();
    if (lower == 'supervisor') return 'Supervisor';
    if (lower == 'admin') return 'Admin';
    return 'Employee';
  }

  @override
  void dispose() {
    _nameController.dispose();
    _userNameController.dispose();
    _positionController.dispose();
    _mobileIdController.dispose();
    super.dispose();
  }

  void _handleSave() {
    if (_nameController.text.trim().isEmpty) return;

    widget.onSave(
      EditEmployeeRequestBody(
        name: _nameController.text.trim(),
        userName: _userNameController.text.trim(),
        position: _positionController.text.trim(),
        mobileId: _mobileIdController.text.trim(),
        role: _selectedRole,
        departmentId: widget.employee.departmentId ?? 1,
        branchId: widget.employee.branchId ?? 1,
      ),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) => SafeArea(
    child: Padding(
      padding: EdgeInsets.fromLTRB(
        20.w,
        18.h,
        20.w,
        16.h + MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'admin.employees.editEmployee'.tr(context: context),
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
            Text(
              'admin.employees.fullName'.tr(context: context),
              style: AppTextStyles.font12Medium,
            ),
            hSpace(8),
            CustomTextFormField(
              controller: _nameController,
              hintText: 'admin.employees.fullName'.tr(context: context),
            ),
            hSpace(14),
            Text(
              'admin.employees.username'.tr(context: context),
              style: AppTextStyles.font12Medium,
            ),
            hSpace(8),
            CustomTextFormField(
              controller: _userNameController,
              hintText: 'admin.employees.username'.tr(context: context),
            ),
            hSpace(14),
            Text(
              'admin.employees.position'.tr(context: context),
              style: AppTextStyles.font12Medium,
            ),
            hSpace(8),
            CustomTextFormField(
              controller: _positionController,
              hintText: 'admin.employees.position'.tr(context: context),
            ),
            hSpace(14),
            Text(
              'admin.employees.mobileId'.tr(context: context),
              style: AppTextStyles.font12Medium,
            ),
            hSpace(8),
            CustomTextFormField(
              controller: _mobileIdController,
              hintText: 'admin.employees.mobileId'.tr(context: context),
            ),
            hSpace(14),
            Text(
              'admin.employees.role'.tr(context: context),
              style: AppTextStyles.font12Medium,
            ),
            hSpace(8),
            Row(
              children: [
                for (final role in _roles) ...[
                  Expanded(
                    child: CustomButton(
                      text: switch (role) {
                        'Supervisor' => 'admin.employees.filterSupervisor'.tr(
                          context: context,
                        ),
                        'Admin' => 'admin.employees.filterAdmin'.tr(
                          context: context,
                        ),
                        _ => 'admin.employees.filterEmployee'.tr(
                          context: context,
                        ),
                      },
                      onTap: () => setState(() => _selectedRole = role),
                      backgroundColor: _selectedRole == role
                          ? AppColors.softBrandBackground
                          : AppColors.pageBackground,
                      textColor: _selectedRole == role
                          ? AppColors.brandPrimary
                          : AppColors.textSecondary,
                      height: 40,
                    ),
                  ),
                  if (role != _roles.last) vSpace(8),
                ],
              ],
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
                  ),
                ),
                vSpace(12),
                Expanded(
                  child: CustomButton(
                    text: 'admin.locations.create.save'.tr(context: context),
                    onTap: _handleSave,
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
