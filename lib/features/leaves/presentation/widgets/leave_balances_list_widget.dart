import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../data/models/leave_balance_model.dart';
import 'leave_balance_card_widget.dart';

class LeaveBalancesListWidget extends StatelessWidget {
  const LeaveBalancesListWidget({
    super.key,
    required this.balances,
  });

  final List<LeaveBalanceModel> balances;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(16.w),
      itemCount: balances.length,
      itemBuilder: (context, index) {
        return LeaveBalanceCardWidget(balance: balances[index]);
      },
    );
  }
}
