import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:check_point_v2/core/core.dart';
import '../../data/models/overtime_request_model.dart';
import '../cubit/overtime_cubit.dart';

class OvertimeRequestCardWidget extends StatelessWidget {
  const OvertimeRequestCardWidget({
    required this.request,
    required this.canReview,
    required this.isOwnRequest,
    super.key,
  });
  final OvertimeRequestModel request;
  final bool canReview;
  final bool isOwnRequest;

  @override
  Widget build(BuildContext context) {
    final statusKey = switch (request.status) {
      'Approved' => 'overtime.status.approved',
      'Rejected' => 'overtime.status.rejected',
      _ => 'overtime.status.pending',
    };
    return AppCardContainerWidget(
      child: Padding(
        padding: EdgeInsets.all(2.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    request.employeeName ??
                        'overtime.myRequest'.tr(context: context),
                    style: AppTextStyles.font14Bold,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 9.w, vertical: 5.h),
                  decoration: BoxDecoration(
                    color: request.status == 'Approved'
                        ? AppColors.softGreenBackground
                        : request.status == 'Rejected'
                        ? AppColors.softRedBackground
                        : AppColors.amberSoftBg,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Text(
                    statusKey.tr(context: context),
                    style: AppTextStyles.font11Medium.copyWith(
                      color: request.status == 'Approved'
                          ? AppColors.success
                          : request.status == 'Rejected'
                          ? AppColors.error
                          : AppColors.amberDark,
                    ),
                  ),
                ),
              ],
            ),
            hSpace(8),
            Text(
              '${request.requestDate.substring(0, request.requestDate.length > 10 ? 10 : request.requestDate.length)}  •  ${request.startTime} - ${request.endTime}  •  ${request.durationMinutes} ${'overtime.minutes'.tr(context: context)}',
              style: AppTextStyles.font13Regular,
            ),
            if (request.reason?.isNotEmpty == true) ...[
              hSpace(5),
              Text(request.reason!, style: AppTextStyles.font12Regular),
            ],
            if (canReview && !isOwnRequest && request.status == 'Pending') ...[
              hSpace(8),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => context.read<OvertimeCubit>().review(
                      id: request.id,
                      status: 'Rejected',
                    ),
                    child: Text('overtime.reject'.tr(context: context)),
                  ),
                  TextButton(
                    onPressed: () => context.read<OvertimeCubit>().review(
                      id: request.id,
                      status: 'Approved',
                    ),
                    child: Text('overtime.approve'.tr(context: context)),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
