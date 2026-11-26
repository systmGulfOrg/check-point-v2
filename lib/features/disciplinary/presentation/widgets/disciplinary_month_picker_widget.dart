import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:check_point_v2/core/core.dart';
import '../cubit/disciplinary_cubit.dart';

class DisciplinaryMonthPickerWidget extends StatelessWidget {
  const DisciplinaryMonthPickerWidget({
    super.key,
    required this.cubit,
  });

  final DisciplinaryCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      color: AppColors.pageBackground,
      child: Row(
        children: [
          IconButton(
            tooltip: 'record.previousMonth'.tr(context: context),
            onPressed: cubit.previousMonth,
            icon: const Icon(
              Icons.chevron_left_rounded,
              color: AppColors.brandPrimary,
            ),
          ),
          Expanded(
            child: Text(
              DateFormat.yMMMM(context.locale.toString())
                  .format(cubit.currentMonth),
              textAlign: TextAlign.center,
              style: AppTextStyles.font16Bold,
            ),
          ),
          IconButton(
            tooltip: 'record.nextMonth'.tr(context: context),
            onPressed: cubit.canGoNext ? cubit.nextMonth : null,
            icon: Icon(
              Icons.chevron_right_rounded,
              color: cubit.canGoNext
                  ? AppColors.brandPrimary
                  : AppColors.placeholder,
            ),
          ),
        ],
      ),
    );
  }
}
