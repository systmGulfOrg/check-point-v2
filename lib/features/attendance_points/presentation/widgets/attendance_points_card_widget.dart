import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:check_point_v2/core/core.dart';

class AttendancePointsCardWidget extends StatelessWidget {
  const AttendancePointsCardWidget({
    required this.label,
    required this.value,
    required this.color,
    super.key,
  });
  final String label;
  final int value;
  final Color color;

  @override
  Widget build(BuildContext context) => Card(
    child: Padding(
      padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 6.w),
      child: Column(
        children: [
          Text(
            '$value',
            style: AppTextStyles.font20Bold.copyWith(color: color),
          ),
          hSpace(4),
          Text(
            label,
            textAlign: TextAlign.center,
            style: AppTextStyles.font12Medium,
          ),
        ],
      ),
    ),
  );
}
