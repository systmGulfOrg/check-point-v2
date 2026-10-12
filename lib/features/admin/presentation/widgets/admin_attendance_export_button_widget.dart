import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import 'package:check_point_v2/core/styles/app_colors.dart';
import 'package:check_point_v2/features/admin/data/models/attendance/admin_attendance_model.dart';

class AdminAttendanceExportButtonWidget extends StatefulWidget {
  const AdminAttendanceExportButtonWidget({
    required this.attendanceRecords,
    super.key,
  });

  final List<AdminAttendanceModel> attendanceRecords;

  @override
  State<AdminAttendanceExportButtonWidget> createState() =>
      _AdminAttendanceExportButtonWidgetState();
}

class _AdminAttendanceExportButtonWidgetState
    extends State<AdminAttendanceExportButtonWidget> {
  bool _isExporting = false;

  String _generateCsv() {
    final buffer = StringBuffer();
    // CSV Header (UTF-8 BOM for Excel Arabic support)
    buffer.writeln(
      'التاريخ,اسم الموظف,كود الموظف,القسم,الموقع,وقت الحضور,وقت الانصراف,الحالة,دقائق التأخير',
    );

    for (final item in widget.attendanceRecords) {
      final date = item.attendanceDate?.split('T').first ?? '-';
      final name = (item.employeeName ?? '-').replaceAll(',', ' ');
      final code = (item.employeeId ?? '-').replaceAll(',', ' ');
      final area = (item.area ?? '-').replaceAll(',', ' ');
      final customer = (item.customerName ?? '-').replaceAll(',', ' ');
      final clockIn = item.clockInTime ?? '-';
      final clockOut = item.clockOutTime ?? '-';
      final status = item.status ?? (item.isLate == true ? 'متأخر' : 'منضبط');
      final hours = item.totalHours?.toString() ?? item.dayHours ?? '-';

      buffer.writeln(
        '$date,$name,$code,$area,$customer,$clockIn,$clockOut,$status,$hours',
      );
    }

    return buffer.toString();
  }

  Future<void> _export() async {
    if (widget.attendanceRecords.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('admin.attendance.exportEmpty'.tr(context: context)),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }

    setState(() => _isExporting = true);
    try {
      final directory = await getTemporaryDirectory();
      final dateStr = DateFormat('yyyy-MM-dd').format(DateTime.now());
      final file = File('${directory.path}/samco-attendance-$dateStr.csv');
      await file.writeAsString('\ufeff${_generateCsv()}');

      if (!mounted) return;
      await Share.shareXFiles(
        [XFile(file.path, mimeType: 'text/csv')],
        subject: 'تقرير حضور وانصراف سامكو - $dateStr',
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('حدث خطأ أثناء تصدير التقرير: $e'),
          backgroundColor: AppColors.error,
        ),
      );
    } finally {
      if (mounted) {
        setState(() => _isExporting = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: _isExporting ? null : _export,
      tooltip: 'admin.attendance.exportExcel'.tr(context: context),
      icon: _isExporting
          ? SizedBox(
              width: 18.r,
              height: 18.r,
              child: const CircularProgressIndicator(
                strokeWidth: 2,
                color: AppColors.brandPrimary,
              ),
            )
          : Icon(
              Icons.file_download_outlined,
              size: 22.r,
              color: AppColors.textPrimary,
            ),
    );
  }
}
