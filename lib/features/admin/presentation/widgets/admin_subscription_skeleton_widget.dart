import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'admin_subscription_plan_card_widget.dart';

class AdminSubscriptionSkeletonWidget extends StatelessWidget {
  const AdminSubscriptionSkeletonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: AdminSubscriptionPlanCardWidget(
          companyName: 'Company name',
          planName: 'Plan',
          isTrial: true,
          trialEndsAt: DateTime.now(),
          seatLimit: 10,
          usedSeats: 5,
        ),
      ),
    );
  }
}
