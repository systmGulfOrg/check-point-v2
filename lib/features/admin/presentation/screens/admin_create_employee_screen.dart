import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/core.dart';
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
  late final TextEditingController mobileController;
  late final TextEditingController emailController;
  late final TextEditingController codeController;
  int currentStep = 0;
  String role = 'auth.role.employee';
  String status = 'admin.employeeWizard.active';
  String department = 'admin.employeeWizard.operations';
  String branch = 'admin.employeeWizard.headOffice';
  String supervisor = 'admin.employeeWizard.supervisorAhmed';
  String shift = 'admin.employeeWizard.morningShift';
  String policy = 'admin.employeeWizard.standardPolicy';
  bool officeAttendance = true;
  bool siteAttendance = true;
  bool customerAttendance = false;
  bool isSaving = false;
  bool isCreated = false;
  bool saveFailed = false;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: 'Ahmed Mohamed');
    usernameController = TextEditingController();
    mobileController = TextEditingController();
    emailController = TextEditingController();
    codeController = TextEditingController();
  }

  @override
  void dispose() {
    nameController.dispose();
    usernameController.dispose();
    mobileController.dispose();
    emailController.dispose();
    codeController.dispose();
    super.dispose();
  }

  Widget textField(
    String hint, {
    TextEditingController? controller,
    bool readOnly = false,
  }) => CustomTextFormField(
    hintText: hint,
    controller: controller,
    readOnly: readOnly,
    validator: (value) => value == null || value.trim().isEmpty
        ? 'admin.employeeWizard.requiredField'.tr(context: context)
        : null,
  );

  Widget dropdownField(
    String value,
    List<String> values,
    ValueChanged<String?> onChanged,
  ) => DropdownButtonFormField<String>(
    initialValue: value,
    isExpanded: true,
    decoration: InputDecoration(
      filled: true,
      fillColor: AppColors.fieldBackground,
    ),
    items: values
        .map(
          (item) => DropdownMenuItem(
            value: item,
            child: Text(item.tr(context: context)),
          ),
        )
        .toList(),
    onChanged: onChanged,
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
                        AdminWizardFieldWidget(
                          label: 'admin.employeeWizard.email'.tr(
                            context: context,
                          ),
                          child: textField(
                            'admin.employeeWizard.emailHint'.tr(
                              context: context,
                            ),
                            controller: emailController,
                          ),
                        ),
                        OutlinedButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.add_a_photo_outlined),
                          label: Text(
                            'admin.employeeWizard.profilePhoto'.tr(
                              context: context,
                            ),
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
                          label: 'admin.employeeWizard.employeeCode'.tr(
                            context: context,
                          ),
                          child: textField(
                            'admin.employeeWizard.employeeCodeHint'.tr(
                              context: context,
                            ),
                            controller: codeController,
                          ),
                        ),
                        AdminWizardFieldWidget(
                          label: 'admin.employeeWizard.position'.tr(
                            context: context,
                          ),
                          child: textField(
                            'admin.employeeWizard.positionHint'.tr(
                              context: context,
                            ),
                          ),
                        ),
                        AdminWizardFieldWidget(
                          label: 'admin.employeeWizard.role'.tr(
                            context: context,
                          ),
                          child: dropdownField(role, const [
                            'auth.role.admin',
                            'auth.role.supervisor',
                            'auth.role.employee',
                          ], (value) => setState(() => role = value ?? role)),
                        ),
                        AdminWizardFieldWidget(
                          label: 'admin.employeeWizard.joinDate'.tr(
                            context: context,
                          ),
                          child: textField('02/09/2026', readOnly: true),
                        ),
                        AdminWizardFieldWidget(
                          label: 'admin.employeeWizard.status'.tr(
                            context: context,
                          ),
                          child: dropdownField(
                            status,
                            const [
                              'admin.employeeWizard.active',
                              'admin.employeeWizard.inactive',
                            ],
                            (value) => setState(() => status = value ?? status),
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
                        AdminWizardFieldWidget(
                          label: 'admin.employeeWizard.department'.tr(
                            context: context,
                          ),
                          child: dropdownField(
                            department,
                            const [
                              'admin.employeeWizard.operations',
                              'admin.employeeWizard.finance',
                              'admin.employeeWizard.technology',
                            ],
                            (value) => setState(
                              () => department = value ?? department,
                            ),
                          ),
                        ),
                        AdminWizardFieldWidget(
                          label: 'admin.employeeWizard.branch'.tr(
                            context: context,
                          ),
                          child: dropdownField(
                            branch,
                            const [
                              'admin.employeeWizard.headOffice',
                              'admin.employeeWizard.northBranch',
                            ],
                            (value) => setState(() => branch = value ?? branch),
                          ),
                        ),
                        AdminWizardFieldWidget(
                          label: 'admin.employeeWizard.supervisor'.tr(
                            context: context,
                          ),
                          child: dropdownField(
                            supervisor,
                            const [
                              'admin.employeeWizard.supervisorAhmed',
                              'admin.employeeWizard.supervisorSara',
                            ],
                            (value) => setState(
                              () => supervisor = value ?? supervisor,
                            ),
                          ),
                        ),
                        AdminWizardFieldWidget(
                          label: 'admin.employeeWizard.shift'.tr(
                            context: context,
                          ),
                          child: dropdownField(shift, const [
                            'admin.employeeWizard.morningShift',
                            'admin.employeeWizard.eveningShift',
                          ], (value) => setState(() => shift = value ?? shift)),
                        ),
                        AdminWizardFieldWidget(
                          label: 'admin.employeeWizard.policy'.tr(
                            context: context,
                          ),
                          child: dropdownField(
                            policy,
                            const [
                              'admin.employeeWizard.standardPolicy',
                              'admin.employeeWizard.flexiblePolicy',
                            ],
                            (value) => setState(() => policy = value ?? policy),
                          ),
                        ),
                        Text(
                          'admin.employeeWizard.permissions'.tr(
                            context: context,
                          ),
                          style: AppTextStyles.font14SemiBold,
                        ),
                        CheckboxListTile(
                          value: officeAttendance,
                          onChanged: (value) =>
                              setState(() => officeAttendance = value ?? false),
                          title: Text(
                            'admin.employeeWizard.officeAttendance'.tr(
                              context: context,
                            ),
                          ),
                          contentPadding: EdgeInsets.zero,
                          activeColor: AppColors.brandPrimary,
                        ),
                        CheckboxListTile(
                          value: siteAttendance,
                          onChanged: (value) =>
                              setState(() => siteAttendance = value ?? false),
                          title: Text(
                            'admin.employeeWizard.siteAttendance'.tr(
                              context: context,
                            ),
                          ),
                          contentPadding: EdgeInsets.zero,
                          activeColor: AppColors.brandPrimary,
                        ),
                        CheckboxListTile(
                          value: customerAttendance,
                          onChanged: (value) => setState(
                            () => customerAttendance = value ?? false,
                          ),
                          title: Text(
                            'admin.employeeWizard.customerAttendance'.tr(
                              context: context,
                            ),
                          ),
                          contentPadding: EdgeInsets.zero,
                          activeColor: AppColors.brandPrimary,
                        ),
                        Container(
                          padding: EdgeInsets.all(14.r),
                          decoration: BoxDecoration(
                            color: AppColors.infoBackground,
                            borderRadius: BorderRadius.circular(14.r),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.phone_android_rounded,
                                color: AppColors.brandPrimary,
                                size: 22.r,
                              ),
                              vSpace(10),
                              Expanded(
                                child: Text(
                                  'admin.employeeWizard.registeredDevice'.tr(
                                    context: context,
                                  ),
                                  style: AppTextStyles.font13SemiBold,
                                ),
                              ),
                              TextButton(
                                onPressed: () {},
                                child: Text(
                                  'admin.employeeWizard.resetDevice'.tr(
                                    context: context,
                                  ),
                                ),
                              ),
                            ],
                          ),
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
                        for (final item in const [
                          ('admin.employeeWizard.reviewName', 'Ahmed Mohamed'),
                          (
                            'admin.employeeWizard.reviewUsername',
                            'ahmed.mohamed',
                          ),
                          (
                            'admin.employeeWizard.reviewDepartment',
                            'Operations',
                          ),
                          ('admin.employeeWizard.reviewBranch', 'Head Office'),
                          (
                            'admin.employeeWizard.reviewSupervisor',
                            'Sara Ahmed',
                          ),
                          ('admin.employeeWizard.reviewShift', 'Morning Shift'),
                          ('admin.employeeWizard.reviewDevice', 'Samsung A54'),
                        ])
                          Padding(
                            padding: EdgeInsets.only(bottom: 13.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  item.$1.tr(context: context),
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
              if (saveFailed)
                Container(
                  margin: EdgeInsets.only(bottom: 12.h),
                  padding: EdgeInsets.all(12.r),
                  decoration: BoxDecoration(
                    color: AppColors.softRedBackground,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Text(
                    'errors.unknown'.tr(context: context),
                    textAlign: TextAlign.right,
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
                        setState(() {
                          isSaving = true;
                          saveFailed = false;
                        });
                        try {
                          await Future<void>.delayed(
                            const Duration(milliseconds: 900),
                          );
                        } catch (_) {
                          if (mounted) {
                            setState(() {
                              isSaving = false;
                              saveFailed = true;
                            });
                          }
                          return;
                        }
                        if (!mounted) return;
                        setState(() {
                          isSaving = false;
                          isCreated = true;
                        });
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
