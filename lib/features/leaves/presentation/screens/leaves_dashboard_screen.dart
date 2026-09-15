import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/routes/routes.dart';
import '../../../../core/styles/app_colors.dart';
import '../cubit/leaves_cubit.dart';
import '../cubit/leaves_state.dart';
import '../widgets/leave_balances_list_widget.dart';

class LeavesDashboardScreen extends StatelessWidget {
  const LeavesDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      appBar: AppBar(
        title: Text('leaves.dashboard.title'.tr()),
        backgroundColor: AppColors.cardBackground,
        elevation: 0,
      ),
      body: BlocBuilder<LeavesCubit, LeavesState>(
        builder: (context, state) {
          return state.maybeWhen(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (message) => Center(
              child: Text(
                message,
                style: const TextStyle(color: AppColors.error),
              ),
            ),
            success: (balances, types) => LeaveBalancesListWidget(balances: balances),
            orElse: () => const SizedBox.shrink(),
          );
        },
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton.extended(
            heroTag: 'permissionBtn',
            onPressed: () => Navigator.pushNamed(context, AppRoutes.permissionsRequest),
            backgroundColor: AppColors.brandSecondary,
            icon: const Icon(Icons.timer),
            label: Text('leaves.dashboard.requestPermission'.tr()),
          ),
          SizedBox(height: 12.h),
          FloatingActionButton.extended(
            heroTag: 'leaveBtn',
            onPressed: () => Navigator.pushNamed(context, AppRoutes.leavesRequest),
            backgroundColor: AppColors.brandPrimary,
            icon: const Icon(Icons.add),
            label: Text('leaves.dashboard.requestLeave'.tr()),
          ),
        ],
      ),
    );
  }
}
