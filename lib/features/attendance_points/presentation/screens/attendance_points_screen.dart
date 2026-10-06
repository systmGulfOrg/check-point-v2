import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:check_point_v2/core/core.dart';
import '../cubit/attendance_points_cubit.dart';
import '../cubit/attendance_points_state.dart';
import '../widgets/attendance_points_card_widget.dart';

class AttendancePointsScreen extends StatelessWidget {
  const AttendancePointsScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text('attendancePoints.title'.tr(context: context))),
    body: BlocBuilder<AttendancePointsCubit, AttendancePointsState>(
      builder: (context, state) => switch (state) {
        AttendancePointsInitial() || AttendancePointsLoading() => Skeletonizer(
          enabled: true,
          child: ListView(
            padding: EdgeInsets.all(16.w),
            children: [
              Row(
                children: [
                  Expanded(
                    child: AttendancePointsCardWidget(
                      label: 'Green Points',
                      value: 10,
                      color: AppColors.success,
                    ),
                  ),
                  wSpace(8),
                  Expanded(
                    child: AttendancePointsCardWidget(
                      label: 'Red Points',
                      value: 2,
                      color: AppColors.error,
                    ),
                  ),
                  wSpace(8),
                  Expanded(
                    child: AttendancePointsCardWidget(
                      label: 'Black Points',
                      value: 0,
                      color: AppColors.brandInk,
                    ),
                  ),
                ],
              ),
              hSpace(20),
              Text(
                'attendancePoints.history'.tr(context: context),
                style: AppTextStyles.font16Bold,
              ),
              hSpace(8),
              ...List.generate(
                4,
                (_) => const ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: CircleAvatar(),
                  title: Text('Points Reason Placeholder Long'),
                  subtitle: Text('GREEN • 2026-10-05'),
                  trailing: Text('APPROVED'),
                ),
              ),
            ],
          ),
        ),
        AttendancePointsError(:final messageKey) => Center(
          child: Text(messageKey.tr(context: context)),
        ),
        AttendancePointsSuccess(:final summary, :final history) => ListView(
          padding: EdgeInsets.all(16.w),
          children: [
            Row(
              children: [
                Expanded(
                  child: AttendancePointsCardWidget(
                    label: 'attendancePoints.green'.tr(context: context),
                    value: summary.green,
                    color: AppColors.success,
                  ),
                ),
                wSpace(8),
                Expanded(
                  child: AttendancePointsCardWidget(
                    label: 'attendancePoints.red'.tr(context: context),
                    value: summary.red,
                    color: AppColors.error,
                  ),
                ),
                wSpace(8),
                Expanded(
                  child: AttendancePointsCardWidget(
                    label: 'attendancePoints.black'.tr(context: context),
                    value: summary.black,
                    color: AppColors.brandInk,
                  ),
                ),
              ],
            ),
            hSpace(20),
            Text(
              'attendancePoints.history'.tr(context: context),
              style: AppTextStyles.font16Bold,
            ),
            hSpace(8),
            ...history.map(
              (point) => ListTile(
                contentPadding: EdgeInsets.zero,
                leading: CircleAvatar(
                  backgroundColor: point.pointType == 'GREEN'
                      ? AppColors.success
                      : point.pointType == 'RED'
                      ? AppColors.error
                      : AppColors.brandInk,
                  child: Text(
                    '${point.points}',
                    style: AppTextStyles.font12Bold.copyWith(
                      color: AppColors.white,
                    ),
                  ),
                ),
                title: Text(point.reason),
                subtitle: Text('${point.pointType} • ${point.attendanceDate}'),
                trailing: Text(point.status),
              ),
            ),
          ],
        ),
        _ => const SizedBox.shrink(),
      },
    ),
  );
}
