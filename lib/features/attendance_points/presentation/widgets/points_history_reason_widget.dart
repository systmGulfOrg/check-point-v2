import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../data/models/points_history_model.dart';

class PointsHistoryReasonWidget extends StatelessWidget {
  const PointsHistoryReasonWidget({
    required this.item,
    required this.style,
    super.key,
  });

  final PointsHistoryItemModel item;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    final reason = item.reason;
    final lower = reason.toLowerCase();
    final match = RegExp(r'(\d+)').firstMatch(reason)?.group(1) ?? '0';
    final key = lower.contains('late arrival penalty')
        ? 'points.history.lateArrivalPenalty'
        : lower.contains('early check-in reward') && lower.contains('day')
        ? 'points.history.earlyCheckInDay'
        : lower.contains('early check-in reward')
        ? 'points.history.earlyCheckInReward'
        : lower.contains('no attendance recorded')
        ? 'points.history.noAttendance'
        : lower.contains('early departure')
        ? 'points.history.earlyDeparture'
        : lower.contains('late arrival')
        ? 'points.history.lateArrival'
        : lower.contains('refund')
        ? 'points.history.refund'
        : null;
    return Text(
      key == null ? reason : key.tr(context: context, args: [match]),
      style: style,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }
}
