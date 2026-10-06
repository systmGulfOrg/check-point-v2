import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/app/app_spaces.dart';
import 'package:check_point_v2/core/services/location_service.dart';
import 'package:check_point_v2/core/styles/app_colors.dart';
import 'package:check_point_v2/core/styles/app_text_styles.dart';
import 'package:check_point_v2/core/widgets/custom_button.dart';
import 'package:check_point_v2/core/widgets/custom_dialog_widget.dart';
import 'package:check_point_v2/features/contractor/data/models/contractor_batch_models.dart';
import 'package:check_point_v2/features/contractor/data/models/contractor_worker_model.dart';
import 'package:check_point_v2/features/contractor/data/models/site_boundary_model.dart';
import '../cubit/contractor_cubit.dart';

class ContractorBatchAttendanceSheetWidget extends StatefulWidget {
  const ContractorBatchAttendanceSheetWidget({
    required this.workers,
    required this.sites,
    required this.contractorId,
    super.key,
  });

  final List<ContractorWorkerModel> workers;
  final List<SiteBoundaryModel> sites;
  final String contractorId;

  @override
  State<ContractorBatchAttendanceSheetWidget> createState() =>
      _ContractorBatchAttendanceSheetWidgetState();
}

class _ContractorBatchAttendanceSheetWidgetState
    extends State<ContractorBatchAttendanceSheetWidget> {
  final Set<String> _selectedWorkerIds = {};
  String? _selectedSiteId;
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    if (widget.sites.isNotEmpty) {
      _selectedSiteId = widget.sites.first.siteId;
    }
  }

  void _toggleSelectAll() {
    setState(() {
      if (_selectedWorkerIds.length == widget.workers.length) {
        _selectedWorkerIds.clear();
      } else {
        _selectedWorkerIds.addAll(widget.workers.map((w) => w.id));
      }
    });
  }

  Future<void> _submitBatchAttendance() async {
    if (_selectedWorkerIds.isEmpty || _selectedSiteId == null) return;
    setState(() => _isSubmitting = true);

    final cubit = context.read<ContractorCubit>();
    final locationService = context.read<LocationService>();
    final pos = await locationService.getCurrentPositionDetails();

    final today = DateFormat('yyyy-MM-dd').format(DateTime.now());
    final summary = await cubit.recordSamcoBatchWorkerAttendance(
      siteId: _selectedSiteId!,
      contractorId: widget.contractorId,
      date: today,
      workerIds: _selectedWorkerIds.toList(),
      latitude: pos?.latitude,
      longitude: pos?.longitude,
    );

    if (!mounted) return;
    setState(() => _isSubmitting = false);

    if (summary != null) {
      _showResultDialog(summary);
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
        icon: hasFailures ? Icons.warning_amber_rounded : Icons.check_circle_outline_rounded,
        iconColor: hasFailures ? AppColors.warning : AppColors.success,
        confirmButtonColor: hasFailures ? AppColors.brandPrimary : AppColors.success,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 0.85.sh,
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
              labelText: 'الموقع المخصص',
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
          hSpace(12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'المحدد: ${_selectedWorkerIds.length} من ${widget.workers.length}',
                style: AppTextStyles.font13Medium.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              TextButton(
                onPressed: _toggleSelectAll,
                child: Text(
                  _selectedWorkerIds.length == widget.workers.length
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
            child: ListView.builder(
              itemCount: widget.workers.length,
              itemBuilder: (context, index) {
                final worker = widget.workers[index];
                final isSelected = _selectedWorkerIds.contains(worker.id);
                return CheckboxListTile(
                  value: isSelected,
                  title: Text(worker.displayName, style: AppTextStyles.font14Medium),
                  subtitle: Text(
                    'كود: ${worker.displayCode} • ${worker.position ?? "عامل"}',
                    style: AppTextStyles.font12Regular.copyWith(
                      color: AppColors.textSecondary,
                    ),
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
