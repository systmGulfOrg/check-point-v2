import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:check_point_v2/features/admin/presentation/widgets/admin_official_holidays_widget.dart';
import 'package:check_point_v2/features/leaves/presentation/cubit/leaves_cubit.dart';
import 'package:check_point_v2/features/leaves/presentation/cubit/leaves_state.dart';

class AdminOfficialHolidaysBlocBuilderWidget extends StatelessWidget {
  const AdminOfficialHolidaysBlocBuilderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LeavesCubit, LeavesState>(
      builder: (context, state) {
        return state.whenOrNull(
              loading: () => const Center(
                child: CircularProgressIndicator(),
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
