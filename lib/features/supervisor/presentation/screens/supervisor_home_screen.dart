import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/leaves/presentation/cubit/upcoming_holiday/upcoming_holiday_cubit.dart';
import 'package:check_point_v2/features/leaves/presentation/widgets/upcoming_holiday_card_bloc_builder_widget.dart';
import 'package:check_point_v2/features/contractor/presentation/cubit/contractor_cubit.dart';
import 'package:check_point_v2/features/supervisor/presentation/cubit/attendance/supervisor_attendance_cubit.dart';
import 'package:check_point_v2/features/supervisor/presentation/cubit/plans/supervisor_plans_cubit.dart';
import 'package:check_point_v2/features/supervisor/presentation/cubit/team/supervisor_team_cubit.dart';
import 'package:check_point_v2/features/supervisor/presentation/widgets/supervisor_top_bar_widget.dart';
import 'package:check_point_v2/features/supervisor/presentation/widgets/supervisor_personal_dashboard_bloc_builder_widget.dart';
import 'package:check_point_v2/features/supervisor/presentation/widgets/supervisor_alert_banner_bloc_builder_widget.dart';
import 'package:check_point_v2/features/supervisor/presentation/widgets/supervisor_samco_site_card_widget.dart';
import 'package:check_point_v2/features/supervisor/presentation/widgets/supervisor_stats_grid_bloc_builder_widget.dart';
import 'package:check_point_v2/features/supervisor/presentation/widgets/supervisor_team_today_bloc_builder_widget.dart';

class SupervisorHomeScreen extends StatelessWidget {
  const SupervisorHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: RefreshIndicator(
        color: AppColors.brandPrimary,
        onRefresh: () => Future.wait([
          context.read<SupervisorAttendanceCubit>().loadAttendance(),
          context.read<SupervisorPlansCubit>().loadPlans(),
          context.read<SupervisorTeamCubit>().loadTeam(),
          context.read<UpcomingHolidayCubit>().loadUpcomingHoliday(),
          context.read<ContractorCubit>().loadDashboardData(),
        ]),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AnimatedListItemWidget(
                index: 0,
                child: SupervisorTopBarWidget(),
              ),
              hSpace(16),
              const AnimatedListItemWidget(
                index: 1,
                child: SupervisorPersonalDashboardBlocBuilderWidget(),
              ),
              hSpace(16),
              const AnimatedListItemWidget(
                index: 2,
                child: SupervisorSamcoSiteCardWidget(),
              ),
              const AnimatedListItemWidget(
                index: 3,
                child: UpcomingHolidayCardBlocBuilderWidget(),
              ),
              hSpace(16),
              const AnimatedListItemWidget(
                index: 4,
                child: SupervisorAlertBannerBlocBuilderWidget(),
              ),
              hSpace(20),
              const AnimatedListItemWidget(
                index: 5,
                child: SupervisorStatsGridBlocBuilderWidget(),
              ),
              hSpace(20),
              const AnimatedListItemWidget(
                index: 6,
                child: SupervisorTeamTodayBlocBuilderWidget(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
