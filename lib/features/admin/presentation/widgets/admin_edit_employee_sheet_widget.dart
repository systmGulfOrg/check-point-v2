import 'dart:convert';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _nameController;
  late final TextEditingController _userNameController;
  late final TextEditingController _passwordController;
  late final TextEditingController _positionController;
  late final TextEditingController _mobileIdController;
  late final TextEditingController _phoneController;
  late final TextEditingController _emailController;
  late final TextEditingController _employeeCodeController;
  late final TextEditingController _leaveBalanceController;

  String? _selectedPhotoPath;
  String? _photoBase64;
  bool _obscurePassword = true;

  late final Set<String> _selectedRoles;
  final Set<String> _selectedPermissions = {};
  int? _selectedDepartmentId;
  int? _selectedBranchId;
  String? _selectedDirectManagerId;
  late String _selectedWorkSystem;
  String? _selectedRemoteWorkPolicyId;
  late bool _canAddAttendance;
  late bool _canAddPlan;

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
    _positionController = TextEditingController(text: emp.position ?? '');
    _mobileIdController = TextEditingController(text: emp.mobileId ?? '');
    _phoneController = TextEditingController(text: emp.phone ?? '');
    _emailController = TextEditingController(text: emp.email ?? '');
    _employeeCodeController = TextEditingController(
      text: emp.employeeCode ?? '',
    );
    _leaveBalanceController = TextEditingController(
      text: '${emp.leaveBalance ?? 21}',
    );

    _selectedRoles = emp.allRoles.toSet();
    if (_selectedRoles.isEmpty) _selectedRoles.add('Employee');

    if (emp.customPermissions != null && emp.customPermissions!.isNotEmpty) {
      _selectedPermissions.addAll(emp.customPermissions!);
    } else if (emp.permissions != null && emp.permissions!.isNotEmpty) {
      _selectedPermissions.addAll(emp.permissions!);
    }

    _selectedPhotoPath = emp.imageUrl;
    _selectedDepartmentId = emp.departmentId;
    _selectedBranchId = emp.branchId;
    _selectedDirectManagerId = emp.resolvedDirectManagerId;
    _selectedWorkSystem = emp.workSystem ?? 'onsite';
    _selectedRemoteWorkPolicyId = emp.remoteWorkPolicyId;
    _canAddAttendance = emp.canAddAttendance ?? true;
    _canAddPlan = emp.canAddPlan ?? true;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _userNameController.dispose();
    _passwordController.dispose();
    _positionController.dispose();
    _mobileIdController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _employeeCodeController.dispose();
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
        final base64String = await AppImageCompressor.compressAndEncodeBase64(
          bytes,
        );
        setState(() {
          _selectedPhotoPath = filePath;
          _photoBase64 = base64String;
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

  Future<void> _handleSave() async {
    if (_nameController.text.trim().isEmpty) return;
    if (_selectedWorkSystem != 'onsite' &&
        _selectedRemoteWorkPolicyId == null) {
      CustomSnackBar.showError(
        context,
        message: 'admin.employeeWizard.workPolicyRequired'.tr(context: context),
      );
      return;
    }

    final primaryRole = _selectedRoles.contains('Admin')
        ? 'Admin'
        : _selectedRoles.contains('Supervisor')
        ? 'Supervisor'
        : 'Employee';

    final resolvedImageUrl =
        _photoBase64 ??
        await AppImageCompressor.compressExistingBase64(
          widget.employee.imageUrl,
        );

    widget.onSave(
      EditEmployeeRequestBody(
        name: _nameController.text.trim(),
        userName: _userNameController.text.trim().isNotEmpty
            ? _userNameController.text.trim()
            : null,
        password: _passwordController.text.trim().isNotEmpty
            ? _passwordController.text.trim()
            : null,
        position: _positionController.text.trim().isNotEmpty
            ? _positionController.text.trim()
            : null,
        mobileId: _mobileIdController.text.trim().isNotEmpty
            ? _mobileIdController.text.trim()
            : null,
        phone: _phoneController.text.trim().isNotEmpty
            ? _phoneController.text.trim()
            : null,
        email: _emailController.text.trim().isNotEmpty
            ? _emailController.text.trim()
            : null,
        employeeCode: _employeeCodeController.text.trim().isNotEmpty
            ? _employeeCodeController.text.trim()
            : null,
        imageUrl: resolvedImageUrl,
        role: primaryRole,
        roles: _selectedRoles.toList(),
        customPermissions: _selectedPermissions.toList(),
        departmentId: _selectedDepartmentId,
        branchId: _selectedBranchId,
        directManagerId: _selectedDirectManagerId,
        managerId: _selectedDirectManagerId,
        workSystem: _selectedWorkSystem,
        remoteWorkPolicyId: _selectedRemoteWorkPolicyId,
        canAddAttendance: _canAddAttendance,
        canAddPlan: _canAddPlan,
        leaveBalance: int.tryParse(_leaveBalanceController.text.trim()),
      ),
    );
    if (mounted) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) => SizedBox(
    height: MediaQuery.of(context).size.height * 0.78,
    child: SafeArea(
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          20.w,
          10.h,
          20.w,
          16.h + MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Drag Handle
            Center(
              child: Container(
                width: 44.w,
                height: 4.h,
                margin: EdgeInsets.only(bottom: 12.h),
                decoration: BoxDecoration(
                  color: AppColors.border,
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
            ),
            // Header
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
            hSpace(10),

            // Scrollable Form Content
            Expanded(
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Photo Picker Section
                      Center(
                        child: GestureDetector(
                          onTap: _pickPhoto,
                          child: Stack(
                            children: [
                              Container(
                                width: 90.r,
                                height: 90.r,
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
                                child: ClipOval(child: _buildAvatarImage()),
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
                      hSpace(6),
                      Center(
                        child: Text(
                          'admin.employeeWizard.profilePhoto'.tr(
                            context: context,
                          ),
                          style: AppTextStyles.font12Medium.copyWith(
                            color: AppColors.brandPrimary,
                          ),
                        ),
                      ),
                      hSpace(18),

                      // Full Name
                      AdminWizardFieldWidget(
                        label: 'admin.employees.fullName'.tr(context: context),
                        child: CustomTextFormField(
                          controller: _nameController,
                          hintText: 'admin.employees.fullName'.tr(
                            context: context,
                          ),
                          prefixIcon: Icon(
                            Icons.person_outline_rounded,
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
                      hSpace(12),

                      // Username
                      AdminWizardFieldWidget(
                        label: 'admin.employees.username'.tr(context: context),
                        child: CustomTextFormField(
                          controller: _userNameController,
                          hintText: 'admin.employees.username'.tr(
                            context: context,
                          ),
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
                      hSpace(12),

                      // Password (Optional on edit)
                      AdminWizardFieldWidget(
                        label: 'admin.employees.passwordOptional'.tr(
                          context: context,
                        ),
                        required: false,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomTextFormField(
                              controller: _passwordController,
                              hintText: '••••••••',
                              obscureText: _obscurePassword,
                              prefixIcon: Icon(
                                Icons.lock_outline_rounded,
                                size: 20.r,
                                color: AppColors.placeholder,
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscurePassword
                                      ? Icons.visibility_off_outlined
                                      : Icons.visibility_outlined,
                                  size: 20.r,
                                  color: AppColors.placeholder,
                                ),
                                onPressed: () => setState(
                                  () => _obscurePassword = !_obscurePassword,
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
                      hSpace(12),

                      // Position and Employee Code
                      Row(
                        children: [
                          Expanded(
                            child: AdminWizardFieldWidget(
                              label: 'admin.employees.position'.tr(
                                context: context,
                              ),
                              required: false,
                              child: CustomTextFormField(
                                controller: _positionController,
                                hintText: 'admin.employees.position'.tr(
                                  context: context,
                                ),
                                prefixIcon: Icon(
                                  Icons.work_outline_rounded,
                                  size: 20.r,
                                  color: AppColors.placeholder,
                                ),
                              ),
                            ),
                          ),
                          vSpace(10),
                          Expanded(
                            child: AdminWizardFieldWidget(
                              label: 'admin.employees.employeeCode'.tr(
                                context: context,
                              ),
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
                          ),
                        ],
                      ),
                      hSpace(12),

                      // Phone and Email
                      Row(
                        children: [
                          Expanded(
                            child: AdminWizardFieldWidget(
                              label: 'admin.employees.phone'.tr(
                                context: context,
                              ),
                              required: false,
                              child: CustomTextFormField(
                                controller: _phoneController,
                                hintText: '05xxxxxxxx',
                                keyboardType: TextInputType.phone,
                                prefixIcon: Icon(
                                  Icons.phone_outlined,
                                  size: 20.r,
                                  color: AppColors.placeholder,
                                ),
                              ),
                            ),
                          ),
                          vSpace(10),
                          Expanded(
                            child: AdminWizardFieldWidget(
                              label: 'admin.employees.email'.tr(
                                context: context,
                              ),
                              required: false,
                              child: CustomTextFormField(
                                controller: _emailController,
                                hintText: 'name@company.com',
                                keyboardType: TextInputType.emailAddress,
                                prefixIcon: Icon(
                                  Icons.email_outlined,
                                  size: 20.r,
                                  color: AppColors.placeholder,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      hSpace(12),

                      // Mobile ID (with copy button)
                      AdminWizardFieldWidget(
                        label: 'admin.employees.mobileId'.tr(context: context),
                        required: false,
                        child: CustomTextFormField(
                          controller: _mobileIdController,
                          hintText: 'admin.employees.mobileId'.tr(
                            context: context,
                          ),
                          prefixIcon: Icon(
                            Icons.tag_rounded,
                            size: 20.r,
                            color: AppColors.placeholder,
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              Icons.content_copy_outlined,
                              size: 18.r,
                              color: AppColors.placeholder,
                            ),
                            onPressed: () {
                              if (_mobileIdController.text.isNotEmpty) {
                                Clipboard.setData(
                                  ClipboardData(text: _mobileIdController.text),
                                );
                                CustomSnackBar.showSuccess(
                                  context,
                                  message: 'admin.employeeWizard.mobileCopied'
                                      .tr(context: context),
                                );
                              }
                            },
                          ),
                        ),
                      ),
                      hSpace(14),

                      // Roles Selection
                      Text(
                        'admin.employees.roles'.tr(context: context),
                        style: AppTextStyles.font13SemiBold,
                      ),
                      hSpace(8),
                      Wrap(
                        spacing: 8.w,
                        runSpacing: 8.h,
                        children: _availableRoles.map((role) {
                          final isSelected = _selectedRoles.contains(role);
                          return FilterChip(
                            label: Text(
                              switch (role) {
                                'Supervisor' => 'admin.roles.supervisor'.tr(
                                  context: context,
                                ),
                                'Admin' => 'admin.roles.admin'.tr(
                                  context: context,
                                ),
                                _ => 'admin.roles.employee'.tr(
                                  context: context,
                                ),
                              },
                              style: AppTextStyles.font12Medium.copyWith(
                                color: isSelected
                                    ? AppColors.white
                                    : AppColors.brandInk,
                              ),
                            ),
                            selected: isSelected,
                            selectedColor: AppColors.brandPrimary,
                            backgroundColor: AppColors.pageBackground,
                            checkmarkColor: AppColors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.r),
                              side: BorderSide(
                                color: isSelected
                                    ? AppColors.brandPrimary
                                    : AppColors.border,
                              ),
                            ),
                            onSelected: (selected) {
                              setState(() {
                                if (selected) {
                                  _selectedRoles.add(role);
                                } else {
                                  if (_selectedRoles.length > 1) {
                                    _selectedRoles.remove(role);
                                  }
                                }
                              });
                            },
                          );
                        }).toList(),
                      ),
                      hSpace(16),

                      // Work System & Remote Work Policy
                      AdminEmployeeWorkSystemWidget(
                        selectedSystem: _selectedWorkSystem,
                        selectedPolicyId: _selectedRemoteWorkPolicyId,
                        onSystemChanged: (value) => setState(() {
                          _selectedWorkSystem = value;
                          _selectedRemoteWorkPolicyId = null;
                        }),
                        onPolicyChanged: (value) =>
                            setState(() => _selectedRemoteWorkPolicyId = value),
                      ),
                      hSpace(16),

                      // Permissions Management Card
                      Container(
                        padding: EdgeInsets.all(14.r),
                        decoration: BoxDecoration(
                          color: AppColors.pageBackground,
                          borderRadius: BorderRadius.circular(14.r),
                          border: Border.all(color: AppColors.border),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(6.r),
                                      decoration: BoxDecoration(
                                        color: AppColors.softBlueBackground,
                                        borderRadius: BorderRadius.circular(
                                          8.r,
                                        ),
                                      ),
                                      child: Icon(
                                        Icons.security_rounded,
                                        color: AppColors.brandPrimary,
                                        size: 18.r,
                                      ),
                                    ),
                                    vSpace(10),
                                    Text(
                                      'admin.employeeWizard.permissionsSection'
                                          .tr(context: context),
                                      style: AppTextStyles.font14Bold,
                                    ),
                                  ],
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 8.w,
                                    vertical: 3.h,
                                  ),
                                  decoration: BoxDecoration(
                                    color: _selectedPermissions.isNotEmpty
                                        ? AppColors.softBlueBackground
                                        : AppColors.border.withValues(
                                            alpha: 0.4,
                                          ),
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                  child: Text(
                                    '${_selectedPermissions.length} ${'admin.employeeWizard.permissionsSelectedCount'.tr(context: context)}',
                                    style: AppTextStyles.font12Bold.copyWith(
                                      color: _selectedPermissions.isNotEmpty
                                          ? AppColors.brandPrimary
                                          : AppColors.textSecondary,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            hSpace(8),
                            Text(
                              'admin.employeeWizard.permissionsHelpNote'.tr(
                                context: context,
                              ),
                              style: AppTextStyles.font12Regular.copyWith(
                                color: AppColors.textSecondary,
                                height: 1.4,
                              ),
                            ),
                            hSpace(12),
                            OutlinedButton.icon(
                              onPressed: _openPermissionsPicker,
                              icon: Icon(Icons.tune_rounded, size: 18.r),
                              label: Text(
                                'admin.employeeWizard.managePermissions'.tr(
                                  context: context,
                                ),
                                style: AppTextStyles.font13Bold.copyWith(
                                  color: AppColors.brandPrimary,
                                ),
                              ),
                              style: OutlinedButton.styleFrom(
                                padding: EdgeInsets.symmetric(vertical: 10.h),
                                side: const BorderSide(
                                  color: AppColors.brandPrimary,
                                  width: 1.5,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      hSpace(16),

                      // Department Dropdown
                      BlocBuilder<AdminDepartmentsCubit, AdminDepartmentsState>(
                        builder: (context, deptState) {
                          final rawDepartments = switch (deptState) {
                            AdminDepartmentsSuccess(:final departments) =>
                              departments,
                            _ => const <DepartmentModel>[],
                          };
                          final departments = <DepartmentModel>[];
                          final seenIds = <int>{};
                          for (final d in rawDepartments) {
                            if (d.id != null && seenIds.add(d.id!)) {
                              departments.add(d);
                            }
                          }
                          final hasSelected = departments.any(
                            (d) => d.id == _selectedDepartmentId,
                          );
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'admin.employees.department'.tr(
                                  context: context,
                                ),
                                style: AppTextStyles.font12Medium,
                              ),
                              hSpace(6),
                              DropdownButtonFormField<int>(
                                key: ValueKey(
                                  'dept_${hasSelected ? _selectedDepartmentId : 'none'}',
                                ),
                                initialValue: hasSelected
                                    ? _selectedDepartmentId
                                    : null,
                                isExpanded: true,
                                hint: Text(
                                  'admin.employees.department'.tr(
                                    context: context,
                                  ),
                                ),
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: AppColors.fieldBackground,
                                ),
                                items: departments
                                    .map(
                                      (d) => DropdownMenuItem<int>(
                                        value: d.id,
                                        child: Text(d.departmentName ?? '-'),
                                      ),
                                    )
                                    .toList(),
                                onChanged: (val) =>
                                    setState(() => _selectedDepartmentId = val),
                              ),
                            ],
                          );
                        },
                      ),
                      hSpace(12),

                      // Branch Dropdown
                      BlocBuilder<AdminBranchesCubit, AdminBranchesState>(
                        builder: (context, branchState) {
                          final rawBranches = switch (branchState) {
                            AdminBranchesSuccess(:final branches) => branches,
                            _ => const <BranchModel>[],
                          };
                          final branches = <BranchModel>[];
                          final seenIds = <int>{};
                          for (final b in rawBranches) {
                            if (b.id != null && seenIds.add(b.id!)) {
                              branches.add(b);
                            }
                          }
                          final hasSelected = branches.any(
                            (b) => b.id == _selectedBranchId,
                          );
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'admin.employees.branch'.tr(context: context),
                                style: AppTextStyles.font12Medium,
                              ),
                              hSpace(6),
                              DropdownButtonFormField<int>(
                                key: ValueKey(
                                  'branch_${hasSelected ? _selectedBranchId : 'none'}',
                                ),
                                initialValue: hasSelected
                                    ? _selectedBranchId
                                    : null,
                                isExpanded: true,
                                hint: Text(
                                  'admin.employees.branch'.tr(context: context),
                                ),
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: AppColors.fieldBackground,
                                ),
                                items: branches
                                    .map(
                                      (b) => DropdownMenuItem<int>(
                                        value: b.id,
                                        child: Text(b.name ?? '-'),
                                      ),
                                    )
                                    .toList(),
                                onChanged: (val) =>
                                    setState(() => _selectedBranchId = val),
                              ),
                            ],
                          );
                        },
                      ),
                      hSpace(12),

                      // Direct Manager Dropdown
                      BlocBuilder<AdminEmployeesCubit, AdminEmployeesState>(
                        builder: (context, empState) {
                          final employees = context
                              .read<AdminEmployeesCubit>()
                              .employees;
                          final validEmployees = employees
                              .where(
                                (e) =>
                                    e.id != null && e.id != widget.employee.id,
                              )
                              .toList();
                          final hasSelected = validEmployees.any(
                            (e) => e.id == _selectedDirectManagerId,
                          );
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'admin.employees.directManager'.tr(
                                  context: context,
                                ),
                                style: AppTextStyles.font12Medium,
                              ),
                              hSpace(6),
                              DropdownButtonFormField<String?>(
                                key: ValueKey(
                                  'manager_${hasSelected ? _selectedDirectManagerId : 'none'}',
                                ),
                                initialValue: hasSelected
                                    ? _selectedDirectManagerId
                                    : null,
                                isExpanded: true,
                                hint: Text(
                                  'admin.employeeWizard.selectDirectManager'.tr(
                                    context: context,
                                  ),
                                ),
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: AppColors.fieldBackground,
                                ),
                                items: [
                                  DropdownMenuItem<String?>(
                                    value: null,
                                    child: Text(
                                      'admin.employeeWizard.noDirectManager'.tr(
                                        context: context,
                                      ),
                                    ),
                                  ),
                                  ...validEmployees.map(
                                    (e) => DropdownMenuItem<String?>(
                                      value: e.id,
                                      child: Text(
                                        '${e.name ?? e.userName ?? '-'} (${e.role ?? 'Employee'})',
                                      ),
                                    ),
                                  ),
                                ],
                                onChanged: (val) => setState(
                                  () => _selectedDirectManagerId = val,
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                      hSpace(12),

                      // Leave Balance
                      Text(
                        'admin.employees.leaveBalance'.tr(context: context),
                        style: AppTextStyles.font12Medium,
                      ),
                      hSpace(6),
                      CustomTextFormField(
                        controller: _leaveBalanceController,
                        hintText: '21',
                        keyboardType: TextInputType.number,
                      ),

                      hSpace(8),
                      Center(
                        child: TextButton(
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              AppRoutes.adminEmployeeAudit,
                              arguments: widget.employee.id,
                            );
                          },
                          child: Text(
                            'admin.employees.activityLog'.tr(context: context),
                            style: AppTextStyles.font14Medium.copyWith(
                              color: AppColors.brandPrimary,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ),
                      hSpace(12),

                      // Action Buttons
                      Row(
                        children: [
                          Expanded(
                            child: CustomButton(
                              text: 'admin.locations.create.cancel'.tr(
                                context: context,
                              ),
                              onTap: () => Navigator.pop(context),
                              backgroundColor: AppColors.pageBackground,
                              textColor: AppColors.textPrimary,
                            ),
                          ),
                          vSpace(12),
                          Expanded(
                            child: CustomButton(
                              text: 'admin.locations.create.save'.tr(
                                context: context,
                              ),
                              onTap: _handleSave,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );

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
      color: AppColors.softBrandBackground,
      child: Icon(
        Icons.person_rounded,
        size: 48.r,
        color: AppColors.placeholder,
      ),
    );
  }
}
