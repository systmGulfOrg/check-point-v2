import 'dart:convert';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/core/di/service_locator.dart';
import 'package:check_point_v2/features/admin/data/models/employee/edit_employee_request_body.dart';
import 'package:check_point_v2/features/admin/data/models/employee/employee_model.dart';
import 'package:check_point_v2/features/admin/data/models/locations/branch_response_model.dart';
import 'package:check_point_v2/features/admin/data/models/locations/department_response_model.dart';
import 'package:check_point_v2/features/admin/data/repos/admin_permissions_repo.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/employee/admin_employees_cubit.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/employee/admin_employees_state.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/locations/admin_branches_cubit.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/locations/admin_branches_state.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/locations/admin_departments_cubit.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/locations/admin_departments_state.dart';
import 'package:check_point_v2/features/admin/presentation/widgets/admin_employee_work_system_widget.dart';
import 'package:check_point_v2/features/admin/presentation/widgets/admin_permissions_picker_dialog_widget.dart';
import 'package:check_point_v2/features/admin/presentation/widgets/admin_wizard_field_widget.dart';
import '../admin_employee_profile_info_card_widget.dart';

class AdminEmployeeProfileEditFormWidget extends StatefulWidget {
  const AdminEmployeeProfileEditFormWidget({
    required this.employee,
    required this.onSave,
    required this.onCancel,
    super.key,
  });

  final EmployeeModel employee;
  final Future<void> Function(EditEmployeeRequestBody body) onSave;
  final VoidCallback onCancel;

  @override
  State<AdminEmployeeProfileEditFormWidget> createState() =>
      _AdminEmployeeProfileEditFormWidgetState();
}

class _AdminEmployeeProfileEditFormWidgetState
    extends State<AdminEmployeeProfileEditFormWidget> {
  final _formKey = GlobalKey<FormState>();
  bool _isSaving = false;
  bool _obscurePassword = true;

  late final TextEditingController _nameController;
  late final TextEditingController _userNameController;
  late final TextEditingController _passwordController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;
  late final TextEditingController _employeeCodeController;
  late final TextEditingController _positionController;
  late final TextEditingController _mobileIdController;
  late final TextEditingController _leaveBalanceController;

  String? _selectedPhotoPath;
  String? _photoBase64;

  int? _selectedDepartmentId;
  int? _selectedBranchId;
  String? _selectedDirectManagerId;
  late String _selectedWorkSystem;
  String? _selectedRemoteWorkPolicyId;
  late bool _canAddAttendance;
  late bool _canAddPlan;

  late final Set<String> _selectedRoles;
  final Set<String> _selectedPermissions = {};

  static const List<String> _availableRoles = [
    'Employee',
    'Supervisor',
    'Admin',
  ];

  @override
  void initState() {
    super.initState();
    final emp = widget.employee;

    _nameController = TextEditingController(text: emp.name ?? '');
    _userNameController = TextEditingController(text: emp.userName ?? '');
    _passwordController = TextEditingController();
    _emailController = TextEditingController(text: emp.email ?? '');
    _phoneController = TextEditingController(text: emp.phone ?? '');
    _employeeCodeController = TextEditingController(
      text: emp.employeeCode ?? '',
    );
    _positionController = TextEditingController(text: emp.position ?? '');
    _mobileIdController = TextEditingController(text: emp.mobileId ?? '');
    _leaveBalanceController = TextEditingController(
      text: '${emp.leaveBalance ?? 21}',
    );

    _selectedDepartmentId = emp.departmentId;
    _selectedBranchId = emp.branchId;
    _selectedDirectManagerId = emp.resolvedDirectManagerId;
    _selectedWorkSystem = emp.workSystem ?? 'onsite';
    _selectedRemoteWorkPolicyId = emp.remoteWorkPolicyId;
    _canAddAttendance = emp.canAddAttendance ?? true;
    _canAddPlan = emp.canAddPlan ?? true;

    _selectedRoles = emp.allRoles.toSet();
    if (_selectedRoles.isEmpty) _selectedRoles.add('Employee');

    if (emp.customPermissions != null && emp.customPermissions!.isNotEmpty) {
      _selectedPermissions.addAll(emp.customPermissions!);
    } else if (emp.permissions != null && emp.permissions!.isNotEmpty) {
      _selectedPermissions.addAll(emp.permissions!);
    }

    _selectedPhotoPath = emp.imageUrl;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _userNameController.dispose();
    _passwordController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _employeeCodeController.dispose();
    _positionController.dispose();
    _mobileIdController.dispose();
    _leaveBalanceController.dispose();
    super.dispose();
  }

  Future<void> _pickPhoto() async {
    try {
      final result = await FilePicker.pickFiles(
        type: FileType.image,
        allowMultiple: false,
      );
      if (result != null && result.files.single.path != null) {
        final filePath = result.files.single.path!;
        final bytes = await File(filePath).readAsBytes();
        final base64String = base64Encode(bytes);
        setState(() {
          _selectedPhotoPath = filePath;
          _photoBase64 = 'data:image/jpeg;base64,$base64String';
        });
      }
    } catch (_) {}
  }

  Future<void> _openPermissionsPicker() async {
    final permissionsRepo = sl<AdminPermissionsRepo>();
    final result = await permissionsRepo.getCatalogue();
    if (!mounted) return;
    await result.when(
      success: (catalogue) async {
        final updated = await AdminPermissionsPickerDialogWidget.show(
          context,
          catalogue: catalogue,
          initialSelectedPermissions: _selectedPermissions,
        );
        if (mounted && updated != null) {
          setState(() {
            _selectedPermissions
              ..clear()
              ..addAll(updated);
          });
        }
      },
      failure: (failure) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(failure.messageKey.tr(context: context)),
            backgroundColor: AppColors.error,
          ),
        );
      },
    );
  }

  Future<void> _handleSubmit() async {
    if (!_formKey.currentState!.validate()) return;

    final name = _nameController.text.trim();
    if (name.isEmpty) return;

    if (_selectedWorkSystem != 'onsite' &&
        _selectedRemoteWorkPolicyId == null) {
      CustomSnackBar.showError(
        context,
        message: 'admin.employeeWizard.workPolicyRequired'.tr(context: context),
      );
      return;
    }

    setState(() => _isSaving = true);
    try {
      final body = EditEmployeeRequestBody(
        name: name,
        userName: _userNameController.text.trim().isNotEmpty
            ? _userNameController.text.trim()
            : null,
        password: _passwordController.text.isNotEmpty
            ? _passwordController.text
            : null,
        email: _emailController.text.trim().isNotEmpty
            ? _emailController.text.trim()
            : null,
        phone: _phoneController.text.trim().isNotEmpty
            ? _phoneController.text.trim()
            : null,
        employeeCode: _employeeCodeController.text.trim().isNotEmpty
            ? _employeeCodeController.text.trim()
            : null,
        position: _positionController.text.trim().isNotEmpty
            ? _positionController.text.trim()
            : null,
        mobileId: _mobileIdController.text.trim().isNotEmpty
            ? _mobileIdController.text.trim()
            : null,
        imageUrl: _photoBase64 ?? widget.employee.imageUrl,
        workSystem: _selectedWorkSystem,
        remoteWorkPolicyId: _selectedRemoteWorkPolicyId,
        departmentId: _selectedDepartmentId,
        branchId: _selectedBranchId,
        directManagerId: _selectedDirectManagerId,
        managerId: _selectedDirectManagerId,
        role: _selectedRoles.contains('Admin')
            ? 'Admin'
            : _selectedRoles.contains('Supervisor')
            ? 'Supervisor'
            : 'Employee',
        roles: _selectedRoles.toList(),
        customPermissions: _selectedPermissions.toList(),
        canAddAttendance: _canAddAttendance,
        canAddPlan: _canAddPlan,
        leaveBalance: int.tryParse(_leaveBalanceController.text.trim()),
      );

      await widget.onSave(body);
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        children: [
          // Section 1: Personal & Account Details
          AdminEmployeeProfileInfoCardWidget(
            title: 'admin.employeeWizard.personalTitle'.tr(context: context),
            icon: Icons.person_outline_rounded,
            children: [
              // Avatar Picker
              Center(
                child: GestureDetector(
                  onTap: _pickPhoto,
                  child: Stack(
                    children: [
                      Container(
                        width: 88.r,
                        height: 88.r,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.brandPrimary,
                            width: 2,
                          ),
                          boxShadow: const [
                            BoxShadow(
                              color: AppColors.shadow,
                              blurRadius: 8,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: ClipOval(
                          child: _buildAvatarImage(),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          padding: EdgeInsets.all(6.r),
                          decoration: const BoxDecoration(
                            color: AppColors.brandPrimary,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.camera_alt_rounded,
                            size: 16.r,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              hSpace(16),
              AdminWizardFieldWidget(
                label: 'admin.employeeWizard.employeeCode'.tr(context: context),
                required: false,
                child: CustomTextFormField(
                  controller: _employeeCodeController,
                  hintText: 'EMP-001',
                  prefixIcon: Icon(
                    Icons.badge_outlined,
                    size: 20.r,
                    color: AppColors.placeholder,
                  ),
                ),
              ),
              AdminWizardFieldWidget(
                label: 'admin.employeeWizard.fullName'.tr(context: context),
                child: CustomTextFormField(
                  controller: _nameController,
                  hintText: 'admin.employeeWizard.fullNameHint'.tr(
                    context: context,
                  ),
                  prefixIcon: Icon(
                    Icons.person_outline,
                    size: 20.r,
                    color: AppColors.placeholder,
                  ),
                  validator: (val) {
                    if (val == null || val.trim().isEmpty) {
                      return 'admin.employeeWizard.requiredField'.tr(
                        context: context,
                      );
                    }
                    return null;
                  },
                ),
              ),
              AdminWizardFieldWidget(
                label: 'admin.employeeWizard.username'.tr(context: context),
                child: CustomTextFormField(
                  controller: _userNameController,
                  hintText: 'user.name',
                  prefixIcon: Icon(
                    Icons.alternate_email_rounded,
                    size: 20.r,
                    color: AppColors.placeholder,
                  ),
                  validator: (val) {
                    if (val == null || val.trim().isEmpty) {
                      return 'admin.employeeWizard.requiredField'.tr(
                        context: context,
                      );
                    }
                    return null;
                  },
                ),
              ),
              AdminWizardFieldWidget(
                label: 'admin.employeeWizard.password'.tr(context: context),
                required: false,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Directionality(
                      textDirection: ui.TextDirection.ltr,
                      child: CustomTextFormField(
                        controller: _passwordController,
                        hintText: '••••••••',
                        prefixIcon: Icon(
                          Icons.lock_outline,
                          size: 20.r,
                          color: AppColors.placeholder,
                        ),
                        obscureText: _obscurePassword,
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            size: 20.r,
                            color: AppColors.textSecondary,
                          ),
                          onPressed: () {
                            setState(
                              () => _obscurePassword = !_obscurePassword,
                            );
                          },
                        ),
                      ),
                    ),
                    hSpace(4),
                    Text(
                      'admin.editEmployee.leavePasswordEmptyHint'.tr(
                        context: context,
                      ),
                      style: AppTextStyles.font11Regular.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              AdminWizardFieldWidget(
                label: 'admin.employeeWizard.email'.tr(context: context),
                required: false,
                child: CustomTextFormField(
                  controller: _emailController,
                  hintText: 'user@company.com',
                  prefixIcon: Icon(
                    Icons.mail_outline,
                    size: 20.r,
                    color: AppColors.placeholder,
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (val) {
                    if (val != null && val.trim().isNotEmpty) {
                      final emailRegex = RegExp(
                        r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                      );
                      if (!emailRegex.hasMatch(val.trim())) {
                        return 'admin.employeeWizard.invalidEmail'.tr(
                          context: context,
                        );
                      }
                    }
                    return null;
                  },
                ),
              ),
              AdminWizardFieldWidget(
                label: 'admin.employeeWizard.phone'.tr(context: context),
                required: false,
                child: CustomTextFormField(
                  controller: _phoneController,
                  hintText: '01012345678',
                  prefixIcon: Icon(
                    Icons.phone_outlined,
                    size: 20.r,
                    color: AppColors.placeholder,
                  ),
                  keyboardType: TextInputType.phone,
                ),
              ),
              AdminWizardFieldWidget(
                label: 'admin.employeeWizard.position'.tr(context: context),
                required: false,
                child: CustomTextFormField(
                  controller: _positionController,
                  hintText: 'admin.employeeWizard.positionHint'.tr(
                    context: context,
                  ),
                  prefixIcon: Icon(
                    Icons.work_outline,
                    size: 20.r,
                    color: AppColors.placeholder,
                  ),
                ),
              ),
              AdminWizardFieldWidget(
                label: 'admin.employeeWizard.mobile'.tr(context: context),
                required: false,
                child: CustomTextFormField(
                  controller: _mobileIdController,
                  hintText: 'Device Hardware UUID',
                  prefixIcon: Icon(
                    Icons.smartphone_rounded,
                    size: 20.r,
                    color: AppColors.placeholder,
                  ),
                ),
              ),
            ],
          ),
          hSpace(16),

          // Section 2: Work System & Policy
          AdminEmployeeProfileInfoCardWidget(
            title: 'admin.employeeWizard.workTitle'.tr(context: context),
            icon: Icons.devices_other_outlined,
            children: [
              AdminEmployeeWorkSystemWidget(
                selectedSystem: _selectedWorkSystem,
                selectedPolicyId: _selectedRemoteWorkPolicyId,
                onSystemChanged: (ws) =>
                    setState(() => _selectedWorkSystem = ws),
                onPolicyChanged: (pid) =>
                    setState(() => _selectedRemoteWorkPolicyId = pid),
              ),
            ],
          ),
          hSpace(16),

          // Section 3: Organization, Roles & Permissions
          AdminEmployeeProfileInfoCardWidget(
            title: 'admin.employeeWizard.attendanceTitle'.tr(
              context: context,
            ),
            icon: Icons.corporate_fare_rounded,
            children: [
              // Department Dropdown
              BlocBuilder<AdminDepartmentsCubit, AdminDepartmentsState>(
                builder: (context, state) {
                  final depts = switch (state) {
                    AdminDepartmentsSuccess(:final departments) => departments,
                    _ => <DepartmentModel>[],
                  };
                  return DropdownButtonFormField<int>(
                    initialValue: _selectedDepartmentId != null &&
                            depts.any((d) => d.id == _selectedDepartmentId)
                        ? _selectedDepartmentId
                        : null,
                    decoration: InputDecoration(
                      labelText: 'admin.employeeWizard.department'.tr(
                        context: context,
                      ),
                      prefixIcon: const Icon(Icons.business_outlined),
                      filled: true,
                      fillColor: AppColors.pageBackground,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: const BorderSide(color: AppColors.border),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: const BorderSide(color: AppColors.border),
                      ),
                    ),
                    items: depts
                        .map(
                          (d) => DropdownMenuItem(
                            value: d.id,
                            child: Text(d.departmentName ?? '-'),
                          ),
                        )
                        .toList(),
                    onChanged: (val) =>
                        setState(() => _selectedDepartmentId = val),
                  );
                },
              ),
              hSpace(14),

              // Branch Dropdown
              BlocBuilder<AdminBranchesCubit, AdminBranchesState>(
                builder: (context, state) {
                  final branches = switch (state) {
                    AdminBranchesSuccess(:final branches) => branches,
                    _ => <BranchModel>[],
                  };
                  return DropdownButtonFormField<int>(
                    initialValue: _selectedBranchId != null &&
                            branches.any((b) => b.id == _selectedBranchId)
                        ? _selectedBranchId
                        : null,
                    decoration: InputDecoration(
                      labelText: 'admin.employeeWizard.branch'.tr(
                        context: context,
                      ),
                      prefixIcon: const Icon(Icons.location_on_outlined),
                      filled: true,
                      fillColor: AppColors.pageBackground,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: const BorderSide(color: AppColors.border),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: const BorderSide(color: AppColors.border),
                      ),
                    ),
                    items: branches
                        .map(
                          (b) => DropdownMenuItem(
                            value: b.id,
                            child: Text(b.name ?? '-'),
                          ),
                        )
                        .toList(),
                    onChanged: (val) =>
                        setState(() => _selectedBranchId = val),
                  );
                },
              ),
              hSpace(14),

              // Direct Manager Dropdown
              BlocBuilder<AdminEmployeesCubit, AdminEmployeesState>(
                builder: (context, state) {
                  final employees = state.maybeWhen(
                    success: (empList, _) => empList
                        .where((e) => e.id != widget.employee.id)
                        .toList(),
                    orElse: () => <EmployeeModel>[],
                  );
                  return DropdownButtonFormField<String>(
                    initialValue: _selectedDirectManagerId != null &&
                            employees.any(
                              (e) => e.id == _selectedDirectManagerId,
                            )
                        ? _selectedDirectManagerId
                        : null,
                    decoration: InputDecoration(
                      labelText: 'admin.employeeWizard.selectDirectManager'.tr(
                        context: context,
                      ),
                      prefixIcon: const Icon(
                        Icons.supervisor_account_outlined,
                      ),
                      filled: true,
                      fillColor: AppColors.pageBackground,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: const BorderSide(color: AppColors.border),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: const BorderSide(color: AppColors.border),
                      ),
                    ),
                    items: [
                      DropdownMenuItem<String>(
                        value: null,
                        child: Text(
                          'admin.employeeWizard.noDirectManager'.tr(
                            context: context,
                          ),
                        ),
                      ),
                      ...employees.map(
                        (e) => DropdownMenuItem(
                          value: e.id,
                          child: Text(e.name ?? '-'),
                        ),
                      ),
                    ],
                    onChanged: (val) =>
                        setState(() => _selectedDirectManagerId = val),
                  );
                },
              ),
              hSpace(16),

              // Roles
              Text(
                'admin.employeeWizard.roles'.tr(context: context),
                style: AppTextStyles.font14SemiBold.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
              hSpace(8),
              Wrap(
                spacing: 8.w,
                runSpacing: 8.h,
                children: _availableRoles.map((role) {
                  final isSelected = _selectedRoles.contains(role);
                  return FilterChip(
                    label: Text(
                      role,
                      style: AppTextStyles.font12Medium.copyWith(
                        color: isSelected
                            ? AppColors.white
                            : AppColors.textPrimary,
                        fontWeight: isSelected
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                    selected: isSelected,
                    selectedColor: AppColors.brandPrimary,
                    checkmarkColor: AppColors.white,
                    backgroundColor: AppColors.pageBackground,
                    onSelected: (selected) {
                      setState(() {
                        if (selected) {
                          _selectedRoles.add(role);
                        } else if (_selectedRoles.length > 1) {
                          _selectedRoles.remove(role);
                        }
                      });
                    },
                  );
                }).toList(),
              ),
              hSpace(16),

              // Permissions Dialog Button
              Container(
                padding: EdgeInsets.all(14.r),
                decoration: BoxDecoration(
                  color: AppColors.pageBackground,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: AppColors.border),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8.r),
                      decoration: BoxDecoration(
                        color: AppColors.brandPrimary.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.admin_panel_settings_outlined,
                        color: AppColors.brandPrimary,
                        size: 20.r,
                      ),
                    ),
                    wSpace(12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'admin.employeeWizard.permissionsSection'.tr(
                              context: context,
                            ),
                            style: AppTextStyles.font13SemiBold.copyWith(
                              color: AppColors.textPrimary,
                            ),
                          ),
                          hSpace(2),
                          Text(
                            '${_selectedPermissions.length} ${'admin.employeeWizard.permissionsSelectedCount'.tr(context: context)}',
                            style: AppTextStyles.font11Regular.copyWith(
                              color: AppColors.brandPrimary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: _openPermissionsPicker,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.brandPrimary,
                        foregroundColor: AppColors.white,
                        padding: EdgeInsets.symmetric(
                          horizontal: 14.w,
                          vertical: 8.h,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        'admin.employeeWizard.managePermissions'.tr(
                          context: context,
                        ),
                        style: AppTextStyles.font12Medium.copyWith(
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              hSpace(16),

              hSpace(12),

              // Leave Balance
              AdminWizardFieldWidget(
                label: 'admin.employees.leaveBalance'.tr(context: context),
                required: false,
                child: CustomTextFormField(
                  controller: _leaveBalanceController,
                  hintText: '21',
                  keyboardType: TextInputType.number,
                  prefixIcon: Icon(
                    Icons.event_available_outlined,
                    size: 20.r,
                    color: AppColors.placeholder,
                  ),
                ),
              ),
            ],
          ),
          hSpace(20),

          // Bottom Action Buttons
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: _isSaving ? null : widget.onCancel,
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    side: const BorderSide(color: AppColors.border),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                  child: Text(
                    'common.cancel'.tr(context: context),
                    style: AppTextStyles.font14Regular.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              wSpace(12),
              Expanded(
                child: CustomButton(
                  text: 'common.save'.tr(context: context),
                  isLoading: _isSaving,
                  onTap: _handleSubmit,
                ),
              ),
            ],
          ),
          hSpace(32),
        ],
      ),
    );
  }

  Widget _buildAvatarImage() {
    if (_selectedPhotoPath != null) {
      if (_selectedPhotoPath!.startsWith('data:image') ||
          _selectedPhotoPath!.length > 300) {
        try {
          final clean = _selectedPhotoPath!.contains(',')
              ? _selectedPhotoPath!.split(',').last
              : _selectedPhotoPath!;
          final bytes = base64Decode(clean);
          return Image.memory(bytes, fit: BoxFit.cover);
        } catch (_) {}
      }
      final file = File(_selectedPhotoPath!);
      if (file.existsSync()) {
        return Image.file(file, fit: BoxFit.cover);
      }
      if (_selectedPhotoPath!.startsWith('http')) {
        return Image.network(_selectedPhotoPath!, fit: BoxFit.cover);
      }
    }
    return Container(
      color: AppColors.pageBackground,
      child: Icon(
        Icons.person_rounded,
        size: 46.r,
        color: AppColors.placeholder,
      ),
    );
  }
}
