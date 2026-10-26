import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/core/models/offline_attendance_models.dart';
import 'package:check_point_v2/features/supervisor/presentation/cubit/verification/pending_verification_cubit.dart';
import 'package:check_point_v2/features/supervisor/presentation/cubit/verification/pending_verification_state.dart';

class PendingAttendanceVerificationScreen extends StatefulWidget {
  const PendingAttendanceVerificationScreen({super.key});

  @override
  State<PendingAttendanceVerificationScreen> createState() =>
      _PendingAttendanceVerificationScreenState();
}

class _PendingAttendanceVerificationScreenState
    extends State<PendingAttendanceVerificationScreen> {
  @override
  void initState() {
    super.initState();
    context.read<PendingVerificationCubit>().loadPendingVerifications();
  }

  void _showRejectDialog(int id) {
    final reasonController = TextEditingController();
    showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(
          'offline.reject'.tr(),
          style: AppTextStyles.font18Bold,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'offline.rejectReasonHint'.tr(),
              style: AppTextStyles.font14Regular,
            ),
            SizedBox(height: 12.h),
            TextField(
              controller: reasonController,
              maxLines: 2,
              decoration: InputDecoration(
                hintText: 'offline.rejectReasonHint'.tr(),
                border: const OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text('core.actions.cancel'.tr()),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.error,
            ),
            onPressed: () {
              Navigator.of(ctx).pop();
              context.read<PendingVerificationCubit>().reject(
                    id,
                    reason: reasonController.text.trim(),
                  );
            },
            child: Text(
              'offline.reject'.tr(),
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('offline.pendingVerificationTitle'.tr()),
      ),
      body: BlocConsumer<PendingVerificationCubit, PendingVerificationState>(
        listener: (context, state) {
          state.maybeWhen(
            error: (msgKey) => CustomSnackBar.showError(
              context,
              message: msgKey.tr(),
            ),
            actionSuccess: (msgKey) => CustomSnackBar.showSuccess(
              context,
              message: msgKey.tr(),
            ),
            orElse: () {},
          );
        },
        builder: (context, state) {
          return state.maybeWhen(
            loading: () => const Center(child: CircularProgressIndicator()),
            loaded: (items) => _buildList(items),
            orElse: () => _buildList(
              context.read<PendingVerificationCubit>().currentItems,
            ),
          );
        },
      ),
    );
  }

  Widget _buildList(List<PendingAttendanceItem> items) {
    if (items.isEmpty) {
      return RefreshIndicator(
        onRefresh: () =>
            context.read<PendingVerificationCubit>().loadPendingVerifications(),
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          children: [
            SizedBox(height: 120.h),
            Center(
              child: Column(
                children: [
                  Icon(
                    Icons.check_circle_outline_rounded,
                    size: 64.sp,
                    color: AppColors.textSecondary,
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    'offline.emptyPending'.tr(),
                    style: AppTextStyles.font14Regular.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () =>
          context.read<PendingVerificationCubit>().loadPendingVerifications(),
      child: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        itemCount: items.length,
        separatorBuilder: (context, index) => SizedBox(height: 12.h),
        itemBuilder: (context, index) {
          final item = items[index];
          return _buildItemCard(item);
        },
      ),
    );
  }

  Widget _buildItemCard(PendingAttendanceItem item) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20.r,
                backgroundColor: AppColors.brandPrimary.withValues(alpha: 0.1),
                child: Text(
                  item.employeeName.isNotEmpty
                      ? item.employeeName[0].toUpperCase()
                      : '?',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.brandPrimary,
                    fontSize: 16.sp,
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.employeeName,
                      style: AppTextStyles.font16Bold,
                    ),
                    if (item.employeeCode != null)
                      Text(
                        item.employeeCode!,
                        style: AppTextStyles.font12Regular.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                  ],
                ),
              ),
              if (item.attendanceDate != null)
                Text(
                  AppDateFormatter.formatYearMonthDay(item.attendanceDate!),
                  style: AppTextStyles.font12Regular.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              if (item.clockInTime != null)
                Expanded(
                  child: _buildTimeChip(
                    label: 'دخول',
                    time: AppDateFormatter.formatTime(item.clockInTime!),
                    icon: Icons.login_rounded,
                  ),
                ),
              if (item.clockOutTime != null) ...[
                SizedBox(width: 8.w),
                Expanded(
                  child: _buildTimeChip(
                    label: 'خروج',
                    time: AppDateFormatter.formatTime(item.clockOutTime!),
                    icon: Icons.logout_rounded,
                  ),
                ),
              ],
            ],
          ),
          if (item.verificationReasons.isNotEmpty) ...[
            SizedBox(height: 10.h),
            Wrap(
              spacing: 6.w,
              runSpacing: 6.h,
              children: item.verificationReasons
                  .map((r) => _buildReasonBadge(r))
                  .toList(),
            ),
          ],
          SizedBox(height: 12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.error,
                  side: const BorderSide(color: AppColors.error),
                ),
                onPressed: () => _showRejectDialog(item.id),
                icon: const Icon(Icons.close_rounded, size: 16),
                label: Text('offline.reject'.tr()),
              ),
              SizedBox(width: 8.w),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.success,
                  foregroundColor: Colors.white,
                ),
                onPressed: () =>
                    context.read<PendingVerificationCubit>().approve(item.id),
                icon: const Icon(Icons.check_rounded, size: 16),
                label: Text('offline.approve'.tr()),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTimeChip({
    required String label,
    required String time,
    required IconData icon,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: AppColors.pageBackground,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14.sp, color: AppColors.brandPrimary),
          SizedBox(width: 6.w),
          Text('$label: $time', style: AppTextStyles.font12Medium),
        ],
      ),
    );
  }

  Widget _buildReasonBadge(String reason) {
    final label = switch (reason) {
      'CLOCK_DRIFT' => 'فارق زمني',
      'CLOCK_UNANCHORED' => 'بدون مرجع زمني',
      'MOCK_LOCATION' => 'موقع وهمي',
      'LOW_ACCURACY' => 'دقة موقع منخفضة',
      'OUTSIDE_GEOFENCE' => 'خارج النطاق',
      'DEVICE_UNVERIFIED' => 'جهاز غير موثق',
      _ => reason,
    };

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: AppColors.warning.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(6.r),
        border: Border.all(color: AppColors.warning.withValues(alpha: 0.4)),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11.sp,
          fontWeight: FontWeight.w600,
          color: const Color(0xFFB45309), // amber-700
        ),
      ),
    );
  }
}
