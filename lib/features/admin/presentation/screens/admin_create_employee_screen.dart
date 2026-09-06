import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/core.dart';
import '../../data/models/add_employee_request_body.dart';
import '../cubit/admin_branches_cubit.dart';
import '../cubit/admin_branches_state.dart';
import '../cubit/admin_departments_cubit.dart';
import '../cubit/admin_departments_state.dart';
import '../cubit/admin_employees_cubit.dart';
import '../widgets/admin_wizard_field_widget.dart';
import '../widgets/admin_wizard_stepper_widget.dart';

class AdminCreateEmployeeScreen extends StatefulWidget {
  const AdminCreateEmployeeScreen({super.key});

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
  late final TextEditingController positionController;
  int currentStep = 0;
  String role = 'Employee';
  int? selectedDepartmentId;
  int? selectedBranchId;
  bool isSaving = false;
  bool isCreated = false;
  String? saveErrorMessage;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    usernameController = TextEditingController();
    passwordController = TextEditingController();
    mobileController = TextEditingController();
    positionController = TextEditingController();
  }

  @override
  void dispose() {
    nameController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    mobileController.dispose();
    positionController.dispose();
    super.dispose();
  }

  Widget textField(
    String hint, {
    TextEditingController? controller,
    bool readOnly = false,
    bool obscureText = false,
  }) => CustomTextFormField(
    hintText: hint,
    controller: controller,
    readOnly: readOnly,
    obscureText: obscureText,
    validator: (value) => value == null || value.trim().isEmpty
        ? 'admin.employeeWizard.requiredField'.tr(context: context)
        : null,
  );

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
                  onTap: context.pop,
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
                    0 => Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'admin.employeeWizard.personalTitle'.tr(
                            context: context,
                          ),
                          style: AppTextStyles.font16Bold,
                        ),
                        hSpace(14),
                        AdminWizardFieldWidget(
                          label: 'admin.employeeWizard.fullName'.tr(
                            context: context,
                          ),
                          child: textField(
                            'admin.employeeWizard.fullNameHint'.tr(
                              context: context,
                            ),
                            controller: nameController,
                          ),
                        ),
                        AdminWizardFieldWidget(
                          label: 'admin.employeeWizard.username'.tr(
                            context: context,
                          ),
                          child: textField(
                            'admin.employeeWizard.usernameHint'.tr(
                              context: context,
                            ),
                            controller: usernameController,
                          ),
                        ),
                        AdminWizardFieldWidget(
                          label: 'Password',
                          child: textField(
                            'Enter password',
                            controller: passwordController,
                            obscureText: true,
                          ),
                        ),
                        AdminWizardFieldWidget(
                          label: 'admin.employeeWizard.mobile'.tr(
                            context: context,
                          ),
                          child: textField(
                            'admin.employeeWizard.mobileHint'.tr(
                              context: context,
                            ),
                            controller: mobileController,
                          ),
                        ),
                      ],
                    ),
                    1 => Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'admin.employeeWizard.workTitle'.tr(context: context),
                          style: AppTextStyles.font16Bold,
                        ),
                        hSpace(14),
                        AdminWizardFieldWidget(
                          label: 'admin.employeeWizard.position'.tr(
                            context: context,
                          ),
                          child: textField(
                            'admin.employeeWizard.positionHint'.tr(
                              context: context,
                            ),
                            controller: positionController,
                          ),
                        ),
                        AdminWizardFieldWidget(
                          label: 'admin.employeeWizard.role'.tr(
                            context: context,
                          ),
                          child: DropdownButtonFormField<String>(
                            initialValue: role,
                            isExpanded: true,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: AppColors.fieldBackground,
                            ),
                            items: const [
                              DropdownMenuItem(
                                value: 'Employee',
                                child: Text('Employee'),
                              ),
                              DropdownMenuItem(
                                value: 'Supervisor',
                                child: Text('Supervisor'),
                              ),
                              DropdownMenuItem(
                                value: 'Admin',
                                child: Text('Admin'),
                              ),
                            ],
                            onChanged: (val) =>
                                setState(() => role = val ?? 'Employee'),
                          ),
                        ),
                      ],
                    ),
                    2 => Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'admin.employeeWizard.attendanceTitle'.tr(
                            context: context,
                          ),
                          style: AppTextStyles.font16Bold,
                        ),
                        hSpace(14),
                        BlocBuilder<
                          AdminDepartmentsCubit,
                          AdminDepartmentsState
                        >(
                          builder: (context, deptState) {
                            final departments = switch (deptState) {
                              AdminDepartmentsSuccess(:final departments) =>
                                departments,
                              _ => const [],
                            };
                            return AdminWizardFieldWidget(
                              label: 'admin.employeeWizard.department'.tr(
                                context: context,
                              ),
                              child: DropdownButtonFormField<int>(
                                initialValue: selectedDepartmentId,
                                isExpanded: true,
                                hint: const Text('Select Department'),
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: AppColors.fieldBackground,
                                ),
                                items: departments
                                    .map(
                                      (d) => DropdownMenuItem<int>(
                                        value: d.id,
                                        child: Text(d.name ?? '-'),
                                      ),
                                    )
                                    .toList(),
                                onChanged: (val) =>
                                    setState(() => selectedDepartmentId = val),
                              ),
                            );
                          },
                        ),
                        BlocBuilder<AdminBranchesCubit, AdminBranchesState>(
                          builder: (context, branchState) {
                            final branches = switch (branchState) {
                              AdminBranchesSuccess(:final branches) => branches,
                              _ => const [],
                            };
                            return AdminWizardFieldWidget(
                              label: 'admin.employeeWizard.branch'.tr(
                                context: context,
                              ),
                              child: DropdownButtonFormField<int>(
                                initialValue: selectedBranchId,
                                isExpanded: true,
                                hint: const Text('Select Branch'),
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
                                    setState(() => selectedBranchId = val),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    _ => Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'admin.employeeWizard.reviewTitle'.tr(
                            context: context,
                          ),
                          style: AppTextStyles.font16Bold,
                        ),
                        hSpace(8),
                        Text(
                          'admin.employeeWizard.reviewDescription'.tr(
                            context: context,
                          ),
                          style: AppTextStyles.font13Regular,
                        ),
                        hSpace(16),
                        for (final item in [
                          ('Name', nameController.text),
                          ('Username', usernameController.text),
                          ('Position', positionController.text),
                          ('Mobile ID', mobileController.text),
                          ('Role', role),
                          ('Department ID', '${selectedDepartmentId ?? '-'}'),
                          ('Branch ID', '${selectedBranchId ?? '-'}'),
                        ])
                          Padding(
                            padding: EdgeInsets.only(bottom: 13.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  item.$1,
                                  style: AppTextStyles.font13Regular,
                                ),
                                Text(
                                  item.$2,
                                  style: AppTextStyles.font13SemiBold,
                                ),
                              ],
                            ),
                          ),
                      ],
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
                    saveErrorMessage!,
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
                          if (!(formKey.currentState?.validate() ?? false)) {
                            return;
                          }
                          setState(() => currentStep++);
                          return;
                        }
                        if (selectedDepartmentId == null ||
                            selectedBranchId == null) {
                          setState(() {
                            saveErrorMessage =
                                'Please select department and branch.';
                          });
                          return;
                        }
                        setState(() {
                          isSaving = true;
                          saveErrorMessage = null;
                        });
                        final body = AddEmployeeRequestBody(
                          name: nameController.text.trim(),
                          username: usernameController.text.trim(),
                          password: passwordController.text.trim(),
                          position: positionController.text.trim(),
                          mobileId: mobileController.text.trim(),
                          role: role,
                          departmentId: selectedDepartmentId!,
                          branchId: selectedBranchId!,
                        );
                        final success = await context
                            .read<AdminEmployeesCubit>()
                            .addEmployee(body);
                        if (!mounted) return;
                        if (success) {
                          setState(() {
                            isSaving = false;
                            isCreated = true;
                          });
                        } else {
                          setState(() {
                            isSaving = false;
                            saveErrorMessage = 'Failed to create employee.';
                          });
                        }
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
