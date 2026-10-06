import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../data/models/audit/audit_log_model.dart';

class AdminEmployeeAuditItemWidget extends StatelessWidget {
  final AuditLogModel log;
  const AdminEmployeeAuditItemWidget({super.key, required this.log});

  List<Widget> _buildChangesList(BuildContext context) {
    final before = log.before ?? {};
    final after = log.after ?? {};

    // Ignore meta fields that always change but aren't useful to show as a business change
    final ignoreKeys = {
      'updatedAt',
      'createdAt',
      'deletedAt',
      'id',
      'tenantId',
      'userId',
    };

    final allKeys = {
      ...before.keys,
      ...after.keys,
    }.where((k) => !ignoreKeys.contains(k)).toList();

    List<Widget> changes = [];
    for (final key in allKeys) {
      final bVal = before[key];
      final aVal = after[key];

      // Use jsonEncode for deep equality comparison
      final bStr = jsonEncode(bVal);
      final aStr = jsonEncode(aVal);
      if (bStr == aStr) continue;

      // We found a change!
      changes.add(
        Padding(
          padding: EdgeInsets.only(top: 8.h),
          child: Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: AppColors.pageBackground,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  key,
                  style: AppTextStyles.font14Bold.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
                SizedBox(height: 6.h),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'admin.employees.before'.tr(context: context),
                            style: AppTextStyles.font12Regular.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            bVal?.toString() ??
                                'admin.employees.emptyValue'.tr(
                                  context: context,
                                ),
                            style: AppTextStyles.font14Regular.copyWith(
                              color: AppColors.error,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      context.locale.languageCode == 'ar'
                          ? Icons.arrow_back
                          : Icons.arrow_forward,
                      size: 16.sp,
                      color: AppColors.textSecondary,
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'admin.employees.after'.tr(context: context),
                            style: AppTextStyles.font12Regular.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            aVal?.toString() ??
                                'admin.employees.emptyValue'.tr(
                                  context: context,
                                ),
                            style: AppTextStyles.font14Regular.copyWith(
                              color: AppColors.success,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    }

    if (changes.isEmpty && (log.before != null || log.after != null)) {
      changes.add(
        Padding(
          padding: EdgeInsets.only(top: 8.h),
          child: Text(
            'admin.employees.noVisibleChanges'.tr(context: context),
            style: AppTextStyles.font12Regular.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ),
      );
    }
    return changes;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.border),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 4,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(log.action, style: AppTextStyles.font16Bold),
              ),
              Text(
                DateFormat('yyyy-MM-dd HH:mm').format(log.createdAt.toLocal()),
                style: AppTextStyles.font12Regular.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Text(
            '${"admin.employees.by".tr(context: context)} ${log.actorName ?? "admin.employees.unknown".tr(context: context)}',
            style: AppTextStyles.font14Regular,
          ),
          ..._buildChangesList(context),
        ],
      ),
    );
  }
}
