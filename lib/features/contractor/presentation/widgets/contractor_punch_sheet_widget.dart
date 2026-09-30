import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/styles/app_colors.dart';
import 'package:check_point_v2/core/styles/app_text_styles.dart';
import 'package:check_point_v2/features/contractor/data/models/contractor_worker_model.dart';
import 'package:check_point_v2/features/contractor/data/models/worker_site_assignment_model.dart';

class ContractorPunchSheetWidget extends StatefulWidget {
  const ContractorPunchSheetWidget({
    required this.workers,
    required this.assignments,
    required this.onPunch,
    super.key,
  });

  final List<ContractorWorkerModel> workers;
  final List<WorkerSiteAssignmentModel> assignments;
  final Future<void> Function(String workerId, String siteId) onPunch;

  @override
  State<ContractorPunchSheetWidget> createState() =>
      _ContractorPunchSheetWidgetState();
}

class _ContractorPunchSheetWidgetState extends State<ContractorPunchSheetWidget> {
  String? selectedWorkerId;

  @override
  Widget build(BuildContext context) {
    final workerId = selectedWorkerId ??
        (widget.workers.isNotEmpty ? widget.workers.first.id : null);
    final assignments = widget.assignments
        .where((item) => item.workerId == workerId && item.isActive)
        .toList();
    final assignment = assignments.isEmpty ? null : assignments.first;

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.fromLTRB(16.w, 18.h, 16.w, 24.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('contractor.punch.title'.tr(), style: AppTextStyles.font18Bold),
            SizedBox(height: 16.h),
            DropdownButtonFormField<String>(
              initialValue: workerId,
              decoration: InputDecoration(
                labelText: 'contractor.punch.worker'.tr(),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              items: widget.workers
                  .map(
                    (worker) => DropdownMenuItem<String>(
                      value: worker.id,
                      child: Text('${worker.fullName} (${worker.workerCode})'),
                    ),
                  )
                  .toList(),
              onChanged: (value) => setState(() => selectedWorkerId = value),
            ),
            SizedBox(height: 12.h),
            if (assignment == null)
              Text(
                'contractor.punch.noAssignment'.tr(),
                style: AppTextStyles.font13Regular.copyWith(
                  color: AppColors.error,
                ),
              )
            else
              Text(
                '${'contractor.punch.site'.tr()}: ${assignment.siteName}',
                style: AppTextStyles.font13Medium,
              ),
            SizedBox(height: 18.h),
            ElevatedButton.icon(
              onPressed: assignment == null || workerId == null
                  ? null
                  : () async {
                      await widget.onPunch(workerId, assignment.branchId);
                      if (context.mounted) Navigator.pop(context);
                    },
              icon: const Icon(Icons.location_on_outlined),
              label: Text('contractor.punch.submit'.tr()),
            ),
          ],
        ),
      ),
    );
  }
}
