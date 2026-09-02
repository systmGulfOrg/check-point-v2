import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/core.dart';
import '../widgets/supervisor_notification_card_widget.dart';

class SupervisorNotificationsScreen extends StatefulWidget {
  const SupervisorNotificationsScreen({super.key});

  @override
  State<SupervisorNotificationsScreen> createState() =>
      _SupervisorNotificationsScreenState();
}

class _SupervisorNotificationsScreenState
    extends State<SupervisorNotificationsScreen> {
  int unreadCount = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        title: Text(
          'supervisor.notifications.title'.tr(context: context),
          style: AppTextStyles.font18Bold,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(16.w, 4.h, 16.w, 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'supervisor.notifications.unread'.tr(
                      context: context,
                      args: ['$unreadCount'],
                    ),
                    style: AppTextStyles.font12Regular,
                  ),
                  InkWell(
                    onTap: () => setState(() => unreadCount = 0),
                    child: Text(
                      'supervisor.notifications.markAllRead'.tr(
                        context: context,
                      ),
                      style: AppTextStyles.font12Medium.copyWith(
                        color: AppColors.brandPrimary,
                      ),
                    ),
                  ),
                ],
              ),
              hSpace(12),
              const SupervisorNotificationCardWidget(
                typeKey: 'supervisor.notifications.warning',
                titleKey: 'supervisor.notifications.lateArrivalTitle',
                messageKey: 'supervisor.notifications.lateArrivalMessage',
                isWarning: true,
              ),
              hSpace(10),
              const SupervisorNotificationCardWidget(
                typeKey: 'supervisor.notifications.info',
                titleKey: 'supervisor.notifications.leaveRequestTitle',
                messageKey: 'supervisor.notifications.leaveRequestMessage',
                isWarning: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
