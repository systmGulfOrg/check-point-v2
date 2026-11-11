import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import '../cubit/points_cubit.dart';
import '../cubit/points_state.dart';
import '../widgets/points_history_content_widget.dart';
import '../widgets/points_history_skeleton_widget.dart';

class PointsHistoryScreen extends StatelessWidget {
  const PointsHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: Text(
          'points.historyTitle'.tr(context: context),
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
            PointsLoading() => const PointsHistorySkeletonWidget(),
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
                  ],
                ),
              ),
            ),
            PointsLoaded(:final history) => PointsHistoryContentWidget(
              allHistory: history,
            ),
            _ => const SizedBox.shrink(),
          };
        },
      ),
    );
  }
}
