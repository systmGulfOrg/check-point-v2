import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../data/models/leave_balance_model.dart';
import 'leave_balance_card_widget.dart';

class LeaveBalancesListWidget extends StatelessWidget {
  const LeaveBalancesListWidget({super.key, required this.balances});

  final List<LeaveBalanceModel> balances;

  @override
  Widget build(BuildContext context) {
    if (balances.isEmpty) return const SizedBox.shrink();
    return SizedBox(
      height: 250.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        itemCount: balances.length,
        itemBuilder: (context, index) {
          return SizedBox(
            width: 300.w,
            child: Padding(
              padding: EdgeInsets.only(right: 16.w),
              child: LeaveBalanceCardWidget(balance: balances[index]),
            ),
          );
        },
      ),
    );
  }
}
