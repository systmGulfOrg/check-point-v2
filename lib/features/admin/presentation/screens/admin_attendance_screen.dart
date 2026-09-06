import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/core.dart';
import '../cubit/admin_attendance_cubit.dart';
import '../cubit/admin_attendance_state.dart';
import '../widgets/admin_attendance_record_card_widget.dart';
import '../widgets/admin_attendance_record_data.dart';
import '../widgets/admin_requests_empty_state_widget.dart';

class AdminAttendanceScreen extends StatefulWidget {
  const AdminAttendanceScreen({super.key});

  @override
  State<AdminAttendanceScreen> createState() => _AdminAttendanceScreenState();
}

class _AdminAttendanceScreenState extends State<AdminAttendanceScreen> {
  final searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
              CustomTextFormField(
                controller: searchController,
                hintText: 'admin.attendance.searchHint'.tr(context: context),
                prefixIcon: Icon(Icons.search_rounded, size: 20.r),
                onChanged: (_) => setState(() {}),
              ),
              hSpace(14),
              BlocBuilder<AdminAttendanceCubit, AdminAttendanceState>(
                builder: (context, state) {
                  return state.when(
                    initial: () => const SizedBox.shrink(),
                    loading: () => const Center(
                      child: Padding(
                        padding: EdgeInsets.all(32),
                        child: CircularProgressIndicator(),
                      ),
                    ),
                    error: (messageKey) => Padding(
                      padding: EdgeInsets.all(24.r),
                      child: Center(
                        child: Text(
                          messageKey.tr(context: context),
                          style: AppTextStyles.font14Regular.copyWith(
                            color: AppColors.error,
                          ),
                        ),
                      ),
                    ),
                    actionSuccess: (_) => const SizedBox.shrink(),
                    success: (records) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'admin.attendance.count'.tr(
                            context: context,
                            args: ['${records.length}'],
                          ),
                          style: AppTextStyles.font12Regular,
                        ),
                        hSpace(10),
                        if (records.isEmpty)
                          const AdminRequestsEmptyStateWidget(
                            messageKey: 'admin.attendance.empty',
                          )
                        else
                          ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: records.length,
                            separatorBuilder: (_, _) => hSpace(10),
                            itemBuilder: (context, index) {
                              final item = records[index];
                              final recordData = AdminAttendanceRecordData(
                                initials:
                                    (item.employeeName?.isNotEmpty ?? false)
                                        ? item.employeeName![0]
                                        : 'E',
                                nameKey: item.employeeName ?? 'Employee',
                                time:
                                    '${item.attendanceDate ?? '-'} - In: ${item.clockInTime ?? '-'} Out: ${item.clockOutTime ?? '-'}',
                                branch: 'Area: ${item.area ?? '-'}',
                                statusKey: 'admin.attendance.status.onTime',
                                statusColor: AppColors.success,
                                statusBackgroundColor:
                                    AppColors.softGreenBackground,
                              );
                              return AdminAttendanceRecordCardWidget(
                                record: recordData,
                                onDelete: () {
                                  if (item.id != null) {
                                    context
                                        .read<AdminAttendanceCubit>()
                                        .deleteAttendance(item.id!);
                                  }
                                },
                              );
                            },
                          ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
