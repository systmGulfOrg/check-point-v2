import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/admin/data/models/employee/edit_employee_request_body.dart';
import 'package:check_point_v2/features/admin/data/models/employee/employee_model.dart';
import 'package:check_point_v2/features/admin/data/models/locations/branch_response_model.dart';
import 'package:check_point_v2/features/admin/data/models/locations/department_response_model.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/employee/admin_employees_cubit.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/employee/admin_employees_state.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/locations/admin_branches_cubit.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/locations/admin_branches_state.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/locations/admin_departments_cubit.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/locations/admin_departments_state.dart';
import 'package:check_point_v2/features/admin/presentation/widgets/admin_employee_work_system_widget.dart';

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
  late final TextEditingController _passwordController;
  late final TextEditingController _positionController;
  late final TextEditingController _mobileIdController;
  late final TextEditingController _phoneController;
  late final TextEditingController _emailController;
  late final TextEditingController _employeeCodeController;
  late final TextEditingController _leaveBalanceController;

  late final Set<String> _selectedRoles;
  int? _selectedDepartmentId;
  int? _selectedBranchId;
  late String _selectedWorkSystem;
  String? _selectedRemoteWorkPolicyId;
  late bool _canAddAttendance;
  late bool _canAddPlan;

  static const List<String> _availableRoles = [
    'HR',
    'Supervisor',
    'Contractor',
  ];

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.employee.name ?? '');
    _userNameController = TextEditingController(
      text: widget.employee.userName ?? '',
    );
    _passwordController = TextEditingController();
    _positionController = TextEditingController(
      text: widget.employee.position ?? '',
    );
    _mobileIdController = TextEditingController(
      text: widget.employee.mobileId ?? '',
    );
    _phoneController = TextEditingController(text: widget.employee.phone ?? '');
    _emailController = TextEditingController(text: widget.employee.email ?? '');
    _employeeCodeController = TextEditingController(
      text: (widget.employee.employeeCode != null &&
              widget.employee.employeeCode!.isNotEmpty)
          ? widget.employee.employeeCode!
          : CodeGeneratorHelper.generateEmployeeCode(),
    );
    _leaveBalanceController = TextEditingController(
      text: '${widget.employee.leaveBalance ?? 21}',
    );

    _selectedRoles = widget.employee.allRoles
        .map((role) => role.toLowerCase() == 'employee' ? 'Contractor' : role)
        .where(
          (role) => const {'HR', 'Supervisor', 'Contractor'}.contains(role),
        )
        .toSet();
    if (_selectedRoles.isEmpty) _selectedRoles.add('Contractor');

    _selectedDepartmentId = widget.employee.departmentId;
    _selectedBranchId = widget.employee.branchId;
    _selectedDirectManagerId = widget.employee.resolvedDirectManagerId;
    _selectedWorkSystem = widget.employee.workSystem ?? 'onsite';
    _selectedRemoteWorkPolicyId = widget.employee.remoteWorkPolicyId;
    _canAddAttendance = widget.employee.canAddAttendance ?? true;
    _canAddPlan = widget.employee.canAddPlan ?? true;
  }

  String? _selectedDirectManagerId;

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

  void _handleSave() {
    if (_nameController.text.trim().isEmpty) return;
    if (_selectedWorkSystem != 'onsite' &&
        _selectedRemoteWorkPolicyId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'admin.employeeWizard.workPolicyRequired'.tr(context: context),
          ),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }

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
        role: _selectedRoles.contains('HR')
            ? 'HR'
            : _selectedRoles.contains('Supervisor')
            ? 'Supervisor'
            : 'Employee',
        roles: _selectedRoles
            .map((r) => r == 'Contractor' ? 'Employee' : r)
            .toList(),
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
            hSpace(6),
            CustomTextFormField(
              controller: _nameController,
              hintText: 'admin.employees.fullName'.tr(context: context),
            ),
            hSpace(12),
            Text(
              'admin.employees.username'.tr(context: context),
              style: AppTextStyles.font12Medium,
            ),
            hSpace(6),
            CustomTextFormField(
              controller: _userNameController,
              hintText: 'admin.employees.username'.tr(context: context),
            ),
            hSpace(12),
            Text(
              'admin.employees.passwordOptional'.tr(context: context),
              style: AppTextStyles.font12Medium,
            ),
            hSpace(6),
            CustomTextFormField(
              controller: _passwordController,
              hintText: '••••••••',
              obscureText: true,
            ),
            hSpace(12),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'admin.employees.position'.tr(context: context),
                        style: AppTextStyles.font12Medium,
                      ),
                      hSpace(6),
                      CustomTextFormField(
                        controller: _positionController,
                        hintText: 'admin.employees.position'.tr(
                          context: context,
                        ),
                      ),
                    ],
                  ),
                ),
                vSpace(10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'admin.employees.employeeCode'.tr(context: context),
                        style: AppTextStyles.font12Medium,
                      ),
                      hSpace(6),
                      CustomTextFormField(
                        controller: _employeeCodeController,
                        hintText: 'EMP-23211',
                        suffixIcon: IconButton(
                          icon: const Icon(
                            Icons.refresh_rounded,
                            color: AppColors.brandPrimary,
                          ),
                          onPressed: () {
                            setState(() {
                              _employeeCodeController.text =
                                  CodeGeneratorHelper.generateEmployeeCode();
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            hSpace(12),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'admin.employees.phone'.tr(context: context),
                        style: AppTextStyles.font12Medium,
                      ),
                      hSpace(6),
                      CustomTextFormField(
                        controller: _phoneController,
                        hintText: '05xxxxxxxx',
                      ),
                    ],
                  ),
                ),
                vSpace(10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'admin.employees.email'.tr(context: context),
                        style: AppTextStyles.font12Medium,
                      ),
                      hSpace(6),
                      CustomTextFormField(
                        controller: _emailController,
                        hintText: 'name@company.com',
                      ),
                    ],
                  ),
                ),
              ],
            ),
            hSpace(12),
            Text(
              'admin.employees.mobileId'.tr(context: context),
              style: AppTextStyles.font12Medium,
            ),
            hSpace(6),
            CustomTextFormField(
              controller: _mobileIdController,
              hintText: 'admin.employees.mobileId'.tr(context: context),
              readOnly: true,
              suffixIcon: IconButton(
                icon: const Icon(
                  Icons.copy_rounded,
                  color: AppColors.brandPrimary,
                ),
                onPressed: () {
                  if (_mobileIdController.text.isNotEmpty) {
                    Clipboard.setData(
                      ClipboardData(text: _mobileIdController.text),
                    );
                    CustomSnackBar.showSuccess(
                      context,
                      message:
                          'admin.requests.copiedMobileId'.tr(context: context),
                    );
                  }
                },
              ),
            ),
            hSpace(14),
            Text(
              'admin.employeeWizard.role'.tr(context: context),
              style: AppTextStyles.font12Medium,
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
                      'HR' => 'admin.roles.hr'.tr(context: context),
                      'Supervisor' => 'admin.roles.supervisor'.tr(
                        context: context,
                      ),
                      'Contractor' => 'admin.roles.contractor'.tr(
                        context: context,
                      ),
                      _ => role,
                    },
                    style: AppTextStyles.font12Medium.copyWith(
                      color: isSelected ? AppColors.white : AppColors.brandInk,
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
                        _selectedRoles.remove(role);
                      }
                    });
                  },
                );
              }).toList(),
            ),
            hSpace(14),
            BlocBuilder<AdminDepartmentsCubit, AdminDepartmentsState>(
              builder: (context, deptState) {
                final rawDepartments = switch (deptState) {
                  AdminDepartmentsSuccess(:final departments) => departments,
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
                      'admin.employees.department'.tr(context: context),
                      style: AppTextStyles.font12Medium,
                    ),
                    hSpace(6),
                    DropdownButtonFormField<int>(
                      key: ValueKey(
                        'dept_${hasSelected ? _selectedDepartmentId : 'none'}',
                      ),
                      initialValue: hasSelected ? _selectedDepartmentId : null,
                      isExpanded: true,
                      hint: Text(
                        'admin.employees.department'.tr(context: context),
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
                      initialValue: hasSelected ? _selectedBranchId : null,
                      isExpanded: true,
                      hint: Text('admin.employees.branch'.tr(context: context)),
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
            BlocBuilder<AdminEmployeesCubit, AdminEmployeesState>(
              builder: (context, empState) {
                final employees = context.read<AdminEmployeesCubit>().employees;
                final validEmployees = employees
                    .where((e) => e.id != null && e.id != widget.employee.id)
                    .toList();
                final hasSelected = validEmployees.any(
                  (e) => e.id == _selectedDirectManagerId,
                );
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'admin.employees.directManager'.tr(context: context),
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
                      onChanged: (val) =>
                          setState(() => _selectedDirectManagerId = val),
                    ),
                  ],
                );
              },
            ),
            hSpace(12),
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
            hSpace(14),
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
