import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/core.dart';
import '../../../admin/data/models/admin_attendance_model.dart';
import 'supervisor_attendance_record_row_widget.dart';

class SupervisorAttendanceListWidget extends StatelessWidget {
  const SupervisorAttendanceListWidget({required this.records, super.key});

  final List<AdminAttendanceModel> records;

  @override
  Widget build(BuildContext context) {
    if (records.isEmpty) {
      return Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 36.h),
          child: Text(
            'supervisor.attendance.empty'.tr(context: context),
            style: AppTextStyles.font14Regular.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ),
      );
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: records.length,
      separatorBuilder: (_, _) => hSpace(10),
      itemBuilder: (context, index) => AnimatedListItemWidget(
        index: index,
        child: SupervisorAttendanceRecordRowWidget(record: records[index]),
      ),
    );
  }
}
