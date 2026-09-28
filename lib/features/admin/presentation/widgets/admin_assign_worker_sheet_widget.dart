import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/contractor/data/models/contractor_worker_model.dart';
import 'package:check_point_v2/features/contractor/presentation/cubit/contractor_cubit.dart';
import 'package:check_point_v2/features/contractor/presentation/cubit/contractor_state.dart';

class AdminAssignWorkerSheetWidget extends StatefulWidget {
  const AdminAssignWorkerSheetWidget({super.key});

  @override
  State<AdminAssignWorkerSheetWidget> createState() =>
      _AdminAssignWorkerSheetWidgetState();
}

class _AdminAssignWorkerSheetWidgetState
    extends State<AdminAssignWorkerSheetWidget> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _siteIdController;
  late final TextEditingController _validFromController;
  late final TextEditingController _validUntilController;
  ContractorWorkerModel? _selectedWorker;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _siteIdController = TextEditingController(text: 'site_ncc_01');
    final now = DateTime.now();
    _validFromController = TextEditingController(
      text: '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}',
    );
    final nextYear = now.add(const Duration(days: 365));
    _validUntilController = TextEditingController(
      text: '${nextYear.year}-${nextYear.month.toString().padLeft(2, '0')}-${nextYear.day.toString().padLeft(2, '0')}',
    );
  }

  @override
  void dispose() {
    _siteIdController.dispose();
    _validFromController.dispose();
    _validUntilController.dispose();
    super.dispose();
  }

  Future<void> _handleSave() async {
    if (!_formKey.currentState!.validate() || _selectedWorker == null) {
      if (_selectedWorker == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('admin.assignments.worker'.tr()),
            backgroundColor: AppColors.error,
          ),
        );
      }
      return;
    }

    setState(() => _isLoading = true);

    try {
      final body = {
        'workerId': _selectedWorker!.id,
        'branchId': _siteIdController.text.trim(),
        'validFrom': _validFromController.text.trim(),
        'validUntil': _validUntilController.text.trim(),
        'isActive': true,
      };

      final success = await context.read<ContractorCubit>().assignWorkerSite(body);
      if (mounted) {
        setState(() => _isLoading = false);
        if (success) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('admin.assignments.saveSuccess'.tr()),
              backgroundColor: AppColors.success,
            ),
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
                    'admin.assignments.newAssignment'.tr(),
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
              BlocBuilder<ContractorCubit, ContractorState>(
                builder: (context, state) {
                  final workers = state.mapOrNull(
                        success: (s) => s.workers,
                      ) ??
                      const [];

                  return Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 14.w,
                      vertical: 4.h,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.pageBackground,
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<ContractorWorkerModel>(
                        isExpanded: true,
                        hint: Text(
                          'admin.assignments.worker'.tr(),
                          style: AppTextStyles.font14Regular.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                        value: _selectedWorker,
                        items: workers.map((w) {
                          return DropdownMenuItem<ContractorWorkerModel>(
                            value: w,
                            child: Text(
                              '${w.fullName} (${w.workerCode} - ${w.nationalId})',
                              style: AppTextStyles.font14Regular.copyWith(
                                color: AppColors.textPrimary,
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (val) =>
                            setState(() => _selectedWorker = val),
                      ),
                    ),
                  );
                },
              ),
              hSpace(12),
              CustomTextFormField(
                hintText: 'admin.assignments.site'.tr(),
                controller: _siteIdController,
                validator: (val) =>
                    val == null || val.isEmpty ? 'field_required'.tr() : null,
              ),
              hSpace(12),
              Row(
                children: [
                  Expanded(
                    child: CustomTextFormField(
                      hintText: 'admin.assignments.validFrom'.tr(),
                      controller: _validFromController,
                    ),
                  ),
                  vSpace(12),
                  Expanded(
                    child: CustomTextFormField(
                      hintText: 'admin.assignments.validUntil'.tr(),
                      controller: _validUntilController,
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
