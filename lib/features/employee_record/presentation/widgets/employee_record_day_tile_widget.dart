import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/employee_record/data/models/employee_record_model.dart';
import 'employee_record_day_details_widget.dart';
import 'record_day_status_style.dart';

/// One day of the record: date, status pill and the details for that day.
class EmployeeRecordDayTileWidget extends StatelessWidget {
  const EmployeeRecordDayTileWidget({required this.day, super.key});

  final RecordDayModel day;

  @override
  Widget build(BuildContext context) {
    final locale = context.locale.toString();
    final style = RecordDayStatusStyle.of(day);
    return AppCardContainerWidget(
      margin: EdgeInsetsDirectional.only(bottom: 8.h),
      padding: EdgeInsetsDirectional.symmetric(horizontal: 14.w, vertical: 12.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 44.r,
            height: 44.r,
            decoration: BoxDecoration(
              color: style.background,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(style.icon, color: style.color, size: 22.r),
          ),
          vSpace(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        DateFormat.MMMEd(locale).format(day.date),
                        style: AppTextStyles.font14SemiBold,
                      ),
                    ),
                    AppStatusPillWidget(
                      label: style.labelKey.tr(context: context),
                      color: style.color,
                      backgroundColor: style.background,
                    ),
                  ],
                ),
                EmployeeRecordDayDetailsWidget(day: day),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
