import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:check_point_v2/core/styles/app_colors.dart';
import 'package:check_point_v2/core/styles/app_text_styles.dart';
import 'package:check_point_v2/core/widgets/custom_button.dart';
import 'package:check_point_v2/core/widgets/custom_text_form_field.dart';
import 'package:check_point_v2/features/contractor/data/models/site_boundary_model.dart';
import '../cubit/contractor_cubit.dart';
import 'package:check_point_v2/core/utils/egyptian_national_id_parser.dart';
import 'package:check_point_v2/features/identity/presentation/widgets/national_id_capture_widget.dart';
import 'package:check_point_v2/features/identity/presentation/widgets/national_id_ocr_listener_widget.dart';
import 'package:check_point_v2/core/app/app_spaces.dart';
import 'package:check_point_v2/core/utils/code_generator_helper.dart';

class ContractorAddWorkerScreen extends StatefulWidget {
  const ContractorAddWorkerScreen({super.key});
  @override
  State<ContractorAddWorkerScreen> createState() =>
      _ContractorAddWorkerScreenState();
}

class _ContractorAddWorkerScreenState extends State<ContractorAddWorkerScreen> {
  late final TextEditingController fullNameController;
  late final TextEditingController nationalIdController;
  late final TextEditingController phoneController;
  late final TextEditingController jobTitleController;
  late final TextEditingController workerCodeController;
  String? selectedSiteId;

  @override
  void initState() {
    super.initState();
    fullNameController = TextEditingController();
    nationalIdController = TextEditingController();
    phoneController = TextEditingController();
    jobTitleController = TextEditingController();
    workerCodeController = TextEditingController(
      text: CodeGeneratorHelper.generateWorkerCode(),
    );
  }

  @override
  void dispose() {
    fullNameController.dispose();
    nationalIdController.dispose();
    phoneController.dispose();
    jobTitleController.dispose();
    workerCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sites = context.select<ContractorCubit, List<SiteBoundaryModel>>(
      (cubit) =>
          cubit.state.mapOrNull(success: (value) => value.sites) ?? const [],
    );
    final contractorId = context.select<ContractorCubit, String?>(
      (cubit) => cubit.state.mapOrNull(
        success: (value) =>
            value.contractors.isNotEmpty ? value.contractors.first.id : null,
      ),
    );
    final effectiveSiteId = sites.any((site) => site.siteId == selectedSiteId)
        ? selectedSiteId
        : null;

    return NationalIdOcrListenerWidget(
      onDetected: (result) {
        nationalIdController
          ..text = result.nationalId
          ..selection = TextSelection.collapsed(
            offset: result.nationalId.length,
          );
        if (result.fullName != null && result.fullName!.isNotEmpty) {
          fullNameController.text = result.fullName!;
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('identity.nationalIdDetected'.tr())),
        );
      },
      onFailure: (message) => ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(message))),
      child: Scaffold(
        backgroundColor: AppColors.pageBackground,
        appBar: AppBar(
          title: Text(
            'contractor.workers.addWorkerTitle'.tr(),
            style: AppTextStyles.font16Bold.copyWith(
              color: AppColors.textPrimary,
            ),
          ),
          backgroundColor: AppColors.cardBackground,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(16.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'contractor.workers.fullName'.tr(),
                style: AppTextStyles.font13SemiBold,
              ),
              hSpace(6),
              CustomTextFormField(
                controller: fullNameController,
                hintText: 'contractor.workers.fullName'.tr(),
                prefixIcon: const Icon(Icons.person_outline_rounded),
              ),
              hSpace(14),
              NationalIdCaptureWidget(controller: nationalIdController),
              Builder(
                builder: (context) {
                  final info = EgyptianNationalIdParser.parse(
                    nationalIdController.text,
                  );
                  if (!info.isValid) return const SizedBox.shrink();
                  return Container(
                    margin: EdgeInsets.only(top: 8.h),
                    padding: EdgeInsets.all(10.r),
                    decoration: BoxDecoration(
                      color: AppColors.softBlueBackground,
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(
                        color: AppColors.brandPrimary.withValues(alpha: 0.2),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        if (info.birthDate != null)
                          Text(
                            'الميلاد: ${info.birthDate}',
                            style: AppTextStyles.font11Regular.copyWith(
                              color: AppColors.textPrimary,
                            ),
                          ),
                        if (info.governorate != null)
                          Text(
                            'المحافظة: ${info.governorate}',
                            style: AppTextStyles.font11Regular.copyWith(
                              color: AppColors.textPrimary,
                            ),
                          ),
                        if (info.gender != null)
                          Text(
                            'النوع: ${info.gender == "Male" ? "ذكر" : "أنثى"}',
                            style: AppTextStyles.font11Regular.copyWith(
                              color: AppColors.textPrimary,
                            ),
                          ),
                      ],
                    ),
                  );
                },
              ),
              hSpace(14),
              Text(
                'contractor.workers.phone'.tr(),
                style: AppTextStyles.font13SemiBold,
              ),
              hSpace(6),
              CustomTextFormField(
                controller: phoneController,
                hintText: 'contractor.workers.phone'.tr(),
                prefixIcon: const Icon(Icons.phone_outlined),
                keyboardType: TextInputType.phone,
              ),
              hSpace(14),
              Text(
                'contractor.workers.jobTitle'.tr(),
                style: AppTextStyles.font13SemiBold,
              ),
              hSpace(6),
              CustomTextFormField(
                controller: jobTitleController,
                hintText: 'contractor.workers.jobTitle'.tr(),
                prefixIcon: const Icon(Icons.engineering_outlined),
              ),
              hSpace(14),
              Text(
                'contractor.workers.workerCode'.tr(),
                style: AppTextStyles.font13SemiBold,
              ),
              hSpace(6),
              CustomTextFormField(
                controller: workerCodeController,
                hintText: 'contractor.workers.workerCode'.tr(),
                prefixIcon: const Icon(Icons.qr_code_rounded),
                suffixIcon: IconButton(
                  icon: const Icon(
                    Icons.refresh_rounded,
                    color: AppColors.brandPrimary,
                  ),
                  onPressed: () {
                    setState(() {
                      workerCodeController.text =
                          CodeGeneratorHelper.generateWorkerCode();
                    });
                  },
                ),
              ),
              hSpace(14),
              Text(
                'contractor.workers.assignedSite'.tr(),
                style: AppTextStyles.font13SemiBold,
              ),
              hSpace(6),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                decoration: BoxDecoration(
                  color: AppColors.cardBackground,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: AppColors.border),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    isExpanded: true,
                    value: effectiveSiteId,
                    hint: Text('contractor.workers.assignedSite'.tr()),
                    items: sites
                        .map(
                          (site) => DropdownMenuItem<String>(
                            value: site.siteId,
                            child: Text(site.siteName),
                          ),
                        )
                        .toList(),
                    onChanged: (value) =>
                        setState(() => selectedSiteId = value),
                  ),
                ),
              ),
              hSpace(30),
              CustomButton(
                text: 'contractor.workers.saveWorker'.tr(),
                enabled: contractorId != null,
                onTap: () async {
                  if (fullNameController.text.trim().isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('contractor.workers.fullName'.tr()),
                      ),
                    );
                    return;
                  }
                  final saved = await context.read<ContractorCubit>().addWorker(
                    contractorId: contractorId!,
                    body: {
                      'name': fullNameController.text.trim(),
                      'nationalId': nationalIdController.text.trim().isEmpty
                          ? null
                          : nationalIdController.text.trim(),
                      'phone': phoneController.text.trim().isEmpty
                          ? null
                          : phoneController.text.trim(),
                      'position': jobTitleController.text.trim().isEmpty
                          ? null
                          : jobTitleController.text.trim(),
                      'employeeCode': workerCodeController.text.trim().isEmpty
                          ? null
                          : workerCodeController.text.trim(),
                      'branchId': effectiveSiteId,
                    },
                  );
                  if (!context.mounted) return;
                  if (saved) Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
