import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import '../../data/models/points_history_model.dart';
import '../cubit/points_cubit.dart';
import 'points_history_filter_chip_widget.dart';
import 'points_history_item_card_widget.dart';

class PointsHistoryContentWidget extends StatefulWidget {
  const PointsHistoryContentWidget({
    super.key,
    required this.allHistory,
  });

  final List<PointsHistoryItemModel> allHistory;

  @override
  State<PointsHistoryContentWidget> createState() =>
      _PointsHistoryContentWidgetState();
}

class _PointsHistoryContentWidgetState
    extends State<PointsHistoryContentWidget> {
  String _selectedFilter = 'ALL';

  @override
  Widget build(BuildContext context) {
    final filtered = widget.allHistory.where((item) {
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
        Container(
          color: AppColors.white,
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                PointsHistoryFilterChipWidget(
                  label: 'points.filterAll'.tr(context: context),
                  isSelected: _selectedFilter == 'ALL',
                  onTap: () => setState(() => _selectedFilter = 'ALL'),
                ),
                wSpace(8),
                PointsHistoryFilterChipWidget(
                  label: 'points.filterGreen'.tr(context: context),
                  isSelected: _selectedFilter == 'GREEN',
                  onTap: () => setState(() => _selectedFilter = 'GREEN'),
                ),
                wSpace(8),
                PointsHistoryFilterChipWidget(
                  label: 'points.filterRed'.tr(context: context),
                  isSelected: _selectedFilter == 'RED',
                  onTap: () => setState(() => _selectedFilter = 'RED'),
                ),
                wSpace(8),
                PointsHistoryFilterChipWidget(
                  label: 'points.filterBlack'.tr(context: context),
                  isSelected: _selectedFilter == 'BLACK',
                  onTap: () => setState(() => _selectedFilter = 'BLACK'),
                ),
                wSpace(8),
                PointsHistoryFilterChipWidget(
                  label: 'points.filterPending'.tr(context: context),
                  isSelected: _selectedFilter == 'PENDING',
                  onTap: () => setState(() => _selectedFilter = 'PENDING'),
                ),
              ],
            ),
          ),
        ),
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
}
