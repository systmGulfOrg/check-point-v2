import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import 'admin_attendance_record_card_widget.dart';
import 'admin_attendance_record_data.dart';

class AdminAttendanceRecordsListWidget extends StatelessWidget {
  const AdminAttendanceRecordsListWidget({
    required this.records,
    this.onEdit,
    this.onDelete,
    super.key,
  });

  final List<AdminAttendanceRecordData> records;
  final ValueChanged<AdminAttendanceRecordData>? onEdit;
  final ValueChanged<AdminAttendanceRecordData>? onDelete;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: records.length,
      separatorBuilder: (_, _) => hSpace(10),
      itemBuilder: (_, index) {
        final record = records[index];
        return AnimatedListItemWidget(
          index: index,
          child: AdminAttendanceRecordCardWidget(
            record: record,
            onEdit: () => onEdit?.call(record),
            onDelete: () => onDelete?.call(record),
          ),
        );
      },
    );
  }
}
