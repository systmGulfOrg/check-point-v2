import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/core.dart';
import '../widgets/admin_attendance_action_sheet_widget.dart';
import '../widgets/admin_attendance_filter_widget.dart';
import '../widgets/admin_attendance_record_data.dart';
import '../widgets/admin_attendance_records_list_widget.dart';
import '../widgets/admin_manual_attendance_sheet_widget.dart';
import '../widgets/admin_requests_empty_state_widget.dart';

class AdminAttendanceScreen extends StatefulWidget {
  const AdminAttendanceScreen({super.key});

  @override
  State<AdminAttendanceScreen> createState() => _AdminAttendanceScreenState();
}

class _AdminAttendanceScreenState extends State<AdminAttendanceScreen> {
  final searchController = TextEditingController();
  String selectedFilter = 'all';
  bool isFilterOpen = false;

  static const records = <AdminAttendanceRecordData>[
    AdminAttendanceRecordData(
      initials: 'PN',
      nameKey: 'supervisor.attendance.members.priya',
      time: '2026-09-01 - In 09:00',
      branch: 'Branch: -',
      statusKey: 'admin.attendance.status.edited',
      statusColor: AppColors.warningOrange,
      statusBackgroundColor: AppColors.softYellowBackground,
    ),
    AdminAttendanceRecordData(
      initials: 'JM',
      nameKey: 'supervisor.attendance.members.james',
      time: '2026-09-01 - In 08:02',
      branch: 'Branch: Headquarters',
      statusKey: 'admin.attendance.status.onTime',
      statusColor: AppColors.success,
      statusBackgroundColor: AppColors.softGreenBackground,
    ),
    AdminAttendanceRecordData(
      initials: 'FA',
      nameKey: 'supervisor.attendance.members.fatima',
      time: '2026-09-01 - In 07:58',
      branch: 'Branch: Headquarters',
      statusKey: 'admin.attendance.status.onTime',
      statusColor: AppColors.success,
      statusBackgroundColor: AppColors.softGreenBackground,
    ),
  ];

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filteredRecords = selectedFilter == 'absent'
        ? <AdminAttendanceRecordData>[]
        : records;
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        title: Text(
          'admin.attendance.title'.tr(context: context),
          style: AppTextStyles.font18Bold,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(16.w, 4.h, 16.w, 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: CustomTextFormField(
                      controller: searchController,
                      hintText: 'admin.attendance.searchHint'.tr(
                        context: context,
                      ),
                      prefixIcon: Icon(Icons.search_rounded, size: 20.r),
                    ),
                  ),
                  vSpace(8),
                  IconButton(
                    onPressed: () =>
                        setState(() => isFilterOpen = !isFilterOpen),
                    style: IconButton.styleFrom(
                      backgroundColor: isFilterOpen
                          ? AppColors.softBlueBackground
                          : AppColors.pageBackground,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                        side: const BorderSide(color: AppColors.border),
                      ),
                    ),
                    icon: Icon(Icons.filter_alt_outlined, size: 20.r),
                  ),
                  SizedBox(
                    width: 44.w,
                    height: 44.h,
                    child: IconButton(
                      onPressed: () => showModalBottomSheet<void>(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: AppColors.cardBackground,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(20),
                          ),
                        ),
                        builder: (_) =>
                            const AdminManualAttendanceSheetWidget(),
                      ),
                      style: IconButton.styleFrom(
                        backgroundColor: AppColors.brandPrimary,
                        foregroundColor: AppColors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      icon: Icon(Icons.add_rounded, size: 24.r),
                    ),
                  ),
                ],
              ),
              if (isFilterOpen) ...[
                hSpace(8),
                SizedBox(
                  width: 126.w,
                  child: CustomTextFormField(
                    hintText: 'admin.attendance.dateHint'.tr(context: context),
                    suffixIcon: Icon(Icons.calendar_today_outlined, size: 16.r),
                  ),
                ),
                hSpace(10),
                AdminAttendanceFilterWidget(
                  selectedFilter: selectedFilter,
                  onSelected: (filter) =>
                      setState(() => selectedFilter = filter),
                ),
              ],
              hSpace(12),
              Text(
                'admin.attendance.count'.tr(
                  context: context,
                  args: ['${filteredRecords.length}'],
                ),
                style: AppTextStyles.font12Regular,
              ),
              hSpace(10),
              if (filteredRecords.isEmpty)
                const AdminRequestsEmptyStateWidget(
                  messageKey: 'admin.attendance.empty',
                )
              else
                AdminAttendanceRecordsListWidget(
                  records: filteredRecords,
                  onEdit: (record) => showModalBottomSheet<void>(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: AppColors.cardBackground,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                    ),
                    builder: (_) => AdminAttendanceActionSheetWidget(
                      record: record,
                      action: AdminAttendanceAction.edit,
                    ),
                  ),
                  onDelete: (record) => showModalBottomSheet<void>(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: AppColors.cardBackground,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                    ),
                    builder: (_) => AdminAttendanceActionSheetWidget(
                      record: record,
                      action: AdminAttendanceAction.delete,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
