import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import '../../data/models/leave_balance_model.dart';
import 'leave_balance_row_widget.dart';

/// All leave balances as rows in one bordered card.
class LeaveBalancesListWidget extends StatelessWidget {
  const LeaveBalancesListWidget({super.key, required this.balances});

  final List<LeaveBalanceModel> balances;

  @override
  Widget build(BuildContext context) {
    if (balances.isEmpty) return const SizedBox.shrink();
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          for (var i = 0; i < balances.length; i++) ...[
            if (i > 0) const Divider(height: 1, color: AppColors.border),
            LeaveBalanceRowWidget(balance: balances[i]),
          ],
        ],
      ),
    );
  }
}
