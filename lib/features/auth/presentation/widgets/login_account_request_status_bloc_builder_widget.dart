import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/auth/presentation/cubit/request_account_status/request_account_status_cubit.dart';
import 'package:check_point_v2/features/auth/presentation/cubit/request_account_status/request_account_status_state.dart';

class LoginAccountRequestStatusBlocBuilderWidget extends StatelessWidget {
  const LoginAccountRequestStatusBlocBuilderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RequestAccountStatusCubit, RequestAccountStatusState>(
      builder: (context, state) => switch (state) {
        RequestAccountStatusSuccess(:final request) when request != null =>
          Container(
            padding: EdgeInsets.all(12.r),
            decoration: BoxDecoration(
              color: switch (request.status) {
                'Approved' => AppColors.softGreenBackground,
                'Rejected' => AppColors.softRedBackground,
                _ => AppColors.softYellowBackground,
              },
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: switch (request.status) {
                  'Approved' => AppColors.success,
                  'Rejected' => AppColors.error,
                  _ => AppColors.warningOrange,
                }.withValues(alpha: 0.25),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  switch (request.status) {
                    'Approved' => Icons.check_circle_outline_rounded,
                    'Rejected' => Icons.cancel_outlined,
                    _ => Icons.hourglass_top_rounded,
                  },
                  color: switch (request.status) {
                    'Approved' => AppColors.success,
                    'Rejected' => AppColors.error,
                    _ => AppColors.warningOrange,
                  },
                  size: 21.r,
                ),
                wSpace(8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'auth.login.accountRequestStatusTitle'.tr(
                          context: context,
                        ),
                        style: AppTextStyles.font13SemiBold,
                      ),
                      hSpace(3),
                      Text(
                        switch (request.status) {
                          'Approved' => 'auth.login.accountRequestApproved',
                          'Rejected' => 'auth.login.accountRequestRejected',
                          _ => 'auth.login.accountRequestPending',
                        }.tr(context: context),
                        style: AppTextStyles.font12Regular,
                      ),
                      if (request.status == 'Rejected' &&
                          request.rejectReason?.isNotEmpty == true) ...[
                        hSpace(3),
                        Text(
                          '${'auth.login.accountRequestReason'.tr(context: context)}: ${request.rejectReason}',
                          style: AppTextStyles.font12Regular.copyWith(
                            color: AppColors.error,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        _ => const SizedBox.shrink(),
      },
    );
  }
}
