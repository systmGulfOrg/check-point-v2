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
      height: 175.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        clipBehavior: Clip.none,
        itemCount: balances.length,
        itemBuilder: (context, index) {
          return Container(
            width: 290.w,
            margin: EdgeInsetsDirectional.only(
              end: index == balances.length - 1 ? 0 : 12.w,
            ),
            child: LeaveBalanceCardWidget(balance: balances[index]),
          );
        },
      ),
    );
  }
}
