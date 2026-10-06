import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/core/di/service_locator.dart';
import 'package:check_point_v2/features/admin/data/models/employee/employee_model.dart';
import 'package:check_point_v2/features/admin/data/models/attendance/admin_attendance_model.dart';
import 'package:check_point_v2/features/employee/presentation/cubit/details/employee_details_cubit.dart';
import 'package:flutter/services.dart';
import 'package:check_point_v2/features/employee/presentation/cubit/details/employee_details_state.dart';
import 'employee_details_chart_widget.dart';

class EmployeeDetailsSheetWidget extends StatelessWidget {
  const EmployeeDetailsSheetWidget({required this.employee, super.key});

  final EmployeeModel employee;

  static Future<void> show(BuildContext context, EmployeeModel employee) async {
    final employeeId = employee.id;
    if (employeeId == null || employeeId.isEmpty) return;
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      constraints: BoxConstraints(
        maxHeight: MediaQuery.sizeOf(context).height * 0.92,
      ),
      backgroundColor: AppColors.cardBackground,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      builder: (_) => BlocProvider(
        create: (_) => sl<EmployeeDetailsCubit>()..load(employeeId),
        child: EmployeeDetailsSheetWidget(employee: employee),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 24.h),
        child: BlocBuilder<EmployeeDetailsCubit, EmployeeDetailsState>(
          builder: (context, state) => switch (state) {
            EmployeeDetailsInitial() || EmployeeDetailsLoading() => SizedBox(
              height: 360.h,
              child: const Center(child: CircularProgressIndicator()),
            ),
            EmployeeDetailsError(:final messageKey) =>
              EmployeeDetailsMessageWidget(
                message: messageKey.tr(context: context),
              ),
            EmployeeDetailsSuccess(
              :final employee,
              :final attendance,
              :final selectedMonth,
              :final attendedDays,
              :final absentDays,
              :final lateDays,
              :final earlyLeaveDays,
              :final totalHours,
            ) =>
              EmployeeDetailsContentWidget(
                employee: employee,
                attendance: attendance,
                selectedMonth: selectedMonth,
                attendedDays: attendedDays,
                absentDays: absentDays,
                lateDays: lateDays,
                devicesHistory: state.devicesHistory,
                earlyLeaveDays: earlyLeaveDays,
                totalHours: totalHours,
              ),
            _ => const SizedBox.shrink(),
          },
        ),
      ),
    );
  }
}

class EmployeeDetailsContentWidget extends StatelessWidget {
  const EmployeeDetailsContentWidget({
    required this.employee,
    required this.attendance,
    required this.selectedMonth,
    required this.attendedDays,
    required this.absentDays,
    required this.lateDays,
    required this.earlyLeaveDays,
    required this.totalHours,
    required this.devicesHistory,
    super.key,
  });

  final EmployeeModel employee;
  final List<AdminAttendanceModel> attendance;
  final DateTime selectedMonth;
  final int attendedDays;
  final int absentDays;
  final int lateDays;
  final int earlyLeaveDays;
  final String totalHours;
  final List<dynamic> devicesHistory;

  @override
  Widget build(BuildContext context) {
    final name = employee.name ?? employee.userName ?? '-';
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 42.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: AppColors.border,
                borderRadius: BorderRadius.circular(4.r),
              ),
            ),
          ),
          hSpace(18),
          Row(
            children: [
              CircleAvatar(
                radius: 28.r,
                backgroundColor: AppColors.softBrandBackground,
                child: Text(
                  name.isEmpty ? '?' : name[0].toUpperCase(),
                  style: AppTextStyles.font20Bold.copyWith(
                    color: AppColors.brandPrimary,
                  ),
                ),
              ),
              vSpace(12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name, style: AppTextStyles.font18Bold),
                    if (employee.position != null &&
                        employee.position!.isNotEmpty) ...[
                      hSpace(2),
                      Text(
                        employee.position!,
                        style: AppTextStyles.font13Regular.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                    hSpace(4),
                    Wrap(
                      spacing: 4.w,
                      runSpacing: 4.h,
                      children: employee.allRoles.map((role) {
                        return Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 6.w,
                            vertical: 2.h,
                          ),
                          decoration: BoxDecoration(
                            color: switch (role.toLowerCase()) {
                              'admin' => AppColors.softBrandBackground,
                              'supervisor' => AppColors.softYellowBackground,
                              'hr' => const Color(0xFFF3E8FF),
                              _ => AppColors.softGreenBackground,
                            },
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Text(
                            switch (role.toLowerCase()) {
                              'admin' => 'admin.roles.admin',
                              'supervisor' => 'admin.roles.supervisor',
                              'hr' => 'admin.roles.hr',
                              _ => 'admin.roles.employee',
                            }.tr(context: context),
                            style: AppTextStyles.font11Medium.copyWith(
                              color: switch (role.toLowerCase()) {
                                'admin' => AppColors.brandPrimary,
                                'supervisor' => AppColors.warningOrange,
                                'hr' => const Color(0xFF7E22CE),
                                _ => AppColors.success,
                              },
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.close_rounded),
              ),
            ],
          ),
          hSpace(14),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(12.r),
            decoration: BoxDecoration(
              color: AppColors.pageBackground,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: AppColors.border),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: _infoItem(
                        context,
                        'admin.employees.code'.tr(context: context),
                        employee.employeeCode ?? employee.id ?? '-',
                      ),
                    ),
                    Expanded(
                      child: _infoItem(
                        context,
                        'admin.employees.department'.tr(context: context),
                        employee.departmentName ?? '-',
                      ),
                    ),
                  ],
                ),
                hSpace(8),
                Row(
                  children: [
                    Expanded(
                      child: _infoItem(
                        context,
                        'admin.employees.branch'.tr(context: context),
                        employee.branchName ?? '-',
                      ),
                    ),
                    Expanded(
                      child: _infoItem(
                        context,
                        'admin.employees.shift'.tr(context: context),
                        employee.shiftName ?? '-',
                      ),
                    ),
                  ],
                ),
                if (employee.resolvedDirectManagerName != null &&
                    employee.resolvedDirectManagerName!.isNotEmpty) ...[
                  hSpace(8),
                  Row(
                    children: [
                      Expanded(
                        child: _infoItem(
                          context,
                          'admin.employees.directManager'.tr(context: context),
                          employee.resolvedDirectManagerName!,
                        ),
                      ),
                    ],
                  ),
                ],
                if (employee.phone != null && employee.phone!.isNotEmpty) ...[
                  hSpace(8),
                  Row(
                    children: [
                      Expanded(
                        child: _infoItem(
                          context,
                          'admin.employees.phone'.tr(context: context),
                          employee.phone!,
                        ),
                      ),
                      Expanded(
                        child: _infoItem(
                          context,
                          'admin.employees.mobileId'.tr(context: context),
                          employee.mobileId ?? '-',
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
          hSpace(18),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: AppColors.softBrandBackground,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  visualDensity: VisualDensity.compact,
                  onPressed: () =>
                      context.read<EmployeeDetailsCubit>().setMonth(
                        DateTime(selectedMonth.year, selectedMonth.month - 1),
                      ),
                  icon: const Icon(Icons.chevron_left_rounded),
                ),
                Text(
                  DateFormat(
                    'MMMM yyyy',
                    context.locale.toString(),
                  ).format(selectedMonth),
                  style: AppTextStyles.font14SemiBold.copyWith(
                    color: AppColors.brandPrimary,
                  ),
                ),
                IconButton(
                  visualDensity: VisualDensity.compact,
                  onPressed: () =>
                      context.read<EmployeeDetailsCubit>().setMonth(
                        DateTime(selectedMonth.year, selectedMonth.month + 1),
                      ),
                  icon: const Icon(Icons.chevron_right_rounded),
                ),
              ],
            ),
          ),
          hSpace(16),
          Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            children: [
              EmployeeDetailsStatWidget(
                label: 'employee.details.attendedDays',
                value: '$attendedDays',
              ),
              EmployeeDetailsStatWidget(
                label: 'employee.details.lateDays',
                value: '$lateDays',
              ),
              EmployeeDetailsStatWidget(
                label: 'employee.details.absentDays',
                value: '$absentDays',
              ),
              EmployeeDetailsStatWidget(
                label: 'employee.details.earlyDays',
                value: '$earlyLeaveDays',
              ),
              EmployeeDetailsStatWidget(
                label: 'employee.details.totalHours',
                value: totalHours,
              ),
            ],
          ),
          hSpace(20),
          EmployeeDetailsChartWidget(
            attendedDays: attendedDays,
            absentDays: absentDays,
            lateDays: lateDays,
            earlyLeaveDays: earlyLeaveDays,
          ),
          hSpace(20),
          Text(
            'employee.details.attendanceHistory'.tr(context: context),
            style: AppTextStyles.font16Bold,
          ),
          hSpace(10),
          if (attendance.isEmpty)
            EmployeeDetailsMessageWidget(
              message: 'employee.details.noAttendance'.tr(context: context),
            )
          else
            for (final item in attendance.take(10))
              Padding(
                padding: EdgeInsets.only(bottom: 8.h),
                child: Container(
                  padding: EdgeInsets.all(12.r),
                  decoration: BoxDecoration(
                    color: AppColors.pageBackground,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          AppDateFormatter.formatDateString(
                            item.attendanceDate,
                          ),
                          style: AppTextStyles.font13SemiBold,
                        ),
                      ),
                      Text(
                        '${AppDateFormatter.formatTimeString(item.clockInTime)}  →  ${AppDateFormatter.formatTimeString(item.clockOutTime)}',
                        style: AppTextStyles.font12Regular,
                      ),
                    ],
                  ),
                ),
              ),
          if (devicesHistory.isNotEmpty) ...[
            hSpace(20),
            Text('Device History', style: AppTextStyles.font16Bold),
            hSpace(10),
            for (final device in devicesHistory)
              Container(
                margin: EdgeInsets.only(bottom: 8.h),
                padding: EdgeInsets.all(12.r),
                decoration: BoxDecoration(
                  color: AppColors.pageBackground,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: AppColors.border),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppDateFormatter.formatDateString(
                            device.createdAt.toString(),
                          ),
                          style: AppTextStyles.font12Medium.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.w,
                            vertical: 4.h,
                          ),
                          decoration: BoxDecoration(
                            color: device.isActive
                                ? AppColors.softGreenBackground
                                : AppColors.softBrandBackground,
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                          child: Text(
                            device.isActive ? 'Active' : 'Revoked/Pending',
                            style: AppTextStyles.font10Bold.copyWith(
                              color: device.isActive
                                  ? AppColors.success
                                  : AppColors.brandPrimary,
                            ),
                          ),
                        ),
                      ],
                    ),
                    hSpace(8),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            device.deviceId,
                            style: AppTextStyles.font13SemiBold,
                          ),
                        ),
                        IconButton(
                          visualDensity: VisualDensity.compact,
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          icon: Icon(
                            Icons.copy,
                            size: 16.r,
                            color: AppColors.brandPrimary,
                          ),
                          onPressed: () {
                            Clipboard.setData(
                              ClipboardData(text: device.deviceId),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Device ID copied to clipboard'),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    if (device.deviceModel != null) ...[
                      hSpace(4),
                      Text(
                        device.deviceModel ?? '',
                        style: AppTextStyles.font12Regular,
                      ),
                    ],
                  ],
                ),
              ),
          ],
        ],
      ),
    );
  }

  Widget _infoItem(BuildContext context, String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyles.font11Medium.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        hSpace(2),
        Text(
          value,
          style: AppTextStyles.font13SemiBold.copyWith(
            color: AppColors.textPrimary,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}

class EmployeeDetailsStatWidget extends StatelessWidget {
  const EmployeeDetailsStatWidget({
    required this.label,
    required this.value,
    super.key,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 148.w,
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: AppColors.softBrandBackground,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label.tr(context: context), style: AppTextStyles.font11Medium),
          hSpace(4),
          Text(value, style: AppTextStyles.font16Bold),
        ],
      ),
    );
  }
}

class EmployeeDetailsMessageWidget extends StatelessWidget {
  const EmployeeDetailsMessageWidget({required this.message, super.key});

  final String message;

  @override
  Widget build(BuildContext context) => SizedBox(
    height: 280.h,
    child: Center(
      child: Text(
        message,
        textAlign: TextAlign.center,
        style: AppTextStyles.font14Regular.copyWith(
          color: AppColors.textSecondary,
        ),
      ),
    ),
  );
}
