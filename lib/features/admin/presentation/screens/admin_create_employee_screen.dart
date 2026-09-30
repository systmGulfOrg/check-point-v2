import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/admin/data/models/account_requests/account_requests_response_model.dart';
import 'package:check_point_v2/features/admin/data/models/account_requests/approve_account_request_body.dart';
import 'package:check_point_v2/features/admin/data/models/employee/add_employee_request_body.dart';
import 'package:check_point_v2/features/admin/data/models/locations/branch_response_model.dart';
import 'package:check_point_v2/features/admin/data/models/locations/department_response_model.dart';
import 'package:check_point_v2/features/admin/data/models/shifts_policies/shift_model.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/account_requests/admin_account_requests_cubit.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/locations/admin_branches_cubit.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/locations/admin_branches_state.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/locations/admin_departments_cubit.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/locations/admin_departments_state.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/shifts_policies/admin_shifts_policies_cubit.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/shifts_policies/admin_shifts_policies_state.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/employee/admin_employees_cubit.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/employee/admin_employees_state.dart';
import 'package:check_point_v2/features/admin/presentation/widgets/admin_new_shift_sheet_widget.dart';
import 'package:check_point_v2/features/admin/presentation/widgets/admin_wizard_field_widget.dart';
import 'package:check_point_v2/features/admin/presentation/widgets/admin_wizard_stepper_widget.dart';
import 'package:check_point_v2/features/admin/presentation/widgets/admin_employee_work_system_widget.dart';
import 'package:check_point_v2/features/contractor/presentation/cubit/contractor_cubit.dart';
import 'package:check_point_v2/features/contractor/presentation/cubit/contractor_state.dart';
import 'package:check_point_v2/features/identity/presentation/widgets/national_id_capture_widget.dart';
import 'package:check_point_v2/features/identity/presentation/widgets/national_id_ocr_listener_widget.dart';

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
  late final TextEditingController nationalIdController;
  late final TextEditingController employeeCodeController;
  late final TextEditingController positionController;
  int currentStep = 0;
  final Set<String> selectedRoles = {'HR'};
  int? selectedDepartmentId;
  int? selectedBranchId;
  final Set<int> selectedBranchIds = {};
  final Set<String> selectedSiteIds = {};
  String attendanceLocationType = 'branch';
  int? selectedShiftId;
  String? selectedDirectManagerId;
  bool canAddAttendance = true;
  bool canAddPlan = true;
  bool isSaving = false;
  bool isCreated = false;
  String? saveErrorMessage;
  String selectedWorkSystem = 'onsite';
  String? selectedRemoteWorkPolicyId;

  static const List<String> availableRoles = ['HR', 'Supervisor', 'Contractor'];

  @override
  void initState() {
    super.initState();
    context.read<AdminEmployeesCubit>().loadEmployees();
    nameController = TextEditingController(text: widget.accountRequest?.name);
    usernameController = TextEditingController(
      text: widget.accountRequest?.name != null
          ? widget.accountRequest!.name!.trim().toLowerCase().replaceAll(
              RegExp(r'\s+'),
              '.',
            )
          : '',
    );
    passwordController = TextEditingController();
    mobileController = TextEditingController(
      text: widget.accountRequest?.mobileId,
    );
    phoneController = TextEditingController(text: widget.accountRequest?.phone);
    emailController = TextEditingController();
    nationalIdController = TextEditingController();
    employeeCodeController = TextEditingController(
      text: CodeGeneratorHelper.generateEmployeeCode(),
    );
    positionController = TextEditingController();
  }

  @override
  void dispose() {
    nameController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    mobileController.dispose();
    phoneController.dispose();
    emailController.dispose();
    nationalIdController.dispose();
    employeeCodeController.dispose();
    positionController.dispose();
    super.dispose();
  }

  Widget textField(
    String hint, {
    TextEditingController? controller,
    bool readOnly = false,
    bool obscureText = false,
    bool isRequired = true,
    Widget? suffixIcon,
  }) => CustomTextFormField(
    hintText: hint,
    controller: controller,
    readOnly: readOnly,
    obscureText: obscureText,
    suffixIcon: suffixIcon,
    validator: isRequired
        ? (value) => value == null || value.trim().isEmpty
              ? 'admin.employeeWizard.requiredField'.tr(context: context)
              : null
        : null,
  );

  void _openAddShiftSheet() async {
    final shiftsCubit = context.read<AdminShiftsPoliciesCubit>();
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.cardBackground,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      builder: (_) => BlocProvider.value(
        value: shiftsCubit,
        child: const AdminNewShiftSheetWidget(),
      ),
    );
    if (mounted && shiftsCubit.shifts.isNotEmpty) {
      setState(() {
        selectedShiftId = shiftsCubit.shifts.last.id;
      });
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

    return NationalIdOcrListenerWidget(
      onDetected: (result) {
        nationalIdController
          ..text = result.nationalId
          ..selection = TextSelection.collapsed(
            offset: result.nationalId.length,
          );
        if (result.fullName != null && result.fullName!.isNotEmpty) {
          nameController.text = result.fullName!;
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('identity.nationalIdDetected'.tr(context: context)),
          ),
        );
      },
      onFailure: (message) => ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(message))),
      child: Scaffold(
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
                            label: 'admin.employeeWizard.password'.tr(
                              context: context,
                            ),
                            child: textField(
                              'admin.employeeWizard.passwordHint'.tr(
                                context: context,
                              ),
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
                          AdminWizardFieldWidget(
                            label: 'admin.employeeWizard.phone'.tr(
                              context: context,
                            ),
                            child: textField(
                              'admin.employeeWizard.phoneHint'.tr(
                                context: context,
                              ),
                              controller: phoneController,
                              isRequired: false,
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
                              isRequired: false,
                            ),
                          ),
                          NationalIdCaptureWidget(
                            controller: nationalIdController,
                          ),
                          hSpace(10),
                          AdminWizardFieldWidget(
                            label: 'admin.employeeWizard.employeeCode'.tr(
                              context: context,
                            ),
                            child: textField(
                              'admin.employeeWizard.employeeCodeHint'.tr(
                                context: context,
                              ),
                              controller: employeeCodeController,
                              isRequired: false,
                              suffixIcon: IconButton(
                                icon: const Icon(
                                  Icons.refresh_rounded,
                                  color: AppColors.brandPrimary,
                                ),
                                onPressed: () {
                                  setState(() {
                                    employeeCodeController.text =
                                        CodeGeneratorHelper.generateEmployeeCode();
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      1 => Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            'admin.employeeWizard.workTitle'.tr(
                              context: context,
                            ),
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
                          hSpace(10),
                          Text(
                            'admin.employeeWizard.role'.tr(context: context),
                            style: AppTextStyles.font13SemiBold,
                          ),
                          hSpace(10),
                          Wrap(
                            spacing: 8.w,
                            runSpacing: 8.h,
                            children: availableRoles.map((r) {
                              final isSelected = selectedRoles.contains(r);
                              return FilterChip(
                                label: Text(
                                  switch (r) {
                                    'HR' => 'admin.roles.hr'.tr(
                                      context: context,
                                    ),
                                    'Supervisor' => 'admin.roles.supervisor'.tr(
                                      context: context,
                                    ),
                                    'Contractor' => 'admin.roles.contractor'.tr(
                                      context: context,
                                    ),
                                    _ => r,
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
                                  if (selected) {
                                    setState(() {
                                      selectedRoles
                                        ..clear()
                                        ..add(r);
                                    });
                                  }
                                },
                              );
                            }).toList(),
                          ),
                          hSpace(16),
                          AdminEmployeeWorkSystemWidget(
                            selectedSystem: selectedWorkSystem,
                            selectedPolicyId: selectedRemoteWorkPolicyId,
                            onSystemChanged: (value) => setState(() {
                              selectedWorkSystem = value;
                              selectedRemoteWorkPolicyId = null;
                            }),
                            onPolicyChanged: (value) => setState(
                              () => selectedRemoteWorkPolicyId = value,
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
                                (d) => d.id == selectedDepartmentId,
                              );
                              return AdminWizardFieldWidget(
                                label: 'admin.employeeWizard.department'.tr(
                                  context: context,
                                ),
                                child: DropdownButtonFormField<int>(
                                  key: ValueKey(
                                    'dept_${hasSelected ? selectedDepartmentId : 'none'}',
                                  ),
                                  initialValue: hasSelected
                                      ? selectedDepartmentId
                                      : null,
                                  isExpanded: true,
                                  hint: Text(
                                    'admin.employeeWizard.department'.tr(
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
                                  onChanged: (val) => setState(() {
                                    selectedDepartmentId = val;
                                  }),
                                ),
                              );
                            },
                          ),
                          SegmentedButton<String>(
                            segments: [
                              ButtonSegment(
                                value: 'branch',
                                label: Text(
                                  'employee.profile.branch'.tr(
                                    context: context,
                                  ),
                                ),
                              ),
                              ButtonSegment(
                                value: 'site',
                                label: Text(
                                  'employee.profile.site'.tr(context: context),
                                ),
                              ),
                            ],
                            selected: {attendanceLocationType},
                            onSelectionChanged: (values) => setState(() {
                              attendanceLocationType = values.first;
                              selectedBranchIds.clear();
                              selectedSiteIds.clear();
                              selectedBranchId = null;
                            }),
                          ),
                          hSpace(10),
                          if (attendanceLocationType == 'branch')
                            BlocBuilder<AdminBranchesCubit, AdminBranchesState>(
                              builder: (context, branchState) {
                                final rawBranches = switch (branchState) {
                                  AdminBranchesSuccess(:final branches) =>
                                    branches,
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
                                  (b) => b.id == selectedBranchId,
                                );
                                return AdminWizardFieldWidget(
                                  label: 'admin.employeeWizard.branch'.tr(
                                    context: context,
                                  ),
                                  child: DropdownButtonFormField<int>(
                                    key: ValueKey(
                                      'branch_${hasSelected ? selectedBranchId : 'none'}',
                                    ),
                                    initialValue: hasSelected
                                        ? selectedBranchId
                                        : null,
                                    isExpanded: true,
                                    hint: Text(
                                      'admin.employeeWizard.branch'.tr(
                                        context: context,
                                      ),
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
                                    onChanged: (val) => setState(() {
                                      selectedBranchId = val;
                                      if (val != null) {
                                        selectedBranchIds.add(val);
                                      }
                                    }),
                                  ),
                                );
                              },
                            ),
                          if (selectedBranchIds.isNotEmpty)
                            Wrap(
                              spacing: 8.w,
                              runSpacing: 6.h,
                              children: selectedBranchIds
                                  .map(
                                    (id) => InputChip(
                                      label: Text('Branch #$id'),
                                      onDeleted: () => setState(() {
                                        selectedBranchIds.remove(id);
                                        if (selectedBranchId == id) {
                                          selectedBranchId =
                                              selectedBranchIds.isEmpty
                                              ? null
                                              : selectedBranchIds.first;
                                        }
                                      }),
                                    ),
                                  )
                                  .toList(),
                            ),
                          if (attendanceLocationType == 'site')
                            BlocBuilder<ContractorCubit, ContractorState>(
                              builder: (context, state) {
                                final sites =
                                    state.mapOrNull(
                                      success: (value) => value.sites,
                                    ) ??
                                    const [];
                                return Wrap(
                                  spacing: 8.w,
                                  runSpacing: 6.h,
                                  children: sites
                                      .map(
                                        (site) => FilterChip(
                                          label: Text(site.siteName),
                                          selected: selectedSiteIds.contains(
                                            site.siteId,
                                          ),
                                          onSelected: (selected) =>
                                              setState(() {
                                                if (selected) {
                                                  selectedSiteIds.add(
                                                    site.siteId,
                                                  );
                                                } else {
                                                  selectedSiteIds.remove(
                                                    site.siteId,
                                                  );
                                                }
                                              }),
                                        ),
                                      )
                                      .toList(),
                                );
                              },
                            ),
                          BlocBuilder<
                            AdminShiftsPoliciesCubit,
                            AdminShiftsPoliciesState
                          >(
                            builder: (context, shiftState) {
                              final rawShifts = shiftState.maybeWhen(
                                success: (shifts, _) => shifts,
                                orElse: () => context
                                    .read<AdminShiftsPoliciesCubit>()
                                    .shifts,
                              );
                              final shifts = <ShiftModel>[];
                              final seenIds = <int>{};
                              for (final s in rawShifts) {
                                final id = s.id;
                                if (id != null && seenIds.add(id)) {
                                  shifts.add(s);
                                }
                              }
                              final hasSelected = shifts.any(
                                (s) => s.id == selectedShiftId,
                              );
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'admin.employeeWizard.shift'.tr(
                                          context: context,
                                        ),
                                        style: AppTextStyles.font13SemiBold,
                                      ),
                                      TextButton.icon(
                                        onPressed: _openAddShiftSheet,
                                        icon: Icon(
                                          Icons.add_rounded,
                                          size: 16.r,
                                        ),
                                        label: Text(
                                          'admin.employeeWizard.addShift'.tr(
                                            context: context,
                                          ),
                                          style: AppTextStyles.font12Bold
                                              .copyWith(
                                                color: AppColors.brandPrimary,
                                              ),
                                        ),
                                        style: TextButton.styleFrom(
                                          padding: EdgeInsets.zero,
                                          visualDensity: VisualDensity.compact,
                                        ),
                                      ),
                                    ],
                                  ),
                                  hSpace(4),
                                  DropdownButtonFormField<int>(
                                    key: ValueKey(
                                      'shift_${hasSelected ? selectedShiftId : 'none'}',
                                    ),
                                    initialValue: hasSelected
                                        ? selectedShiftId
                                        : null,
                                    isExpanded: true,
                                    hint: Text(
                                      'admin.employeeWizard.selectShift'.tr(
                                        context: context,
                                      ),
                                    ),
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: AppColors.fieldBackground,
                                    ),
                                    items: shifts
                                        .map(
                                          (s) => DropdownMenuItem<int>(
                                            value: s.id,
                                            child: Text(s.name ?? '-'),
                                          ),
                                        )
                                        .toList(),
                                    onChanged: (val) =>
                                        setState(() => selectedShiftId = val),
                                  ),
                                ],
                              );
                            },
                          ),
                          BlocBuilder<AdminEmployeesCubit, AdminEmployeesState>(
                            builder: (context, empState) {
                              final employees = context
                                  .read<AdminEmployeesCubit>()
                                  .employees;
                              final validEmployees = employees
                                  .where((e) => e.id != null)
                                  .toList();
                              return AdminWizardFieldWidget(
                                label: 'admin.employeeWizard.directManager'.tr(
                                  context: context,
                                ),
                                child: DropdownButtonFormField<String?>(
                                  key: ValueKey(
                                    'direct_manager_${selectedDirectManagerId ?? 'none'}',
                                  ),
                                  initialValue: selectedDirectManagerId,
                                  isExpanded: true,
                                  hint: Text(
                                    'admin.employeeWizard.selectDirectManager'
                                        .tr(context: context),
                                  ),
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: AppColors.fieldBackground,
                                  ),
                                  items: [
                                    DropdownMenuItem<String?>(
                                      value: null,
                                      child: Text(
                                        'admin.employeeWizard.noDirectManager'
                                            .tr(context: context),
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
                                    () => selectedDirectManagerId = val,
                                  ),
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
                            (
                              'Phone',
                              phoneController.text.isNotEmpty
                                  ? phoneController.text
                                  : '-',
                            ),
                            (
                              'Email',
                              emailController.text.isNotEmpty
                                  ? emailController.text
                                  : '-',
                            ),
                            (
                              'Employee Code',
                              employeeCodeController.text.isNotEmpty
                                  ? employeeCodeController.text
                                  : '-',
                            ),
                            ('Role', selectedRoles.firstOrNull ?? '-'),
                            ('Work System', selectedWorkSystem),
                            if (selectedWorkSystem != 'onsite')
                              (
                                'Work Policy',
                                selectedRemoteWorkPolicyId ?? '-',
                              ),
                            ('Department ID', '${selectedDepartmentId ?? '-'}'),
                            ('Branch ID', '${selectedBranchId ?? '-'}'),
                            ('Shift ID', '${selectedShiftId ?? '-'}'),
                          ])
                            Padding(
                              padding: EdgeInsets.only(bottom: 13.h),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    item.$1,
                                    style: AppTextStyles.font13Regular,
                                  ),
                                  Flexible(
                                    child: Text(
                                      item.$2,
                                      style: AppTextStyles.font13SemiBold,
                                      textAlign: TextAlign.end,
                                    ),
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
                            if (currentStep == 0) {
                              if (!(formKey.currentState?.validate() ??
                                  false)) {
                                return;
                              }
                            }
                            if (currentStep == 1) {
                              if (positionController.text.trim().isEmpty) {
                                setState(() {
                                  saveErrorMessage =
                                      'admin.employeeWizard.requiredField';
                                });
                                return;
                              }
                              if (selectedRoles.isEmpty) {
                                setState(() {
                                  saveErrorMessage =
                                      'admin.employeeWizard.rolesRequired';
                                });
                                return;
                              }
                              if (selectedWorkSystem != 'onsite' &&
                                  selectedRemoteWorkPolicyId == null) {
                                setState(() {
                                  saveErrorMessage =
                                      'admin.employeeWizard.workPolicyRequired';
                                });
                                return;
                              }
                            }
                            if (currentStep == 2) {
                              if (selectedDepartmentId == null ||
                                  (attendanceLocationType == 'branch'
                                      ? selectedBranchId == null
                                      : selectedSiteIds.isEmpty) ||
                                  selectedShiftId == null) {
                                setState(() {
                                  saveErrorMessage = selectedShiftId == null
                                      ? 'admin.employeeWizard.shiftRequired'
                                      : 'admin.employeeWizard.departmentBranchRequired';
                                });
                                return;
                              }
                            }
                            setState(() {
                              saveErrorMessage = null;
                              currentStep++;
                            });
                            return;
                          }

                          if (selectedDepartmentId == null ||
                              (attendanceLocationType == 'branch'
                                  ? selectedBranchId == null
                                  : selectedSiteIds.isEmpty) ||
                              selectedShiftId == null) {
                            setState(() {
                              saveErrorMessage = selectedShiftId == null
                                  ? 'admin.employeeWizard.shiftRequired'
                                  : 'admin.employeeWizard.departmentBranchRequired';
                            });
                            return;
                          }

                          setState(() {
                            isSaving = true;
                            saveErrorMessage = null;
                          });

                          final isFromRequest =
                              widget.accountRequest != null &&
                              widget.accountRequest!.id != null;

                          if (isFromRequest) {
                            final approveBody = ApproveAccountRequestBody(
                              userName: usernameController.text.trim(),
                              password: passwordController.text.trim(),
                              role: selectedRoles.first,
                              roles: selectedRoles.toList(),
                              departmentId: selectedDepartmentId,
                              branchId: selectedBranchId,
                              shiftId: selectedShiftId,
                              workSystem: selectedWorkSystem,
                              remoteWorkPolicyId: selectedRemoteWorkPolicyId,
                              position: positionController.text.trim(),
                              employeeCode:
                                  employeeCodeController.text.trim().isNotEmpty
                                  ? employeeCodeController.text.trim()
                                  : null,
                              email: emailController.text.trim().isNotEmpty
                                  ? emailController.text.trim()
                                  : null,
                              nationalId:
                                  nationalIdController.text.trim().isNotEmpty
                                  ? nationalIdController.text.trim()
                                  : null,
                            );

                            final accountRequestsCubit = context
                                .read<AdminAccountRequestsCubit>();
                            final errorMessage = await accountRequestsCubit
                                .approveRequest(
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
                              setState(() {
                                isSaving = false;
                                saveErrorMessage = errorMessage;
                              });
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
                              branchId: attendanceLocationType == 'branch'
                                  ? selectedBranchId
                                  : null,
                              siteId: attendanceLocationType == 'site'
                                  ? selectedSiteIds.isEmpty
                                        ? null
                                        : selectedSiteIds.first
                                  : null,
                              shiftId: selectedShiftId!,
                              attendanceLocationType: attendanceLocationType,
                              branchIds: attendanceLocationType == 'branch'
                                  ? {
                                      ...selectedBranchIds,
                                      selectedBranchId!,
                                    }.toList()
                                  : const [],
                              siteIds: attendanceLocationType == 'site'
                                  ? selectedSiteIds.toList()
                                  : const [],
                              phone: phoneController.text.trim().isNotEmpty
                                  ? phoneController.text.trim()
                                  : null,
                              email: emailController.text.trim().isNotEmpty
                                  ? emailController.text.trim()
                                  : null,
                              employeeCode:
                                  employeeCodeController.text.trim().isNotEmpty
                                  ? employeeCodeController.text.trim()
                                  : null,
                              canAddAttendance: canAddAttendance,
                              canAddPlan: canAddPlan,
                              workSystem: selectedWorkSystem,
                              remoteWorkPolicyId: selectedRemoteWorkPolicyId,
                              directManagerId: selectedDirectManagerId,
                              managerId: selectedDirectManagerId,
                            );

                            final employeesCubit = context
                                .read<AdminEmployeesCubit>();
                            final errorMessage = await employeesCubit
                                .addEmployee(addBody);
                            if (!mounted) return;
                            if (errorMessage == null) {
                              setState(() {
                                isSaving = false;
                                isCreated = true;
                              });
                            } else {
                              setState(() {
                                isSaving = false;
                                saveErrorMessage = errorMessage;
                              });
                            }
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
      ),
    );
  }
}
