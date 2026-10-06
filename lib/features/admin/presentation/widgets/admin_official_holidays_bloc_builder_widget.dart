import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:check_point_v2/features/admin/presentation/widgets/admin_official_holidays_widget.dart';
import 'package:check_point_v2/features/leaves/presentation/cubit/leaves_cubit.dart';
import 'package:check_point_v2/features/leaves/presentation/cubit/leaves_state.dart';

import 'package:skeletonizer/skeletonizer.dart';
import 'package:check_point_v2/features/leaves/data/models/official_holiday_model.dart';

class AdminOfficialHolidaysBlocBuilderWidget extends StatelessWidget {
  const AdminOfficialHolidaysBlocBuilderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LeavesCubit, LeavesState>(
      builder: (context, state) {
        return state.whenOrNull(
              loading: () => Skeletonizer(
                enabled: true,
                child: AdminOfficialHolidaysWidget(
                  holidays: [
                    OfficialHolidayModel(
                      id: '1',
                      name: 'National Holiday Placeholder',
                      date: DateTime(2026, 1, 1),
                      isRecurring: true,
                    ),
                    OfficialHolidayModel(
                      id: '2',
                      name: 'Eid Holiday Placeholder',
                      date: DateTime(2026, 4, 10),
                      isRecurring: false,
                    ),
                  ],
                ),
              ),
              holidaysLoaded: (holidays) =>
                  AdminOfficialHolidaysWidget(holidays: holidays),
              error: (message) => Center(child: Text(message)),
            ) ??
            const SizedBox.shrink();
      },
    );
  }
}
