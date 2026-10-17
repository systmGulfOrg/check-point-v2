import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/core/di/service_locator.dart';
import 'package:check_point_v2/features/admin/data/models/account_requests/account_requests_response_model.dart';
import 'package:check_point_v2/features/admin/data/models/account_requests/approve_account_request_body.dart';
import 'package:check_point_v2/features/admin/data/models/employee/add_employee_request_body.dart';
import 'package:check_point_v2/features/admin/data/repos/admin_permissions_repo.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/account_requests/admin_account_requests_cubit.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/employee/admin_employees_cubit.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/locations/admin_branches_cubit.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/locations/admin_branches_state.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/locations/admin_departments_cubit.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/locations/admin_departments_state.dart';
import 'package:check_point_v2/features/admin/presentation/widgets/admin_permissions_picker_dialog_widget.dart';
import 'package:check_point_v2/features/admin/presentation/widgets/admin_wizard_stepper_widget.dart';
import 'package:check_point_v2/features/admin/presentation/widgets/employee_wizard/admin_create_employee_organization_step_widget.dart';
import 'package:check_point_v2/features/admin/presentation/widgets/employee_wizard/admin_create_employee_personal_step_widget.dart';
import 'package:check_point_v2/features/admin/presentation/widgets/employee_wizard/admin_create_employee_review_step_widget.dart';
import 'package:check_point_v2/features/admin/presentation/widgets/employee_wizard/admin_create_employee_work_step_widget.dart';
import 'package:check_point_v2/features/remote_work/presentation/cubit/remote_work_cubit.dart';

class AdminCreateEmployeeScreen extends StatefulWidget {
  const AdminCreateEmployeeScreen({this.accountRequest, super.key});

  final AccountRequestModel? accountRequest;

  @override
  State<AdminCreateEmployeeScreen> createState() =>
      _AdminCreateEmployeeScreenState();
}

class _AdminCreateEmployeeScreenState extends State<AdminCreateEmployeeScreen> {
  final formKey = GlobalKey<FormState>();
  late final TextEditingController nameController;
  late final TextEditingController usernameController;
  late final TextEditingController passwordController;
  late final TextEditingController mobileController;
  late final TextEditingController phoneController;
  late final TextEditingController emailController;
  late final TextEditingController employeeCodeController;
  late final TextEditingController positionController;

  late final FocusNode nameFocusNode;
  late final FocusNode usernameFocusNode;
  late final FocusNode passwordFocusNode;
  late final FocusNode phoneFocusNode;
  late final FocusNode emailFocusNode;
  late final FocusNode positionFocusNode;

  String? nameErrorText;
  String? usernameErrorText;
  String? passwordErrorText;
  String? phoneErrorText;
  String? emailErrorText;
  String? positionErrorText;

  int currentStep = 0;
  final Set<String> selectedRoles = {'Employee'};
  final Set<String> selectedPermissions = {};
  int? selectedDepartmentId;
  int? selectedBranchId;
  String? selectedDirectManagerId;
  bool isSaving = false;
  bool isCreated = false;
  String? saveErrorMessage;
  String selectedWorkSystem = 'onsite';
  String? selectedRemoteWorkPolicyId;
  String? selectedPhotoPath;

  static const List<String> availableRoles = [
    'Employee',
    'Supervisor',
    'Admin',
  ];

  @override
  void initState() {
    super.initState();
    context.read<AdminEmployeesCubit>().loadEmployees();

    nameFocusNode = FocusNode();
    usernameFocusNode = FocusNode();
    passwordFocusNode = FocusNode();
    phoneFocusNode = FocusNode();
    emailFocusNode = FocusNode();
    positionFocusNode = FocusNode();

    final req = widget.accountRequest;
    nameController = TextEditingController(text: req?.name);
    usernameController = TextEditingController(
      text: req?.name != null
          ? req!.name!.trim().toLowerCase().replaceAll(RegExp(r'\s+'), '.')
          : '',
    );
    passwordController = TextEditingController(text: 'Systm123!');
    mobileController = TextEditingController(
      text: req?.mobileId ?? sl<DeviceIdentityProvider>().mobileId,
    );
    phoneController = TextEditingController(text: req?.phone);
    emailController = TextEditingController();

    final randomDigits = 1000 + Random().nextInt(9000);
    employeeCodeController = TextEditingController(text: 'EMP-$randomDigits');
    positionController = TextEditingController();
    selectedPhotoPath = req?.photo;
  }

  @override
  void dispose() {
    nameFocusNode.dispose();
    usernameFocusNode.dispose();
    passwordFocusNode.dispose();
    phoneFocusNode.dispose();
    emailFocusNode.dispose();
    positionFocusNode.dispose();

    nameController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    mobileController.dispose();
    phoneController.dispose();
    emailController.dispose();
    employeeCodeController.dispose();
    positionController.dispose();
    super.dispose();
  }

  void _navigateToErrorField(String? rawError) {
    if (rawError == null || rawError.isEmpty) return;
    final lower = rawError.toLowerCase();

    if (lower.contains('password') ||
        lower.contains('كلمة المرور') ||
        lower.contains('كلمه المرور') ||
        lower.contains('باسورد') ||
        rawError == 'errors.passwordPolicy') {
      setState(() {
        currentStep = 0;
        passwordErrorText = rawError.tr(context: context);
        saveErrorMessage = null;
      });
      WidgetsBinding.instance.addPostFrameCallback((_) {
        passwordFocusNode.requestFocus();
      });
      return;
    }

    if (lower.contains('user') ||
        lower.contains('اسم المستخدم') ||
        rawError == 'errors.usernameExists') {
      setState(() {
        currentStep = 0;
        usernameErrorText = rawError.tr(context: context);
        saveErrorMessage = null;
      });
      WidgetsBinding.instance.addPostFrameCallback((_) {
        usernameFocusNode.requestFocus();
      });
      return;
    }

    if (lower.contains('email') ||
        lower.contains('بريد') ||
        rawError == 'errors.emailExists') {
      setState(() {
        currentStep = 0;
        emailErrorText = rawError.tr(context: context);
        saveErrorMessage = null;
      });
      WidgetsBinding.instance.addPostFrameCallback((_) {
        emailFocusNode.requestFocus();
      });
      return;
    }

    if (lower.contains('phone') ||
        lower.contains('mobile') ||
        lower.contains('هاتف') ||
        lower.contains('موبايل') ||
        lower.contains('جوال')) {
      setState(() {
        currentStep = 0;
        phoneErrorText = rawError.tr(context: context);
        saveErrorMessage = null;
      });
      WidgetsBinding.instance.addPostFrameCallback((_) {
        phoneFocusNode.requestFocus();
      });
      return;
    }

    if (lower.contains('name') || lower.contains('الاسم')) {
      setState(() {
        currentStep = 0;
        nameErrorText = rawError.tr(context: context);
        saveErrorMessage = null;
      });
      WidgetsBinding.instance.addPostFrameCallback((_) {
        nameFocusNode.requestFocus();
      });
      return;
    }

    if (lower.contains('position') ||
        lower.contains('مسمى') ||
        lower.contains('وظيفة')) {
      setState(() {
        currentStep = 1;
        positionErrorText = rawError.tr(context: context);
        saveErrorMessage = null;
      });
      WidgetsBinding.instance.addPostFrameCallback((_) {
        positionFocusNode.requestFocus();
      });
      return;
    }

    if (lower.contains('role') ||
        lower.contains('دور') ||
        lower.contains('صلاحية')) {
      setState(() {
        currentStep = 1;
        saveErrorMessage = rawError;
      });
      return;
    }

    if (lower.contains('department') ||
        lower.contains('branch') ||
        lower.contains('قسم') ||
        lower.contains('فرع')) {
      setState(() {
        currentStep = 2;
        saveErrorMessage = rawError;
      });
      return;
    }

    setState(() {
      saveErrorMessage = rawError;
    });
  }

  Future<void> _openPermissionsDialog() async {
    final permissionsRepo = sl<AdminPermissionsRepo>();
    final result = await permissionsRepo.getCatalogue();
    if (!mounted) return;
    await result.when(
      success: (catalogue) async {
        final updated = await AdminPermissionsPickerDialogWidget.show(
          context,
          catalogue: catalogue,
          initialSelectedPermissions: selectedPermissions,
        );
        if (mounted && updated != null) {
          setState(() {
            selectedPermissions
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

  bool _validateStep(int step) {
    if (step == 0) {
      final hasPhoto =
          selectedPhotoPath != null ||
          (widget.accountRequest?.photoPath != null &&
              widget.accountRequest!.photoPath!.isNotEmpty);
      if (!hasPhoto) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('validation.photoRequired'.tr(context: context)),
            backgroundColor: AppColors.error,
          ),
        );
        return false;
      }
      if (nameController.text.trim().isEmpty) {
        nameFocusNode.requestFocus();
        formKey.currentState?.validate();
        return false;
      }
      if (usernameController.text.trim().isEmpty) {
        usernameFocusNode.requestFocus();
        formKey.currentState?.validate();
        return false;
      }
      if (passwordController.text.length < 6) {
        passwordFocusNode.requestFocus();
        formKey.currentState?.validate();
        return false;
      }
      if (!(formKey.currentState?.validate() ?? false)) {
        return false;
      }
    }
    if (step == 1) {
      if (positionController.text.trim().isEmpty) {
        positionFocusNode.requestFocus();
        formKey.currentState?.validate();
        return false;
      }
      if (!(formKey.currentState?.validate() ?? false)) {
        return false;
      }
      if (selectedRoles.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'admin.employeeWizard.rolesRequired'.tr(context: context),
            ),
            backgroundColor: AppColors.error,
          ),
        );
        return false;
      }
    }
    if (step == 2) {
      if (selectedDepartmentId == null || selectedBranchId == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'admin.employeeWizard.departmentBranchRequired'.tr(
                context: context,
              ),
            ),
            backgroundColor: AppColors.error,
          ),
        );
        return false;
      }
    }
    setState(() {
      saveErrorMessage = null;
      nameErrorText = null;
      usernameErrorText = null;
      passwordErrorText = null;
      phoneErrorText = null;
      emailErrorText = null;
      positionErrorText = null;
    });
    return true;
  }

  Future<void> _submitForm() async {
    if (selectedDepartmentId == null || selectedBranchId == null) {
      setState(() {
        saveErrorMessage = 'admin.employeeWizard.departmentBranchRequired';
        currentStep = 2;
      });
      return;
    }

    setState(() {
      isSaving = true;
      saveErrorMessage = null;
      nameErrorText = null;
      usernameErrorText = null;
      passwordErrorText = null;
      phoneErrorText = null;
      emailErrorText = null;
      positionErrorText = null;
    });

    final isFromRequest =
        widget.accountRequest != null && widget.accountRequest!.id != null;

    if (isFromRequest) {
      final approveBody = ApproveAccountRequestBody(
        userName: usernameController.text.trim(),
        password: passwordController.text.trim(),
        role: selectedRoles.first,
        roles: selectedRoles.toList(),
        departmentId: selectedDepartmentId,
        branchId: selectedBranchId,
        workSystem: selectedWorkSystem,
        remoteWorkPolicyId: selectedRemoteWorkPolicyId,
        position: positionController.text.trim(),
        employeeCode: employeeCodeController.text.trim().isNotEmpty
            ? employeeCodeController.text.trim()
            : null,
        email: emailController.text.trim().isNotEmpty
            ? emailController.text.trim()
            : null,
        customPermissions: selectedPermissions.toList(),
      );

      final accountRequestsCubit = context.read<AdminAccountRequestsCubit>();
      final errorMessage = await accountRequestsCubit.approveRequest(
        id: widget.accountRequest!.id!,
        body: approveBody,
      );

      if (!mounted) return;
      if (errorMessage == null) {
        setState(() {
          isSaving = false;
          isCreated = true;
        });
      } else {
        setState(() => isSaving = false);
        _navigateToErrorField(errorMessage);
      }
    } else {
      final addBody = AddEmployeeRequestBody(
        name: nameController.text.trim(),
        username: usernameController.text.trim(),
        password: passwordController.text.trim(),
        position: positionController.text.trim(),
        mobileId: mobileController.text.trim(),
        role: selectedRoles.first,
        roles: selectedRoles.toList(),
        departmentId: selectedDepartmentId!,
        branchId: selectedBranchId!,
        phone: phoneController.text.trim().isNotEmpty
            ? phoneController.text.trim()
            : null,
        email: emailController.text.trim().isNotEmpty
            ? emailController.text.trim()
            : null,
        employeeCode: employeeCodeController.text.trim().isNotEmpty
            ? employeeCodeController.text.trim()
            : null,
        workSystem: selectedWorkSystem,
        remoteWorkPolicyId: selectedRemoteWorkPolicyId,
        directManagerId: selectedDirectManagerId,
        managerId: selectedDirectManagerId,
        customPermissions: selectedPermissions.toList(),
      );

      final employeesCubit = context.read<AdminEmployeesCubit>();
      final errorMessage = await employeesCubit.addEmployee(addBody);
      if (!mounted) return;
      if (errorMessage == null) {
        setState(() {
          isSaving = false;
          isCreated = true;
        });
      } else {
        setState(() => isSaving = false);
        _navigateToErrorField(errorMessage);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isCreated) {
      return Scaffold(
        backgroundColor: AppColors.white,
        body: Center(
          child: Padding(
            padding: EdgeInsets.all(24.r),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.check_circle_rounded,
                  color: AppColors.success,
                  size: 72.r,
                ),
                hSpace(18),
                Text(
                  'admin.employeeWizard.successTitle'.tr(context: context),
                  textAlign: TextAlign.center,
                  style: AppTextStyles.font20Bold,
                ),
                hSpace(8),
                Text(
                  'admin.employeeWizard.successDescription'.tr(
                    context: context,
                  ),
                  textAlign: TextAlign.center,
                  style: AppTextStyles.font14Regular,
                ),
                hSpace(22),
                CustomButton(
                  text: 'admin.employeeWizard.backToRequests'.tr(
                    context: context,
                  ),
                  onTap: () => context.pop(true),
                  backgroundColor: AppColors.brandPrimary,
                  height: 48,
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        foregroundColor: AppColors.brandInk,
        title: Text(
          'admin.employeeWizard.title'.tr(context: context),
          style: AppTextStyles.font18Bold,
        ),
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          padding: EdgeInsetsDirectional.fromSTEB(16.w, 4.h, 16.w, 30.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: EdgeInsets.all(16.r),
                decoration: AppDecorations.card,
                child: AdminWizardStepperWidget(currentStep: currentStep),
              ),
              hSpace(16),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 220),
                child: Container(
                  key: ValueKey<int>(currentStep),
                  padding: EdgeInsets.all(18.r),
                  decoration: AppDecorations.card,
                  child: switch (currentStep) {
                    0 => AdminCreateEmployeePersonalStepWidget(
                      nameController: nameController,
                      usernameController: usernameController,
                      passwordController: passwordController,
                      mobileController: mobileController,
                      phoneController: phoneController,
                      emailController: emailController,
                      employeeCodeController: employeeCodeController,
                      selectedPhotoPath: selectedPhotoPath,
                      initialPhotoUrl: widget.accountRequest?.photo,
                      nameFocusNode: nameFocusNode,
                      usernameFocusNode: usernameFocusNode,
                      passwordFocusNode: passwordFocusNode,
                      phoneFocusNode: phoneFocusNode,
                      emailFocusNode: emailFocusNode,
                      nameErrorText: nameErrorText,
                      usernameErrorText: usernameErrorText,
                      passwordErrorText: passwordErrorText,
                      phoneErrorText: phoneErrorText,
                      emailErrorText: emailErrorText,
                      onNameChanged: (_) =>
                          setState(() => nameErrorText = null),
                      onUsernameChanged: (_) =>
                          setState(() => usernameErrorText = null),
                      onPasswordChanged: (_) =>
                          setState(() => passwordErrorText = null),
                      onPhoneChanged: (_) =>
                          setState(() => phoneErrorText = null),
                      onEmailChanged: (_) =>
                          setState(() => emailErrorText = null),
                      onPhotoSelected: (path) =>
                          setState(() => selectedPhotoPath = path),
                    ),
                    1 => AdminCreateEmployeeWorkStepWidget(
                      positionController: positionController,
                      positionFocusNode: positionFocusNode,
                      positionErrorText: positionErrorText,
                      onPositionChanged: (_) =>
                          setState(() => positionErrorText = null),
                      selectedRoles: selectedRoles,
                      availableRoles: availableRoles,
                      onRoleToggled: (role) => setState(() {
                        if (selectedRoles.contains(role)) {
                          if (selectedRoles.length > 1) {
                            selectedRoles.remove(role);
                          }
                        } else {
                          selectedRoles.add(role);
                        }
                      }),
                      selectedWorkSystem: selectedWorkSystem,
                      selectedRemoteWorkPolicyId: selectedRemoteWorkPolicyId,
                      onWorkSystemChanged: (val) => setState(() {
                        selectedWorkSystem = val;
                        selectedRemoteWorkPolicyId = null;
                      }),
                      onWorkPolicyChanged: (val) =>
                          setState(() => selectedRemoteWorkPolicyId = val),
                      selectedPermissionsCount: selectedPermissions.length,
                      onManagePermissionsPressed: _openPermissionsDialog,
                    ),
                    2 => AdminCreateEmployeeOrganizationStepWidget(
                      selectedDepartmentId: selectedDepartmentId,
                      selectedBranchId: selectedBranchId,
                      selectedDirectManagerId: selectedDirectManagerId,
                      onDepartmentChanged: (val) =>
                          setState(() => selectedDepartmentId = val),
                      onBranchChanged: (val) =>
                          setState(() => selectedBranchId = val),
                      onDirectManagerChanged: (val) =>
                          setState(() => selectedDirectManagerId = val),
                    ),
                    _ => Builder(
                      builder: (context) {
                        // Department name
                        final deptState = context
                            .watch<AdminDepartmentsCubit>()
                            .state;
                        final departments = switch (deptState) {
                          AdminDepartmentsSuccess(:final departments) =>
                            departments,
                          _ => const [],
                        };
                        final dept = departments
                            .where((d) => d.id == selectedDepartmentId)
                            .firstOrNull;

                        // Branch name
                        final branchState = context
                            .watch<AdminBranchesCubit>()
                            .state;
                        final branches = switch (branchState) {
                          AdminBranchesSuccess(:final branches) => branches,
                          _ => const [],
                        };
                        final branch = branches
                            .where((b) => b.id == selectedBranchId)
                            .firstOrNull;

                        // Manager name
                        final employees = context
                            .watch<AdminEmployeesCubit>()
                            .employees;
                        final manager = employees
                            .where((e) => e.id == selectedDirectManagerId)
                            .firstOrNull;

                        // Policy name
                        final remoteWorkState = context
                            .watch<RemoteWorkCubit>()
                            .state;
                        final policies = remoteWorkState.maybeWhen(
                          success: (items, _) => items,
                          orElse: () => const [],
                        );
                        final policy = policies
                            .where((p) => p.id == selectedRemoteWorkPolicyId)
                            .firstOrNull;

                        return AdminCreateEmployeeReviewStepWidget(
                          name: nameController.text,
                          username: usernameController.text,
                          position: positionController.text,
                          mobileId: mobileController.text,
                          phone: phoneController.text,
                          email: emailController.text,
                          employeeCode: employeeCodeController.text,
                          roles: selectedRoles.toList(),
                          workSystem: selectedWorkSystem,
                          workPolicyName: policy?.name,
                          departmentName: dept?.departmentName,
                          branchName: branch?.name,
                          directManagerName: manager?.name ?? manager?.userName,
                          selectedPermissionsCount: selectedPermissions.length,
                        );
                      },
                    ),
                  },
                ),
              ),
              hSpace(16),
              if (saveErrorMessage != null)
                Container(
                  margin: EdgeInsets.only(bottom: 12.h),
                  padding: EdgeInsets.all(12.r),
                  decoration: BoxDecoration(
                    color: AppColors.softRedBackground,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Text(
                    saveErrorMessage!.tr(context: context),
                    textAlign: TextAlign.center,
                    style: AppTextStyles.font13Regular.copyWith(
                      color: AppColors.error,
                    ),
                  ),
                ),
              Row(
                children: [
                  if (currentStep > 0)
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => setState(() => currentStep--),
                        child: Text(
                          'admin.employeeWizard.back'.tr(context: context),
                        ),
                      ),
                    ),
                  if (currentStep > 0) vSpace(10),
                  Expanded(
                    child: CustomButton(
                      text: currentStep == 3
                          ? 'admin.employeeWizard.createAccount'.tr(
                              context: context,
                            )
                          : 'admin.employeeWizard.next'.tr(context: context),
                      onTap: () async {
                        if (currentStep < 3) {
                          if (!_validateStep(currentStep)) return;
                          setState(() {
                            saveErrorMessage = null;
                            currentStep++;
                          });
                          return;
                        }
                        await _submitForm();
                      },
                      isLoading: isSaving,
                      backgroundColor: AppColors.brandPrimary,
                      height: 48,
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
}
