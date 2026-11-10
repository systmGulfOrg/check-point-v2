import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/account_requests/admin_account_requests_cubit.dart';

/// Loads the next server page of account requests.
class AdminAccountRequestsLoadMoreWidget extends StatelessWidget {
  const AdminAccountRequestsLoadMoreWidget({required this.isLoading, super.key});

  final bool isLoading;

  @override
  Widget build(BuildContext context) => Padding(
    padding: EdgeInsetsDirectional.only(top: 6.h),
    child: CustomButton(
      text: 'admin.requests.loadMore'.tr(context: context),
      isLoading: isLoading,
      backgroundColor: AppColors.cardBackground,
      textColor: AppColors.brandInk,
      onTap: () => context
          .read<AdminAccountRequestsCubit>()
          .loadRequests(newResponse: false),
    ),
  );
}
