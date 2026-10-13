import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:check_point_v2/core/core.dart';
import '../../data/models/points_summary_model.dart';
import 'points_stat_card_widget.dart';

class PointsBalancesGridWidget extends StatelessWidget {
  const PointsBalancesGridWidget({
    required this.balances,
    super.key,
  });

  final PointsBalancesModel balances;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: PointsStatCardWidget(
                title: 'points.greenConfirmed'.tr(context: context),
                count: '+${balances.greenConfirmed}',
                color: AppColors.success,
                icon: Icons.check_circle_rounded,
                bgColor: AppColors.success.withValues(alpha: 0.05),
              ),
            ),
            wSpace(12),
            Expanded(
              child: PointsStatCardWidget(
                title: 'points.greenPending'.tr(context: context),
                count: '+${balances.greenPending}',
                color: AppColors.info,
                icon: Icons.hourglass_top_rounded,
                bgColor: AppColors.info.withValues(alpha: 0.05),
              ),
            ),
          ],
        ),
        hSpace(12),
        Row(
          children: [
            Expanded(
              child: PointsStatCardWidget(
                title: 'points.red'.tr(context: context),
                count: '-${balances.red}',
                color: AppColors.error,
                icon: Icons.remove_circle_rounded,
                bgColor: AppColors.error.withValues(alpha: 0.05),
              ),
            ),
            wSpace(12),
            Expanded(
              child: PointsStatCardWidget(
                title: 'points.black'.tr(context: context),
                count: '-${balances.black}',
                color: AppColors.brandInk,
                icon: Icons.warning_amber_rounded,
                bgColor: AppColors.brandInk.withValues(alpha: 0.05),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
