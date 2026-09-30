import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/contractor/data/models/contractor_company_model.dart';
import 'package:check_point_v2/features/contractor/presentation/cubit/contractor_cubit.dart';

class AdminAddContractorSheetWidget extends StatefulWidget {
  const AdminAddContractorSheetWidget({super.key});

  @override
  State<AdminAddContractorSheetWidget> createState() =>
      _AdminAddContractorSheetWidgetState();
}

class _AdminAddContractorSheetWidgetState
    extends State<AdminAddContractorSheetWidget> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _codeController;
  late final TextEditingController _taxNumberController;
  late final TextEditingController _commercialRegController;
  late final TextEditingController _contactNameController;
  late final TextEditingController _contactPhoneController;
  late final TextEditingController _contactEmailController;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _codeController = TextEditingController();
    _taxNumberController = TextEditingController();
    _commercialRegController = TextEditingController();
    _contactNameController = TextEditingController();
    _contactPhoneController = TextEditingController();
    _contactEmailController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _codeController.dispose();
    _taxNumberController.dispose();
    _commercialRegController.dispose();
    _contactNameController.dispose();
    _contactPhoneController.dispose();
    _contactEmailController.dispose();
    super.dispose();
  }

  Future<void> _handleSave() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);

    try {
      final model = ContractorCompanyModel(
        id: 'ctr_${DateTime.now().millisecondsSinceEpoch}',
        code: _codeController.text.trim().toUpperCase(),
        name: _nameController.text.trim(),
        taxNumber: _taxNumberController.text.trim(),
        commercialReg: _commercialRegController.text.trim(),
        contactName: _contactNameController.text.trim(),
        contactPhone: _contactPhoneController.text.trim(),
        contactEmail: _contactEmailController.text.trim(),
        status: 'active',
      );

      final success = await context.read<ContractorCubit>().addContractor(model);
      if (mounted) {
        setState(() => _isLoading = false);
        if (success) {
          Navigator.pop(context);
          CustomSnackBar.showSuccess(
            context,
            message: 'admin.contractors.saveSuccess'.tr(),
          );
        }
      }
    } catch (_) {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      padding: EdgeInsets.fromLTRB(
        20.w,
        16.h,
        20.w,
        16.h + MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Container(
                  width: 40.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: AppColors.border,
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
              ),
              hSpace(16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'admin.contractors.addContractor'.tr(),
                    style: AppTextStyles.font16Bold.copyWith(
                      color: AppColors.textPrimary,
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close_rounded),
                    color: AppColors.textSecondary,
                  ),
                ],
              ),
              hSpace(16),
              CustomTextFormField(
                hintText: 'contractor.company.name'.tr(),
                controller: _nameController,
                validator: (val) =>
                    val == null || val.isEmpty ? 'field_required'.tr() : null,
              ),
              hSpace(12),
              Row(
                children: [
                  Expanded(
                    child: CustomTextFormField(
                      hintText: 'admin.contractors.code'.tr(),
                      controller: _codeController,
                      validator: (val) =>
                          val == null || val.isEmpty ? 'field_required'.tr() : null,
                    ),
                  ),
                  vSpace(12),
                  Expanded(
                    child: CustomTextFormField(
                      hintText: 'admin.contractors.taxNumber'.tr(),
                      controller: _taxNumberController,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
              hSpace(12),
              CustomTextFormField(
                hintText: 'admin.contractors.commercialReg'.tr(),
                controller: _commercialRegController,
              ),
              hSpace(12),
              CustomTextFormField(
                hintText: 'admin.contractors.contactName'.tr(),
                controller: _contactNameController,
                validator: (val) =>
                    val == null || val.isEmpty ? 'field_required'.tr() : null,
              ),
              hSpace(12),
              Row(
                children: [
                  Expanded(
                    child: CustomTextFormField(
                      hintText: 'admin.contractors.phone'.tr(),
                      controller: _contactPhoneController,
                      keyboardType: TextInputType.phone,
                    ),
                  ),
                  vSpace(12),
                  Expanded(
                    child: CustomTextFormField(
                      hintText: 'admin.contractors.email'.tr(),
                      controller: _contactEmailController,
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ),
                ],
              ),
              hSpace(24),
              CustomButton(
                text: 'save'.tr(),
                isLoading: _isLoading,
                onTap: _handleSave,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
