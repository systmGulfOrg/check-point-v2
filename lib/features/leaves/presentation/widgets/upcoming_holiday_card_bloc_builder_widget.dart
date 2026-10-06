import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'package:check_point_v2/features/leaves/presentation/cubit/upcoming_holiday/upcoming_holiday_cubit.dart';
import 'package:check_point_v2/features/leaves/presentation/cubit/upcoming_holiday/upcoming_holiday_state.dart';
import 'upcoming_holiday_card_widget.dart';

class UpcomingHolidayCardBlocBuilderWidget extends StatelessWidget {
  const UpcomingHolidayCardBlocBuilderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UpcomingHolidayCubit, UpcomingHolidayState>(
      builder: (context, state) {
        return switch (state) {
          UpcomingHolidayStateInitial() ||
          UpcomingHolidayStateLoading() => const Skeletonizer(
            enabled: true,
            child: UpcomingHolidayCardWidget(
              isTodayHoliday: false,
              holidayName: 'Holiday Loading...',
              daysRemaining: 5,
            ),
          ),
          UpcomingHolidayStateLoaded(
            :final isTodayHoliday,
            :final todayHoliday,
            :final nearestUpcomingHoliday,
            :final daysUntilNearest,
          ) =>
            isTodayHoliday && todayHoliday != null
                ? UpcomingHolidayCardWidget(
                    isTodayHoliday: true,
                    holidayName: todayHoliday.name,
                    holidayDate: todayHoliday.date,
                  )
                : nearestUpcomingHoliday != null
                ? UpcomingHolidayCardWidget(
                    isTodayHoliday: false,
                    holidayName: nearestUpcomingHoliday.name,
                    holidayDate: nearestUpcomingHoliday.date,
                    daysRemaining: daysUntilNearest,
                  )
                : const SizedBox.shrink(),
          UpcomingHolidayStateError() => const SizedBox.shrink(),
          _ => const SizedBox.shrink(),
        };
      },
    );
  }
}
