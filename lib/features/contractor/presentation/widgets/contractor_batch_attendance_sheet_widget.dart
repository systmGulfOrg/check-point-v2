import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/app/app_spaces.dart';
import 'package:check_point_v2/core/di/service_locator.dart';
import 'package:check_point_v2/core/services/location_service.dart';
import 'package:check_point_v2/core/styles/app_colors.dart';
import 'package:check_point_v2/core/styles/app_text_styles.dart';
import 'package:check_point_v2/core/widgets/custom_button.dart';
import 'package:check_point_v2/core/widgets/custom_dialog_widget.dart';
import 'package:check_point_v2/features/contractor/data/models/contractor_batch_models.dart';
import 'package:check_point_v2/features/contractor/data/models/contractor_company_model.dart';
import 'package:check_point_v2/features/contractor/data/models/contractor_worker_model.dart';
import 'package:check_point_v2/features/contractor/data/models/site_boundary_model.dart';
import '../cubit/contractor_cubit.dart';

class ContractorBatchAttendanceSheetWidget extends StatefulWidget {
  const ContractorBatchAttendanceSheetWidget({
    required this.workers,
    required this.sites,
    required this.contractorId,
    this.contractors = const [],
    super.key,
  });

  final List<ContractorWorkerModel> workers;
  final List<SiteBoundaryModel> sites;
  final String contractorId;
  final List<ContractorCompanyModel> contractors;

  @override
  State<ContractorBatchAttendanceSheetWidget> createState() =>
      _ContractorBatchAttendanceSheetWidgetState();
}

class _ContractorBatchAttendanceSheetWidgetState
    extends State<ContractorBatchAttendanceSheetWidget> {
  final Set<String> _selectedWorkerIds = {};
  String? _selectedSiteId;
  String? _selectedContractorFilterId;
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    if (widget.sites.isNotEmpty) {
      _selectedSiteId = widget.sites.first.siteId;
    }
    if (widget.contractorId.isNotEmpty) {
      _selectedContractorFilterId = widget.contractorId;
    }
  }

  List<ContractorWorkerModel> get _filteredWorkers {
    return widget.workers.where((w) {
      if (_selectedContractorFilterId == null ||
          _selectedContractorFilterId!.isEmpty) {
        return true;
      }
      return w.contractorId == _selectedContractorFilterId;
    }).toList();
  }

  void _toggleSelectAll() {
    final filtered = _filteredWorkers;
    final allIds = filtered.map((w) => w.id).toSet();
    setState(() {
      if (_selectedWorkerIds.containsAll(allIds)) {
        _selectedWorkerIds.removeAll(allIds);
      } else {
        _selectedWorkerIds.addAll(allIds);
      }
    });
  }

  Future<void> _submitBatchAttendance() async {
    if (_selectedWorkerIds.isEmpty || _selectedSiteId == null) return;
    setState(() => _isSubmitting = true);

    final cubit = context.read<ContractorCubit>();
    final locationService = sl<LocationService>();
    final pos = await locationService.getCurrentPositionDetails();

    final today = DateTime.now().toIso8601String().split('T')[0];
    final effectiveContractorId = _selectedContractorFilterId?.isNotEmpty == true
        ? _selectedContractorFilterId!
        : (widget.contractorId.isNotEmpty
            ? widget.contractorId
            : (widget.workers
                    .firstWhere(
                      (w) => _selectedWorkerIds.contains(w.id),
                      orElse: () => widget.workers.first,
                    )
                    .contractorId ??
                ''));

    final summary = await cubit.recordSamcoBatchWorkerAttendance(
      siteId: _selectedSiteId!,
      contractorId: effectiveContractorId,
      date: today,
      workerIds: _selectedWorkerIds.toList(),
      latitude: pos?.latitude,
      longitude: pos?.longitude,
    );

    if (!mounted) return;
    setState(() => _isSubmitting = false);

    if (summary != null) {
      _showResultDialog(summary);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'تعذر تسجيل الحضور الجماعي، يرجى التحقق من الاتصال والمحاولة مرة أخرى',
          ),
          backgroundColor: AppColors.error,
        ),
      );
    }
  }

  void _showResultDialog(BatchWorkerAttendanceSummaryModel summary) {
    final hasFailures = summary.failedCount > 0;
    showDialog<void>(
      context: context,
      builder: (ctx) => CustomDialogWidget(
        title: hasFailures
            ? 'تقرير الحضور الجماعي (تنبيه تعارض)'
            : 'تم تسجيل الحضور الجماعي بنجاح',
        message: 'تم تسجيل: ${summary.successfulCount} عامل بنجاح.\n'
            'فشل تسجيل: ${summary.failedCount} عامل.\n\n'
            '${summary.results.where((r) => r.status == "REJECTED").map((r) => "• ${r.workerName ?? r.workerId}: ${r.errorMessage ?? 'تعارض موقع'}").join("\n")}',
        confirmLabel: 'core.actions.ok'.tr(context: ctx),
        onConfirm: () {
          Navigator.of(ctx).pop();
          Navigator.of(context).pop();
        },
        icon: hasFailures
            ? Icons.warning_amber_rounded
            : Icons.check_circle_outline_rounded,
        iconColor: hasFailures ? AppColors.warning : AppColors.success,
        confirmButtonColor:
            hasFailures ? AppColors.brandPrimary : AppColors.success,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final contractorNameMap = <String, String>{};
    for (final c in widget.contractors) {
      contractorNameMap[c.id] = c.name;
    }
    final filtered = _filteredWorkers;

    return Container(
      height: 0.88.sh,
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  'تسجيل الحضور الجماعي للعمالة',
                  style: AppTextStyles.font16Bold.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close_rounded),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          hSpace(8),
          DropdownButtonFormField<String>(
            isExpanded: true,
            initialValue: _selectedSiteId,
            decoration: InputDecoration(
              labelText: 'الموقع المخصص للتسجيل',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            items: widget.sites
                .map(
                  (s) => DropdownMenuItem<String>(
                    value: s.siteId,
                    child: Text(s.siteName),
                  ),
                )
                .toList(),
            onChanged: (val) => setState(() => _selectedSiteId = val),
          ),
          hSpace(10),
          if (widget.contractors.isNotEmpty) ...[
            DropdownButtonFormField<String?>(
              isExpanded: true,
              initialValue: _selectedContractorFilterId,
              decoration: InputDecoration(
                labelText: 'تصفية حسب المقاول التابع له',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              items: [
                const DropdownMenuItem<String?>(
                  value: null,
                  child: Text('جميع المقاولين'),
                ),
                ...widget.contractors.map(
                  (c) => DropdownMenuItem<String?>(
                    value: c.id,
                    child: Text('${c.name} (${c.code})'),
                  ),
                ),
              ],
              onChanged: (val) {
                setState(() {
                  _selectedContractorFilterId = val;
                  _selectedWorkerIds.clear();
                });
              },
            ),
            hSpace(10),
          ],
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  'المحدد: ${_selectedWorkerIds.length} من ${filtered.length}',
                  style: AppTextStyles.font13Medium.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
              TextButton(
                onPressed: _toggleSelectAll,
                child: Text(
                  filtered.isNotEmpty &&
                          _selectedWorkerIds.containsAll(
                            filtered.map((w) => w.id),
                          )
                      ? 'إلغاء تحديد الكل'
                      : 'تحديد الكل',
                  style: AppTextStyles.font13SemiBold.copyWith(
                    color: AppColors.brandPrimary,
                  ),
                ),
              ),
            ],
          ),
          const Divider(),
          Expanded(
            child: filtered.isEmpty
                ? Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 30.h),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.person_off_rounded,
                            size: 44.r,
                            color: AppColors.border,
                          ),
                          hSpace(8),
                          Text(
                            'لا توجد عمالة مسجلة تحت هذا التصنيف',
                            style: AppTextStyles.font13Medium.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : ListView.builder(
                    itemCount: filtered.length,
                    itemBuilder: (context, index) {
                      final worker = filtered[index];
                      final isSelected = _selectedWorkerIds.contains(worker.id);
                      final cName = worker.contractorName ??
                          contractorNameMap[worker.contractorId] ??
                          'غير محدد';

                      return CheckboxListTile(
                        value: isSelected,
                        title: Text(
                          worker.displayName,
                          style: AppTextStyles.font14Medium,
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            hSpace(2),
                            Text(
                              'كود: ${worker.displayCode} • ${worker.position ?? "عامل"}',
                              style: AppTextStyles.font12Regular.copyWith(
                                color: AppColors.textSecondary,
                              ),
                            ),
                            hSpace(4),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 8.w,
                                vertical: 2.h,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.softBrandBackground,
                                borderRadius: BorderRadius.circular(6.r),
                              ),
                              child: Text(
                                'المقاول: $cName',
                                style: AppTextStyles.font11Medium.copyWith(
                                  color: AppColors.brandPrimaryDark,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        activeColor: AppColors.brandPrimary,
                        onChanged: (checked) {
                          setState(() {
                            if (checked == true) {
                              _selectedWorkerIds.add(worker.id);
                            } else {
                              _selectedWorkerIds.remove(worker.id);
                            }
                          });
                        },
                      );
                    },
                  ),
          ),
          hSpace(12),
          CustomButton(
            text: 'تسجيل الحضور للمحددين (${_selectedWorkerIds.length})',
            isLoading: _isSubmitting,
            enabled: _selectedWorkerIds.isNotEmpty && _selectedSiteId != null,
            onTap: _submitBatchAttendance,
          ),
        ],
      ),
    );
  }
}
