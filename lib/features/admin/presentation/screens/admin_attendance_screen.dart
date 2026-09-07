import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/core.dart';
import '../../data/models/admin_attendance_model.dart';
import '../cubit/admin_attendance_cubit.dart';
import '../cubit/admin_attendance_state.dart';
import '../widgets/admin_attendance_filter_bar_widget.dart';
import '../widgets/admin_attendance_record_card_widget.dart';
import '../widgets/admin_attendance_record_data.dart';
import '../widgets/admin_attendance_skeleton_widget.dart';
import '../widgets/admin_delete_confirmation_dialog_widget.dart';
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
                onChanged: context.read<AdminAttendanceCubit>().search,
              ),
              hSpace(14),
              const AdminAttendanceFilterBarWidget(),
              hSpace(14),
              BlocBuilder<AdminAttendanceCubit, AdminAttendanceState>(
                builder: (context, state) {
                  return state.when(
                    initial: () => const SizedBox.shrink(),
                    loading: () => const AdminAttendanceSkeletonWidget(),
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
                            separatorBuilder: (_, _) => hSpace(12),
                            itemBuilder: (context, index) {
                              final item = records[index];
                              final (statusKey, statusColor, statusBg) =
                                  _resolveStatus(item);
                              final initials =
                                  (item.employeeName?.trim().isNotEmpty ??
                                      false)
                                  ? item.employeeName!.trim()[0].toUpperCase()
                                  : 'E';
                              final recordData = AdminAttendanceRecordData(
                                initials: initials,
                                name:
                                    item.employeeName?.trim().isNotEmpty == true
                                    ? item.employeeName!
                                    : 'Employee',
                                date: _formatDate(item.attendanceDate),
                                checkIn: _formatTime(item.clockInTime),
                                checkOut: _formatTime(item.clockOutTime),
                                area: item.area?.trim().isNotEmpty == true
                                    ? item.area!
                                    : '-',
                                totalHours: _formatTotalHours(
                                  dayHours: item.dayHours,
                                  totalHours: item.totalHours,
                                  clockInTime: item.clockInTime,
                                  clockOutTime: item.clockOutTime,
                                ),
                                statusKey: statusKey,
                                statusColor: statusColor,
                                statusBackgroundColor: statusBg,
                              );
                              return AdminAttendanceRecordCardWidget(
                                record: recordData,
                                onDelete: () {
                                  if (item.id != null) {
                                    showDialog<void>(
                                      context: context,
                                      builder: (dialogContext) =>
                                          AdminDeleteConfirmationDialogWidget(
                                            title:
                                                'admin.attendance.deleteRecord'
                                                    .tr(context: context),
                                            message:
                                                'admin.attendance.deleteRecordMessage'
                                                    .tr(context: context),
                                            onConfirm: () {
                                              Navigator.pop(dialogContext);
                                              context
                                                  .read<AdminAttendanceCubit>()
                                                  .deleteAttendance(item.id!);
                                            },
                                          ),
                                    );
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

  String _formatDate(String? rawDate) {
    if (rawDate == null || rawDate.trim().isEmpty) return '-';
    if (rawDate.contains('T')) return rawDate.split('T').first;
    if (rawDate.contains(' ')) return rawDate.split(' ').first;
    return rawDate;
  }

  String _formatTime(String? rawTime) {
    if (rawTime == null ||
        rawTime.trim().isEmpty ||
        rawTime.startsWith('00:00:00') ||
        rawTime == '00:00') {
      return '--:--';
    }
    return rawTime.trim().split('.').first;
  }

  String _formatTotalHours({
    String? dayHours,
    dynamic totalHours,
    String? clockInTime,
    String? clockOutTime,
  }) {
    final raw = (dayHours != null && dayHours.trim().isNotEmpty)
        ? dayHours.trim()
        : totalHours?.toString().trim();

    if (raw != null && raw.isNotEmpty && raw != 'null') {
      if (raw.contains(':')) {
        final parts = raw.split(':');
        final hours = int.tryParse(parts[0]) ?? 0;
        final minutes = parts.length > 1 ? (int.tryParse(parts[1]) ?? 0) : 0;
        if (hours > 0 || minutes > 0) {
          if (hours > 0 && minutes > 0) {
            return '${hours}h ${minutes}m';
          } else if (hours > 0) {
            return '${hours}h';
          } else {
            return '${minutes}m';
          }
        }
      } else {
        final numValue = double.tryParse(raw);
        if (numValue != null && numValue > 0) {
          final hours = numValue.floor();
          final minutes = ((numValue - hours) * 60).round();
          if (hours > 0 && minutes > 0) {
            return '${hours}h ${minutes}m';
          } else if (hours > 0) {
            return '${hours}h';
          } else {
            return '${minutes}m';
          }
        }
      }
    }

    if (clockInTime != null &&
        clockOutTime != null &&
        clockInTime.isNotEmpty &&
        clockOutTime.isNotEmpty &&
        !clockInTime.startsWith('00:00') &&
        !clockOutTime.startsWith('00:00')) {
      try {
        final inParts = clockInTime.split(':');
        final outParts = clockOutTime.split(':');
        if (inParts.length >= 2 && outParts.length >= 2) {
          final inMinutes =
              (int.tryParse(inParts[0]) ?? 0) * 60 +
              (int.tryParse(inParts[1]) ?? 0);
          final outMinutes =
              (int.tryParse(outParts[0]) ?? 0) * 60 +
              (int.tryParse(outParts[1]) ?? 0);
          final diff = outMinutes - inMinutes;
          if (diff > 0) {
            final h = diff ~/ 60;
            final m = diff % 60;
            if (h > 0 && m > 0) {
              return '${h}h ${m}m';
            } else if (h > 0) {
              return '${h}h';
            } else {
              return '${m}m';
            }
          }
        }
      } catch (_) {}
    }

    return '--';
  }

  (String, Color, Color) _resolveStatus(AdminAttendanceModel item) {
    if (item.isLate == true) {
      return (
        'admin.attendance.status.late',
        AppColors.warningOrange,
        AppColors.softYellowBackground,
      );
    }
    if (item.isEarly == true) {
      return (
        'admin.attendance.status.earlyCheckout',
        AppColors.info,
        AppColors.softBlueBackground,
      );
    }
    return (
      'admin.attendance.status.onTime',
      AppColors.success,
      AppColors.softGreenBackground,
    );
  }
}
