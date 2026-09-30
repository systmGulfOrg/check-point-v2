import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:check_point_v2/core/styles/app_colors.dart';
import 'package:check_point_v2/core/styles/app_text_styles.dart';
import 'package:check_point_v2/core/widgets/custom_button.dart';
import 'package:check_point_v2/features/contractor/data/models/contractor_attendance_model.dart';
import 'package:check_point_v2/core/app/app_spaces.dart';

class ContractorNewRequestSheetWidget extends StatefulWidget {
  const ContractorNewRequestSheetWidget({
    super.key,
    required this.attendance,
    required this.onSubmit,
  });

  final List<ContractorAttendanceModel> attendance;
  final Future<bool> Function(Map<String, dynamic> body) onSubmit;

  @override
  State<ContractorNewRequestSheetWidget> createState() =>
      _ContractorNewRequestSheetWidgetState();
}

class _ContractorNewRequestSheetWidgetState
    extends State<ContractorNewRequestSheetWidget> {
  String? _selectedAttendanceId;
  String _selectedReason = 'contractor.requests.reasonGps';

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final selectedAttendance = widget.attendance
        .where((item) => item.id == _selectedAttendanceId)
        .firstOrNull;
    final selectedId =
        selectedAttendance?.id ?? widget.attendance.firstOrNull?.id;
    return Padding(
      padding: EdgeInsets.only(
        left: 20.w,
        right: 20.w,
        top: 20.h,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20.h,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'contractor.requests.newRequest'.tr(),
                  style: AppTextStyles.font16Bold,
                ),
                IconButton(
                  icon: const Icon(Icons.close_rounded),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            hSpace(14),
            Text(
              'contractor.requests.workerName'.tr(),
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
                  value: selectedId,
                  hint: Text('contractor.requests.noAttendance'.tr()),
                  items: widget.attendance
                      .map(
                        (item) => DropdownMenuItem(
                          value: item.id,
                          child: Text(
                            '${item.workerName} (${item.workerCode})',
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (val) {
                    if (val != null) {
                      setState(() => _selectedAttendanceId = val);
                    }
                  },
                ),
              ),
            ),
            hSpace(12),
            Text(
              'contractor.requests.reason'.tr(),
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
                  value: _selectedReason,
                  items: [
                    DropdownMenuItem(
                      value: 'contractor.requests.reasonGps',
                      child: Text('contractor.requests.reasonGps'.tr()),
                    ),
                    DropdownMenuItem(
                      value: 'contractor.requests.reasonSite',
                      child: Text('contractor.requests.reasonSite'.tr()),
                    ),
                    DropdownMenuItem(
                      value: 'contractor.requests.reasonSupervisor',
                      child: Text('contractor.requests.reasonSupervisor'.tr()),
                    ),
                  ],
                  onChanged: (val) {
                    if (val != null) setState(() => _selectedReason = val);
                  },
                ),
              ),
            ),
            hSpace(20),
            CustomButton(
              text: 'contractor.requests.submit'.tr(),
              onTap: () async {
                final attendanceId = selectedId;
                if (attendanceId == null) return;
                final saved = await widget.onSubmit({
                  'attendanceId': attendanceId,
                  'reason': _selectedReason.tr(),
                });
                if (!context.mounted) return;
                if (saved) Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
