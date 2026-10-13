import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import '../../data/models/points_history_model.dart';
import '../cubit/points_cubit.dart';
import '../cubit/points_state.dart';

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
                    Icon(Icons.error_outline_rounded, size: 48.r, color: AppColors.error),
                    hSpace(12),
                    Text(message, textAlign: TextAlign.center, style: AppTextStyles.font14Regular),
                  ],
                ),
              ),
            ),
            PointsLoaded(:final history) => _buildHistoryContent(context, history),
            _ => const SizedBox.shrink(),
          };
        },
      ),
    );
  }

  Widget _buildHistoryContent(BuildContext context, List<PointsHistoryItemModel> allHistory) {
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
          color: AppColors.cardBackground,
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildFilterChip(context, 'ALL', 'points.filterAll'.tr(context: context)),
                wSpace(8),
                _buildFilterChip(context, 'GREEN', 'points.filterGreen'.tr(context: context)),
                wSpace(8),
                _buildFilterChip(context, 'RED', 'points.filterRed'.tr(context: context)),
                wSpace(8),
                _buildFilterChip(context, 'BLACK', 'points.filterBlack'.tr(context: context)),
                wSpace(8),
                _buildFilterChip(context, 'PENDING', 'points.filterPending'.tr(context: context)),
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
                      Icon(Icons.history_toggle_off_rounded, size: 48.r, color: AppColors.textSecondary),
                      hSpace(12),
                      Text(
                        'points.emptyHistory'.tr(context: context),
                        style: AppTextStyles.font14Regular.copyWith(color: AppColors.textSecondary),
                      ),
                    ],
                  ),
                )
              : RefreshIndicator(
                  onRefresh: () => context.read<PointsCubit>().loadAllPointsData(),
                  child: ListView.separated(
                    padding: EdgeInsets.all(16.r),
                    itemCount: filtered.length,
                    separatorBuilder: (_, _) => hSpace(10),
                    itemBuilder: (context, index) {
                      final item = filtered[index];
                      return _HistoryItemCard(item: item);
                    },
                  ),
                ),
        ),
      ],
    );
  }

  Widget _buildFilterChip(BuildContext context, String filterKey, String label) {
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

class _HistoryItemCard extends StatelessWidget {
  const _HistoryItemCard({required this.item});

  final PointsHistoryItemModel item;

  @override
  Widget build(BuildContext context) {
    final isGreen = item.pointType.toUpperCase() == 'GREEN';
    final isRed = item.pointType.toUpperCase() == 'RED';
    final isCancelled = item.status.toUpperCase() == 'CANCELLED';
    final isPending = item.status.toUpperCase() == 'PENDING';

    final Color badgeColor = isCancelled
        ? AppColors.textSecondary
        : isGreen
            ? AppColors.success
            : isRed
                ? AppColors.error
                : AppColors.textPrimary;

    final String sign = isGreen ? '+' : '-';

    return Container(
      padding: EdgeInsets.all(14.r),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: isCancelled ? AppColors.border : badgeColor.withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Point type & amount
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: badgeColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Text(
                      '$sign${item.points}',
                      style: AppTextStyles.font14Bold.copyWith(
                        color: badgeColor,
                        decoration: isCancelled ? TextDecoration.lineThrough : null,
                      ),
                    ),
                  ),
                  wSpace(10),
                  Text(
                    item.reason,
                    style: AppTextStyles.font14Bold.copyWith(
                      decoration: isCancelled ? TextDecoration.lineThrough : null,
                    ),
                  ),
                ],
              ),
              // Status Pill
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                decoration: BoxDecoration(
                  color: isPending
                      ? AppColors.warningOrange.withValues(alpha: 0.1)
                      : isCancelled
                          ? AppColors.error.withValues(alpha: 0.1)
                          : AppColors.success.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Text(
                  item.status,
                  style: AppTextStyles.font10Medium.copyWith(
                    color: isPending
                        ? AppColors.warningOrange
                        : isCancelled
                            ? AppColors.error
                            : AppColors.success,
                  ),
                ),
              ),
            ],
          ),
          hSpace(8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                item.attendanceDate,
                style: AppTextStyles.font12Regular.copyWith(color: AppColors.textSecondary),
              ),
              if (item.cancelReason != null)
                Flexible(
                  child: Text(
                    item.cancelReason!,
                    style: AppTextStyles.font12Regular.copyWith(color: AppColors.error),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
