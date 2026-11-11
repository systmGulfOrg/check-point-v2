import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'package:check_point_v2/core/core.dart';
import '../../data/models/points_summary_model.dart';
import '../cubit/points_cubit.dart';
import '../cubit/points_state.dart';
import '../widgets/my_points_content_widget.dart';

class MyPointsScreen extends StatefulWidget {
  const MyPointsScreen({super.key});

  @override
  State<MyPointsScreen> createState() => _MyPointsScreenState();
}

class _MyPointsScreenState extends State<MyPointsScreen> {
  static const _dummySummary = PointsSummaryModel(
    level: PointsLevelModel(
      tier: 'Silver',
      currentPoints: 125,
      nextLevelPoints: 301,
      progress: 0.12,
    ),
    streak: PointsStreakModel(currentStreak: 12, highestStreak: 20),
    balances: PointsBalancesModel(
      greenConfirmed: 125,
      greenPending: 5,
      red: 5,
      black: 2,
    ),
  );

  @override
  void initState() {
    super.initState();
    context.read<PointsCubit>().loadAllPointsData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: Text(
          'points.title'.tr(context: context),
          style: AppTextStyles.font18Bold,
        ),
        centerTitle: true,
        backgroundColor: AppColors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
            onPressed: () => context.read<PointsCubit>().loadAllPointsData(),
          ),
        ],
      ),
      body: BlocBuilder<PointsCubit, PointsState>(
        builder: (context, state) {
          return switch (state) {
            PointsLoading() => const Skeletonizer(
              enabled: true,
              child: MyPointsContentWidget(summary: _dummySummary),
            ),
            PointsError(:final message) => Center(
              child: Padding(
                padding: EdgeInsets.all(24.r),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.error_outline_rounded,
                      size: 48.r,
                      color: AppColors.error,
                    ),
                    hSpace(12),
                    Text(
                      message,
                      textAlign: TextAlign.center,
                      style: AppTextStyles.font14Regular,
                    ),
                    hSpace(16),
                    ElevatedButton(
                      onPressed: () =>
                          context.read<PointsCubit>().loadAllPointsData(),
                      child: Text(
                        'admin.attendance.tryAgain'.tr(context: context),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            PointsLoaded(:final summary) => RefreshIndicator(
              onRefresh: () => context.read<PointsCubit>().loadAllPointsData(),
              child: MyPointsContentWidget(summary: summary),
            ),
            _ => const SizedBox.shrink(),
          };
        },
      ),
    );
  }
}
