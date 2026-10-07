import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/core/di/service_locator.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/employee/admin_employees_cubit.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/locations/admin_departments_cubit.dart';
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
      builder: (_) => MultiBlocProvider(
        providers: [
          BlocProvider<AdminDepartmentsCubit>(
            create: (_) => sl<AdminDepartmentsCubit>()..load(),
          ),
          BlocProvider<AdminEmployeesCubit>(
            create: (_) => sl<AdminEmployeesCubit>()..loadEmployees(),
          ),
        ],
        child: AdminRescheduleHolidayDialogWidget(
          holiday: holiday,
          onSave: ({
            required DateTime newDate,
            required String? note,
            required bool reset,
            required bool isCancelled,
            required String? cancelReason,
            required List<String> excludedDepartmentIds,
            required List<String> excludedEmployeeIds,
          }) async {
            await cubit.rescheduleHoliday(
              holidayId: holiday.id,
              holidayName: holiday.name,
              newDate: newDate,
              note: note,
              reset: reset,
              isCancelled: isCancelled,
              cancelReason: cancelReason,
              excludedDepartmentIds: excludedDepartmentIds,
              excludedEmployeeIds: excludedEmployeeIds,
            );
          },
        ),
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
      separatorBuilder: (_, _) => SizedBox(height: 12.h),
      itemBuilder: (context, index) {
        final holiday = holidays[index];
        final isRescheduled = holiday.isRescheduled ?? false;
        final isCancelled = holiday.isCancelled ?? false;
        final hasExclusions =
            (holiday.excludedDepartmentIds?.isNotEmpty ?? false) ||
            (holiday.excludedEmployeeIds?.isNotEmpty ?? false);

        final cardBackground = isCancelled
            ? AppColors.softRedBackground
            : (isRescheduled ? const Color(0xFFFFF7ED) : AppColors.cardBackground);

        final borderColor = isCancelled
            ? AppColors.error.withValues(alpha: 0.3)
            : (isRescheduled ? const Color(0xFFFED7AA) : AppColors.border);

        final iconBoxBg = isCancelled
            ? AppColors.softRedBackground
            : (isRescheduled ? const Color(0xFFFFEDD5) : AppColors.pageBackground);

        final iconColor = isCancelled
            ? AppColors.error
            : (isRescheduled ? AppColors.brandPrimary : AppColors.brandInk);

        return Material(
          color: AppColors.transparent,
          child: InkWell(
            onTap: () => _showRescheduleDialog(context, holiday),
            borderRadius: BorderRadius.circular(16.r),
            child: Container(
              padding: EdgeInsets.all(14.r),
              decoration: BoxDecoration(
                color: cardBackground,
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(color: borderColor, width: 1.2),
              ),
              child: Row(
                children: [
                  // Left Edit Pencil Button in Soft Box (Trailing in RTL / Leading in LTR)
                  Container(
                    width: 38.r,
                    height: 38.r,
                    decoration: BoxDecoration(
                      color: isCancelled
                          ? AppColors.softRedBackground
                          : const Color(0xFFFFEDD5),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Icon(
                      Icons.edit_outlined,
                      size: 18.r,
                      color: isCancelled ? AppColors.error : AppColors.brandPrimary,
                    ),
                  ),
                  SizedBox(width: 12.w),

                  // Middle Content
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title + Status Badge
                        Row(
                          children: [
                            if (isCancelled) ...[
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 8.w,
                                  vertical: 3.h,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.error,
                                  borderRadius: BorderRadius.circular(6.r),
                                ),
                                child: Text(
                                  'ملغاة',
                                  style: AppTextStyles.font10Bold.copyWith(
                                    color: AppColors.white,
                                  ),
                                ),
                              ),
                              SizedBox(width: 8.w),
                            ] else if (isRescheduled) ...[
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 8.w,
                                  vertical: 3.h,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.brandPrimary,
                                  borderRadius: BorderRadius.circular(6.r),
                                ),
                                child: Text(
                                  'مرحّلة',
                                  style: AppTextStyles.font10Bold.copyWith(
                                    color: AppColors.white,
                                  ),
                                ),
                              ),
                              SizedBox(width: 8.w),
                            ],
                            Expanded(
                              child: Text(
                                holiday.arabicName ?? holiday.name,
                                style: AppTextStyles.font14Bold.copyWith(
                                  color: isCancelled
                                      ? AppColors.textSecondary
                                      : AppColors.brandInk,
                                  decoration: isCancelled
                                      ? TextDecoration.lineThrough
                                      : null,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5.h),

                        // Date line
                        if (isRescheduled && holiday.originalDate != null)
                          Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            spacing: 4.w,
                            children: [
                              Text(
                                'الرسمي: ${DateFormat('d MMMM yyyy', context.locale.languageCode).format(holiday.originalDate!)}',
                                style: AppTextStyles.font12Regular.copyWith(
                                  decoration: TextDecoration.lineThrough,
                                  color: const Color(0xFF9CA3AF),
                                ),
                              ),
                              Icon(
                                Icons.arrow_back_rounded,
                                size: 13.r,
                                color: AppColors.brandPrimary,
                              ),
                              Text(
                                DateFormat(
                                  'EEEE، d MMMM yyyy',
                                  context.locale.languageCode,
                                ).format(holiday.date),
                                style: AppTextStyles.font12Bold.copyWith(
                                  color: AppColors.brandPrimary,
                                ),
                              ),
                            ],
                          )
                        else if (isCancelled)
                          Text(
                            holiday.cancelReason != null &&
                                    holiday.cancelReason!.isNotEmpty
                                ? 'تم إلغاء الإجازة: ${holiday.cancelReason}'
                                : 'تم إلغاء الإجازة الرسمية واعتبار اليوم عمل عادي',
                            style: AppTextStyles.font12Regular.copyWith(
                              color: AppColors.error,
                            ),
                          )
                        else
                          Text(
                            DateFormat(
                              'EEEE، d MMMM yyyy',
                              context.locale.languageCode,
                            ).format(holiday.date),
                            style: AppTextStyles.font12Regular.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),

                        // Reschedule Note
                        if (holiday.rescheduledNote != null &&
                            holiday.rescheduledNote!.isNotEmpty) ...[
                          SizedBox(height: 3.h),
                          Text(
                            holiday.rescheduledNote!,
                            style: AppTextStyles.font11Medium.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],

                        // Exclusions tag
                        if (hasExclusions) ...[
                          SizedBox(height: 4.h),
                          Row(
                            children: [
                              Icon(
                                Icons.group_outlined,
                                size: 13.r,
                                color: AppColors.brandPrimary,
                              ),
                              SizedBox(width: 4.w),
                              Text(
                                'توجد استثناءات محددة لهذه الإجازة',
                                style: AppTextStyles.font11Medium.copyWith(
                                  color: AppColors.brandPrimary,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ],
                    ),
                  ),
                  SizedBox(width: 12.w),

                  // Right Big Calendar Icon Box (Leading in RTL)
                  Container(
                    width: 46.r,
                    height: 46.r,
                    decoration: BoxDecoration(
                      color: iconBoxBg,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Icon(
                      isCancelled
                          ? Icons.event_busy_rounded
                          : (isRescheduled
                              ? Icons.edit_calendar_rounded
                              : Icons.calendar_month_rounded),
                      color: iconColor,
                      size: 22.r,
                    ),
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
