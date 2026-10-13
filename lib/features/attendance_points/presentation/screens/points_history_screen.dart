import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import '../../data/models/points_history_model.dart';
import '../cubit/points_cubit.dart';
import '../cubit/points_state.dart';
import '../widgets/points_history_item_card_widget.dart';

class PointsHistoryScreen extends StatefulWidget {
  const PointsHistoryScreen({super.key});

  @override
  State<PointsHistoryScreen> createState() => _PointsHistoryScreenState();
}

class _PointsHistoryScreenState extends State<PointsHistoryScreen> {
  String _selectedFilter = 'ALL'; // 'ALL', 'GREEN', 'RED', 'BLACK', 'PENDING'

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
            PointsLoading() => const Center(
              child: CircularProgressIndicator(),
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
                  ],
                ),
              ),
            ),
            PointsLoaded(:final history) => _buildHistoryContent(
              context,
              history,
            ),
            _ => const SizedBox.shrink(),
          };
        },
      ),
    );
  }

  Widget _buildHistoryContent(
    BuildContext context,
    List<PointsHistoryItemModel> allHistory,
  ) {
    final filtered = allHistory.where((item) {
      return switch (_selectedFilter) {
        'GREEN' => item.pointType.toUpperCase() == 'GREEN',
        'RED' => item.pointType.toUpperCase() == 'RED',
        'BLACK' => item.pointType.toUpperCase() == 'BLACK',
        'PENDING' => item.status.toUpperCase() == 'PENDING',
        _ => true,
      };
    }).toList();

    return Column(
      children: [
        // Filter bar
        Container(
          color: AppColors.white,
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildFilterChip(
                  context,
                  'ALL',
                  'points.filterAll'.tr(context: context),
                ),
                wSpace(8),
                _buildFilterChip(
                  context,
                  'GREEN',
                  'points.filterGreen'.tr(context: context),
                ),
                wSpace(8),
                _buildFilterChip(
                  context,
                  'RED',
                  'points.filterRed'.tr(context: context),
                ),
                wSpace(8),
                _buildFilterChip(
                  context,
                  'BLACK',
                  'points.filterBlack'.tr(context: context),
                ),
                wSpace(8),
                _buildFilterChip(
                  context,
                  'PENDING',
                  'points.filterPending'.tr(context: context),
                ),
              ],
            ),
          ),
        ),

        // List
        Expanded(
          child: filtered.isEmpty
              ? Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.history_toggle_off_rounded,
                        size: 48.r,
                        color: AppColors.textSecondary,
                      ),
                      hSpace(12),
                      Text(
                        'points.emptyHistory'.tr(context: context),
                        style: AppTextStyles.font14Regular.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                )
              : RefreshIndicator(
                  onRefresh: () =>
                      context.read<PointsCubit>().loadAllPointsData(),
                  child: ListView.separated(
                    padding: EdgeInsets.all(16.r),
                    itemCount: filtered.length,
                    separatorBuilder: (_, _) => hSpace(10),
                    itemBuilder: (context, index) {
                      final item = filtered[index];
                      return PointsHistoryItemCardWidget(item: item);
                    },
                  ),
                ),
        ),
      ],
    );
  }

  Widget _buildFilterChip(
    BuildContext context,
    String filterKey,
    String label,
  ) {
    final isSelected = _selectedFilter == filterKey;
    return InkWell(
      onTap: () {
        setState(() {
          _selectedFilter = filterKey;
        });
      },
      borderRadius: BorderRadius.circular(20.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.brandPrimary : AppColors.white,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: isSelected ? AppColors.brandPrimary : AppColors.border,
          ),
        ),
        child: Text(
          label,
          style: AppTextStyles.font12Bold.copyWith(
            color: isSelected ? AppColors.white : AppColors.textPrimary,
          ),
        ),
      ),
    );
  }
}
