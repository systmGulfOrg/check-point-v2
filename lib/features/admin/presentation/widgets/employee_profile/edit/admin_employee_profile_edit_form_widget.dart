import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/admin/data/models/employee/edit_employee_request_body.dart';
import 'package:check_point_v2/features/admin/data/models/employee/employee_model.dart';
import 'admin_employee_edit_account_card_widget.dart';
import 'admin_employee_edit_emergency_card_widget.dart';
import 'admin_employee_edit_job_card_widget.dart';
import 'admin_employee_edit_payroll_card_widget.dart';
import 'admin_employee_edit_personal_card_widget.dart';

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

  // Job Controllers
  late final TextEditingController _positionController;
  late final TextEditingController _employeeCodeController;
  late final TextEditingController _gradeController;
  late final TextEditingController _divisionController;
  late final TextEditingController _contractTypeController;
  late final TextEditingController _contractStatusController;
  int? _selectedDepartmentId;
  int? _selectedBranchId;
  late final Set<int> _selectedBranchIds;
  late final Set<String> _selectedSiteIds;
  String _selectedLocationType = 'branch';
  String? _selectedSiteId;
  late String _selectedWorkSystem;
  String? _selectedDirectManagerId;
  DateTime? _joinDate;
  DateTime? _contractEndDate;

  // Personal Controllers
  late final TextEditingController _nameArController;
  late final TextEditingController _nameEnController;
  late final TextEditingController _emailController;
  late final TextEditingController _personalEmailController;
  late final TextEditingController _phoneController;
  late final TextEditingController _secondaryPhoneController;
  late final TextEditingController _nationalIdController;
  late final TextEditingController _passportNumberController;
  late final TextEditingController _addressController;
  late final TextEditingController _cityController;
  String? _selectedGender;
  String? _selectedMaritalStatus;
  DateTime? _idExpiryDate;
  DateTime? _birthDate;

  // Emergency Controllers
  late final TextEditingController _emergencyNameController;
  late final TextEditingController _emergencyRelationController;
  late final TextEditingController _emergencyPhoneController;

  // Payroll Controllers
  late final TextEditingController _basicSalaryController;
  late final TextEditingController _allowancesController;
  late final TextEditingController _currencyController;
  late final TextEditingController _bankNameController;
  late final TextEditingController _bankAccountNumberController;
  late final TextEditingController _ibanController;
  late final TextEditingController _socialInsuranceNumberController;

  // Account Controllers
  late final TextEditingController _userNameController;
  late final TextEditingController _passwordController;
  late final TextEditingController _leaveBalanceController;
  late final Set<String> _selectedRoles;
  late bool _canAddAttendance;
  late bool _canAddPlan;

  @override
  void initState() {
    super.initState();
    final emp = widget.employee;

    // Job
    _positionController = TextEditingController(text: emp.position ?? '');
    _employeeCodeController = TextEditingController(
      text: emp.employeeCode ?? '',
    );
    _gradeController = TextEditingController(text: emp.grade ?? '');
    _divisionController = TextEditingController(text: emp.division ?? '');
    _contractTypeController = TextEditingController(
      text: emp.contractType ?? '',
    );
    _contractStatusController = TextEditingController(
      text: emp.contractStatus ?? '',
    );
    _selectedDepartmentId = emp.departmentId;
    _selectedBranchIds = {
      ...?emp.assignedBranchIds,
      if (emp.branchId != null) emp.branchId!,
    };
    _selectedSiteIds = {...?emp.assignedSiteIds};
    final employeeLocationType = emp.attendanceLocationType?.toLowerCase();
    _selectedLocationType =
        employeeLocationType == 'site' ||
            (employeeLocationType == null &&
                _selectedSiteIds.isNotEmpty &&
                _selectedBranchIds.isEmpty)
        ? 'site'
        : 'branch';
    _selectedBranchId =
        emp.branchId ??
        (_selectedBranchIds.isEmpty ? null : _selectedBranchIds.first);
    _selectedSiteId = _selectedSiteIds.isEmpty ? null : _selectedSiteIds.first;
    _selectedWorkSystem = emp.workSystem ?? 'onsite';
    _selectedDirectManagerId = emp.resolvedDirectManagerId;
    _joinDate = _parseDate(emp.joinDate ?? emp.hireDate);
    _contractEndDate = _parseDate(emp.contractEndDate);

    // Personal
    _nameArController = TextEditingController(text: emp.nameAr ?? '');
    _nameEnController = TextEditingController(
      text: emp.nameEn ?? emp.name ?? '',
    );
    _emailController = TextEditingController(text: emp.email ?? '');
    _personalEmailController = TextEditingController(
      text: emp.personalEmail ?? '',
    );
    _phoneController = TextEditingController(text: emp.phone ?? '');
    _secondaryPhoneController = TextEditingController(
      text: emp.secondaryPhone ?? '',
    );
    _nationalIdController = TextEditingController(text: emp.nationalId ?? '');
    _passportNumberController = TextEditingController(
      text: emp.passportNumber ?? '',
    );
    _addressController = TextEditingController(text: emp.address ?? '');
    _cityController = TextEditingController(text: emp.city ?? '');
    _selectedGender = emp.gender?.toLowerCase() == 'female' ? 'female' : 'male';
    _selectedMaritalStatus = emp.maritalStatus?.toLowerCase() == 'married'
        ? 'married'
        : 'single';
    _idExpiryDate = _parseDate(emp.idExpiryDate);
    _birthDate = _parseDate(emp.birthDate);

    // Emergency
    _emergencyNameController = TextEditingController(
      text: emp.emergencyContactName ?? '',
    );
    _emergencyRelationController = TextEditingController(
      text: emp.emergencyContactRelation ?? '',
    );
    _emergencyPhoneController = TextEditingController(
      text: emp.emergencyContactPhone ?? '',
    );

    // Payroll
    _basicSalaryController = TextEditingController(
      text: emp.basicSalary != null ? '${emp.basicSalary}' : '',
    );
    _allowancesController = TextEditingController(
      text: emp.allowances != null ? '${emp.allowances}' : '',
    );
    _currencyController = TextEditingController(text: emp.currency ?? 'EGP');
    _bankNameController = TextEditingController(text: emp.bankName ?? '');
    _bankAccountNumberController = TextEditingController(
      text: emp.bankAccountNumber ?? '',
    );
    _ibanController = TextEditingController(text: emp.iban ?? '');
    _socialInsuranceNumberController = TextEditingController(
      text: emp.socialInsuranceNumber ?? '',
    );

    // Account
    _userNameController = TextEditingController(text: emp.userName ?? '');
    _passwordController = TextEditingController();
    _leaveBalanceController = TextEditingController(
      text: '${emp.leaveBalance ?? 21}',
    );
    _selectedRoles = emp.allRoles
        .where(
          (role) => const {'HR', 'Supervisor', 'Contractor'}.contains(role),
        )
        .take(1)
        .toSet();
    if (_selectedRoles.isEmpty) _selectedRoles.add('Contractor');
    _canAddAttendance = emp.canAddAttendance ?? true;
    _canAddPlan = emp.canAddPlan ?? true;
  }

  static DateTime? _parseDate(String? raw) {
    if (raw == null || raw.trim().isEmpty) return null;
    return DateTime.tryParse(raw);
  }

  @override
  void dispose() {
    _positionController.dispose();
    _employeeCodeController.dispose();
    _gradeController.dispose();
    _divisionController.dispose();
    _contractTypeController.dispose();
    _contractStatusController.dispose();
    _nameArController.dispose();
    _nameEnController.dispose();
    _emailController.dispose();
    _personalEmailController.dispose();
    _phoneController.dispose();
    _secondaryPhoneController.dispose();
    _nationalIdController.dispose();
    _passportNumberController.dispose();
    _addressController.dispose();
    _cityController.dispose();
    _emergencyNameController.dispose();
    _emergencyRelationController.dispose();
    _emergencyPhoneController.dispose();
    _basicSalaryController.dispose();
    _allowancesController.dispose();
    _currencyController.dispose();
    _bankNameController.dispose();
    _bankAccountNumberController.dispose();
    _ibanController.dispose();
    _socialInsuranceNumberController.dispose();
    _userNameController.dispose();
    _passwordController.dispose();
    _leaveBalanceController.dispose();
    super.dispose();
  }

  Future<void> _pickDate({
    required BuildContext context,
    required DateTime? initial,
    required ValueChanged<DateTime> onPicked,
  }) async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: initial ?? now,
      firstDate: DateTime(1950),
      lastDate: DateTime(2050),
    );
    if (picked != null) {
      onPicked(picked);
    }
  }

  Future<void> _handleSubmit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isSaving = true);
    try {
      final body = EditEmployeeRequestBody(
        name: _nameEnController.text.trim().isNotEmpty
            ? _nameEnController.text.trim()
            : widget.employee.name,
        nameAr: _nameArController.text.trim().isNotEmpty
            ? _nameArController.text.trim()
            : null,
        nameEn: _nameEnController.text.trim().isNotEmpty
            ? _nameEnController.text.trim()
            : null,
        userName: _userNameController.text.trim().isNotEmpty
            ? _userNameController.text.trim()
            : null,
        password: _passwordController.text.isNotEmpty
            ? _passwordController.text
            : null,
        position: _positionController.text.trim().isNotEmpty
            ? _positionController.text.trim()
            : null,
        employeeCode: _employeeCodeController.text.trim().isNotEmpty
            ? _employeeCodeController.text.trim()
            : null,
        grade: _gradeController.text.trim().isNotEmpty
            ? _gradeController.text.trim()
            : null,
        departmentId: _selectedDepartmentId,
        division: _divisionController.text.trim().isNotEmpty
            ? _divisionController.text.trim()
            : null,
        branchId: _selectedBranchId,
        siteId: _selectedLocationType == 'site' ? _selectedSiteId : null,
        attendanceLocationType: _selectedLocationType,
        branchIds: _selectedLocationType == 'branch'
            ? _selectedBranchIds.toList()
            : const [],
        siteIds: _selectedLocationType == 'site'
            ? _selectedSiteIds.toList()
            : const [],
        workSystem: _selectedWorkSystem,
        directManagerId: _selectedDirectManagerId,
        managerId: _selectedDirectManagerId,
        contractType: _contractTypeController.text.trim().isNotEmpty
            ? _contractTypeController.text.trim()
            : null,
        contractStatus: _contractStatusController.text.trim().isNotEmpty
            ? _contractStatusController.text.trim()
            : null,
        joinDate: _joinDate?.toIso8601String(),
        hireDate: _joinDate?.toIso8601String(),
        contractEndDate: _contractEndDate?.toIso8601String(),
        email: _emailController.text.trim().isNotEmpty
            ? _emailController.text.trim()
            : null,
        personalEmail: _personalEmailController.text.trim().isNotEmpty
            ? _personalEmailController.text.trim()
            : null,
        phone: _phoneController.text.trim().isNotEmpty
            ? _phoneController.text.trim()
            : null,
        secondaryPhone: _secondaryPhoneController.text.trim().isNotEmpty
            ? _secondaryPhoneController.text.trim()
            : null,
        nationalId: _nationalIdController.text.trim().isNotEmpty
            ? _nationalIdController.text.trim()
            : null,
        passportNumber: _passportNumberController.text.trim().isNotEmpty
            ? _passportNumberController.text.trim()
            : null,
        idExpiryDate: _idExpiryDate?.toIso8601String(),
        birthDate: _birthDate?.toIso8601String(),
        gender: _selectedGender,
        maritalStatus: _selectedMaritalStatus,
        address: _addressController.text.trim().isNotEmpty
            ? _addressController.text.trim()
            : null,
        city: _cityController.text.trim().isNotEmpty
            ? _cityController.text.trim()
            : null,
        emergencyContactName: _emergencyNameController.text.trim().isNotEmpty
            ? _emergencyNameController.text.trim()
            : null,
        emergencyContactRelation:
            _emergencyRelationController.text.trim().isNotEmpty
            ? _emergencyRelationController.text.trim()
            : null,
        emergencyContactPhone: _emergencyPhoneController.text.trim().isNotEmpty
            ? _emergencyPhoneController.text.trim()
            : null,
        basicSalary: num.tryParse(_basicSalaryController.text.trim()),
        allowances: num.tryParse(_allowancesController.text.trim()),
        currency: _currencyController.text.trim().isNotEmpty
            ? _currencyController.text.trim()
            : 'EGP',
        bankName: _bankNameController.text.trim().isNotEmpty
            ? _bankNameController.text.trim()
            : null,
        bankAccountNumber: _bankAccountNumberController.text.trim().isNotEmpty
            ? _bankAccountNumberController.text.trim()
            : null,
        iban: _ibanController.text.trim().isNotEmpty
            ? _ibanController.text.trim()
            : null,
        socialInsuranceNumber:
            _socialInsuranceNumberController.text.trim().isNotEmpty
            ? _socialInsuranceNumberController.text.trim()
            : null,
        role: _selectedRoles.contains('HR')
            ? 'HR'
            : _selectedRoles.contains('Supervisor')
            ? 'Supervisor'
            : 'Contractor',
        roles: _selectedRoles.toList(),
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
          AdminEmployeeEditJobCardWidget(
            positionController: _positionController,
            employeeCodeController: _employeeCodeController,
            gradeController: _gradeController,
            divisionController: _divisionController,
            contractTypeController: _contractTypeController,
            contractStatusController: _contractStatusController,
            selectedDepartmentId: _selectedDepartmentId,
            selectedBranchId: _selectedBranchId,
            selectedBranchIds: _selectedBranchIds,
            selectedSiteIds: _selectedSiteIds,
            selectedLocationType: _selectedLocationType,
            selectedSiteId: _selectedSiteId,
            selectedWorkSystem: _selectedWorkSystem,
            selectedDirectManagerId: _selectedDirectManagerId,
            joinDate: _joinDate,
            contractEndDate: _contractEndDate,
            onDepartmentChanged: (val) => setState(() {
              _selectedDepartmentId = val;
            }),
            onBranchChanged: (val) => setState(() {
              _selectedBranchId = val;
              if (val != null) _selectedBranchIds.add(val);
            }),
            onBranchIdsChanged: (values) => setState(() {
              _selectedBranchIds
                ..clear()
                ..addAll(values);
              _selectedBranchId = values.isEmpty ? null : values.first;
            }),
            onSiteIdsChanged: (values) => setState(() {
              _selectedSiteIds
                ..clear()
                ..addAll(values);
              _selectedSiteId = values.isEmpty ? null : values.first;
            }),
            onLocationTypeChanged: (val) => setState(() {
              _selectedLocationType = val;
              if (val == 'site') {
                _selectedBranchId = null;
                _selectedBranchIds.clear();
              }
              if (val == 'branch') {
                _selectedSiteId = null;
                _selectedSiteIds.clear();
              }
            }),
            onSiteChanged: (val) => setState(() => _selectedSiteId = val),
            onWorkSystemChanged: (val) =>
                setState(() => _selectedWorkSystem = val),
            onManagerChanged: (val) =>
                setState(() => _selectedDirectManagerId = val),
            onSelectJoinDate: () => _pickDate(
              context: context,
              initial: _joinDate,
              onPicked: (d) => setState(() => _joinDate = d),
            ),
            onSelectContractEndDate: () => _pickDate(
              context: context,
              initial: _contractEndDate,
              onPicked: (d) => setState(() => _contractEndDate = d),
            ),
          ),
          hSpace(16),
          AdminEmployeeEditPersonalCardWidget(
            nameArController: _nameArController,
            nameEnController: _nameEnController,
            emailController: _emailController,
            personalEmailController: _personalEmailController,
            phoneController: _phoneController,
            secondaryPhoneController: _secondaryPhoneController,
            nationalIdController: _nationalIdController,
            passportNumberController: _passportNumberController,
            addressController: _addressController,
            cityController: _cityController,
            selectedGender: _selectedGender,
            selectedMaritalStatus: _selectedMaritalStatus,
            idExpiryDate: _idExpiryDate,
            birthDate: _birthDate,
            onGenderChanged: (val) => setState(() => _selectedGender = val),
            onMaritalStatusChanged: (val) =>
                setState(() => _selectedMaritalStatus = val),
            onSelectIdExpiryDate: () => _pickDate(
              context: context,
              initial: _idExpiryDate,
              onPicked: (d) => setState(() => _idExpiryDate = d),
            ),
            onSelectBirthDate: () => _pickDate(
              context: context,
              initial: _birthDate,
              onPicked: (d) => setState(() => _birthDate = d),
            ),
          ),
          hSpace(16),
          AdminEmployeeEditEmergencyCardWidget(
            emergencyNameController: _emergencyNameController,
            emergencyRelationController: _emergencyRelationController,
            emergencyPhoneController: _emergencyPhoneController,
          ),
          hSpace(16),
          AdminEmployeeEditPayrollCardWidget(
            basicSalaryController: _basicSalaryController,
            allowancesController: _allowancesController,
            currencyController: _currencyController,
            bankNameController: _bankNameController,
            bankAccountNumberController: _bankAccountNumberController,
            ibanController: _ibanController,
            socialInsuranceNumberController: _socialInsuranceNumberController,
          ),
          hSpace(16),
          AdminEmployeeEditAccountCardWidget(
            userNameController: _userNameController,
            passwordController: _passwordController,
            leaveBalanceController: _leaveBalanceController,
            selectedRoles: _selectedRoles,
            canAddAttendance: _canAddAttendance,
            canAddPlan: _canAddPlan,
            onRoleToggled: (role) {
              setState(() {
                _selectedRoles
                  ..clear()
                  ..add(role);
              });
            },
            onCanAddAttendanceChanged: (val) =>
                setState(() => _canAddAttendance = val),
            onCanAddPlanChanged: (val) => setState(() => _canAddPlan = val),
          ),
          hSpace(20),
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
}
