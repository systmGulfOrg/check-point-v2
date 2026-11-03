import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/supervisor/data/models/worker_attendance/worker_day_response_model.dart';

class SupervisorWorkerRollCallItemWidget extends StatelessWidget {
  const SupervisorWorkerRollCallItemWidget({
    required this.worker,
    required this.isSelected,
    required this.currentSiteId,
    this.currentSiteName,
    required this.onToggle,
    super.key,
  });

  final WorkerDayItemModel worker;
  final bool isSelected;
  final String? currentSiteId;
  final String? currentSiteName;
  final ValueChanged<bool> onToggle;

  bool get isRecordedOnOtherSite {
    final att = worker.attendance;
    if (att == null || att.siteId == null || currentSiteId == null) return false;
    if (att.siteId == currentSiteId) return false;
    if (currentSiteName != null &&
        att.siteName != null &&
        att.siteName == currentSiteName) {
      return false;
    }
    return true;
  }

  bool get hasClockOut => worker.attendance?.clockOutTime != null;

  bool get canSelect =>
      worker.isActive && !isRecordedOnOtherSite && !hasClockOut;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4.h),
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: isSelected
            ? AppColors.brandPrimary.withValues(alpha: 0.06)
            : AppColors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: isSelected ? AppColors.brandPrimary : AppColors.border,
        ),
      ),
      child: Row(
        children: [
          Checkbox(
            value: isSelected,
            activeColor: AppColors.brandPrimary,
            onChanged: canSelect ? (v) => onToggle(v ?? false) : null,
          ),
          vSpace(8),
          CircleAvatar(
            radius: 18.r,
            backgroundColor: AppColors.softBlueBackground,
            backgroundImage:
                worker.imageUrl != null && worker.imageUrl!.isNotEmpty
                ? NetworkImage(worker.imageUrl!)
                : null,
            child: worker.imageUrl == null || worker.imageUrl!.isEmpty
                ? const Icon(Icons.person, color: AppColors.brandPrimary)
                : null,
          ),
          vSpace(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  worker.name,
                  style: AppTextStyles.font14Medium.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
                hSpace(2),
                Text(
                  '${worker.employeeCode ?? ''} • ${worker.contractor?.name ?? ''}',
                  style: AppTextStyles.font12Regular.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          _statusBadge(context),
        ],
      ),
    );
  }

  Widget _statusBadge(BuildContext context) {
    final att = worker.attendance;
    if (isRecordedOnOtherSite) {
      return _badge(
        text: 'contractorWorker.rollCall.otherSite'.tr(context: context),
        color: AppColors.warningOrange,
        bgColor: AppColors.softYellowBackground,
      );
    }
    if (att != null) {
      return _badge(
        text: 'contractorWorker.rollCall.present'.tr(context: context),
        color: AppColors.success,
        bgColor: AppColors.softGreenBackground,
      );
    }
    return _badge(
      text: 'contractorWorker.rollCall.notRecorded'.tr(context: context),
      color: AppColors.placeholder,
      bgColor: AppColors.softBrandBackground,
    );
  }

  Widget _badge({
    required String text,
    required Color color,
    required Color bgColor,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Text(
        text,
        style: AppTextStyles.font10Medium.copyWith(color: color),
      ),
    );
  }
}
