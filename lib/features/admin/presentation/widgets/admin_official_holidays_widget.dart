import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/leaves/data/models/official_holiday_model.dart';
import 'package:check_point_v2/features/leaves/presentation/cubit/leaves_cubit.dart';
import 'admin_reschedule_holiday_dialog_widget.dart';

class AdminOfficialHolidaysWidget extends StatelessWidget {
  const AdminOfficialHolidaysWidget({required this.holidays, super.key});

  final List<OfficialHolidayModel> holidays;

  void _showRescheduleDialog(
    BuildContext context,
    OfficialHolidayModel holiday,
  ) {
    final cubit = context.read<LeavesCubit>();
    showDialog<void>(
      context: context,
      builder: (_) => AdminRescheduleHolidayDialogWidget(
        holiday: holiday,
        onSave: (newDate, note, reset) async {
          await cubit.rescheduleHoliday(
            holidayId: holiday.id,
            holidayName: holiday.name,
            newDate: newDate,
            note: note,
            reset: reset,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (holidays.isEmpty) {
      return Center(
        child: Text(
          'admin.leaveManagement.noHolidays'.tr(context: context),
          style: AppTextStyles.font14Regular.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
      );
    }

    return ListView.separated(
      padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 24.h),
      itemCount: holidays.length,
      separatorBuilder: (_, _) => SizedBox(height: 10.h),
      itemBuilder: (context, index) {
        final holiday = holidays[index];
        final isRescheduled = holiday.isRescheduled ?? false;

        return Material(
          color: AppColors.transparent,
          child: InkWell(
            onTap: () => _showRescheduleDialog(context, holiday),
            borderRadius: BorderRadius.circular(12.r),
            child: Container(
              padding: EdgeInsets.all(14.w),
              decoration: BoxDecoration(
                color: AppColors.cardBackground,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(
                  color: isRescheduled
                      ? AppColors.brandPrimary
                      : AppColors.border,
                ),
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(10.r),
                    decoration: BoxDecoration(
                      color: isRescheduled
                          ? AppColors.softBlueBackground
                          : AppColors.pageBackground,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Icon(
                      Icons.edit_calendar_rounded,
                      color: AppColors.brandPrimary,
                      size: 20.r,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                holiday.arabicName ?? holiday.name,
                                style: AppTextStyles.font14SemiBold,
                              ),
                            ),
                            if (isRescheduled) ...[
                              SizedBox(width: 6.w),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 8.w,
                                  vertical: 2.h,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.softGreenBackground,
                                  borderRadius: BorderRadius.circular(6.r),
                                ),
                                child: Text(
                                  'مرحّلة',
                                  style: AppTextStyles.font10Bold.copyWith(
                                    color: AppColors.success,
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          isRescheduled && holiday.originalDate != null
                              ? '${DateFormat.yMMMMd(context.locale.languageCode).format(holiday.date)} (أصلياً: ${DateFormat.yMMMMd(context.locale.languageCode).format(holiday.originalDate!)})'
                              : DateFormat.yMMMMd(
                                  context.locale.languageCode,
                                ).format(holiday.date),
                          style: AppTextStyles.font12Regular.copyWith(
                            color: isRescheduled
                                ? AppColors.brandPrimary
                                : AppColors.textSecondary,
                          ),
                        ),
                        if (holiday.rescheduledNote != null &&
                            holiday.rescheduledNote!.isNotEmpty) ...[
                          SizedBox(height: 2.h),
                          Text(
                            holiday.rescheduledNote!,
                            style: AppTextStyles.font11Medium.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Icon(
                    Icons.edit_outlined,
                    size: 18.r,
                    color: AppColors.brandPrimary,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
