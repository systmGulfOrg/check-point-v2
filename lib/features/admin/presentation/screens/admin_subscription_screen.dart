import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/subscription/admin_subscription_cubit.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/subscription/admin_subscription_state.dart';
import 'package:check_point_v2/features/admin/presentation/widgets/admin_subscription_content_widget.dart';
import 'package:check_point_v2/features/admin/presentation/widgets/admin_subscription_skeleton_widget.dart';

class AdminSubscriptionScreen extends StatelessWidget {
  const AdminSubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        title: Text(
          'admin.subscription.title'.tr(context: context),
          style: AppTextStyles.font18Bold,
        ),
      ),
      body: SafeArea(
        child: BlocBuilder<AdminSubscriptionCubit, AdminSubscriptionState>(
          builder: (context, state) => switch (state) {
            AdminSubscriptionInitial() || AdminSubscriptionLoading() =>
              const AdminSubscriptionSkeletonWidget(),
            AdminSubscriptionError(:final messageKey) => AppMessageWidget(
              icon: Icons.error_outline_rounded,
              messageKey: messageKey,
            ),
            AdminSubscriptionSuccess(:final summary) =>
              AdminSubscriptionContentWidget(summary: summary),
            _ => const SizedBox.shrink(),
          },
        ),
      ),
    );
  }
}
