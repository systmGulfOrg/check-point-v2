import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/auth/presentation/cubit/profile/auth_profile_cubit.dart';
import 'package:check_point_v2/features/auth/presentation/widgets/role_switch_dialog_widget.dart';
import 'supervisor_more_option_widget.dart';

class SupervisorMoreOptionsSheetWidget extends StatelessWidget {
  const SupervisorMoreOptionsSheetWidget({
    required this.onLeavesTap,
    required this.onNotificationsTap,
    required this.onProfileTap,
    required this.onRemoteWorkTap,
    this.onCustomersTap,
    this.onPlansTap,
    super.key,
  });

  final VoidCallback onLeavesTap;
  final VoidCallback? onCustomersTap;
  final VoidCallback? onPlansTap;
  final VoidCallback onNotificationsTap;
  final VoidCallback onProfileTap;
  final VoidCallback onRemoteWorkTap;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 24.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 38.w,
                height: 4.h,
                margin: EdgeInsets.only(bottom: 16.h),
                decoration: BoxDecoration(
                  color: AppColors.border,
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'supervisor.more.title'.tr(context: context),
                      style: AppTextStyles.font18Bold,
                    ),
                    hSpace(2),
                    Text(
                      'supervisor.more.subtitle'.tr(context: context),
                      style: AppTextStyles.font12Regular.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  style: IconButton.styleFrom(
                    backgroundColor: AppColors.pageBackground,
                    shape: const CircleBorder(),
                  ),
                  icon: Icon(
                    Icons.close_rounded,
                    size: 20.r,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
            hSpace(18),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 12.h,
              crossAxisSpacing: 12.w,
              childAspectRatio: 1.32,
              children: [
                SupervisorMoreOptionWidget(
                  icon: Icons.business_center_outlined,
                  labelKey: 'supervisor.more.customers',
                  subtitleKey: 'supervisor.more.customersSubtitle',
                  backgroundColor: AppColors.softBrandBackground,
                  iconColor: AppColors.brandPrimary,
                  onTap: () {
                    Navigator.pop(context);
                    onCustomersTap?.call();
                  },
                ),
                SupervisorMoreOptionWidget(
                  icon: Icons.calendar_month_outlined,
                  labelKey: 'supervisor.more.leaves',
                  subtitleKey: 'supervisor.more.leavesSubtitle',
                  backgroundColor: AppColors.softGreenBackground,
                  iconColor: AppColors.success,
                  onTap: () {
                    Navigator.pop(context);
                    onLeavesTap();
                  },
                ),
                SupervisorMoreOptionWidget(
                  icon: Icons.home_work_outlined,
                  labelKey: 'supervisor.more.remoteWork',
                  subtitleKey: 'supervisor.more.remoteWorkSubtitle',
                  backgroundColor: AppColors.softBlueBackground,
                  iconColor: AppColors.info,
                  onTap: () {
                    Navigator.pop(context);
                    onRemoteWorkTap();
                  },
                ),
                SupervisorMoreOptionWidget(
                  icon: Icons.notifications_none_rounded,
                  labelKey: 'supervisor.more.notifications',
                  subtitleKey: 'supervisor.more.notificationsSubtitle',
                  backgroundColor: AppColors.softBrandBackground,
                  iconColor: AppColors.brandPrimary,
                  onTap: () {
                    Navigator.pop(context);
                    onNotificationsTap();
                  },
                ),
                SupervisorMoreOptionWidget(
                  icon: Icons.person_outline_rounded,
                  labelKey: 'supervisor.more.profile',
                  subtitleKey: 'supervisor.more.profileSubtitle',
                  backgroundColor: AppColors.softYellowBackground,
                  iconColor: AppColors.warning,
                  onTap: () {
                    Navigator.pop(context);
                    onProfileTap();
                  },
                ),
                if (switch (context.watch<AuthProfileCubit>().state) {
                  AuthProfileSuccess(:final roles) => roles.length > 1,
                  _ => false,
                })
                  SupervisorMoreOptionWidget(
                    icon: Icons.swap_horiz_rounded,
                    labelKey: 'auth.role.switchRole',
                    subtitleKey: 'auth.role.currentRole',
                    backgroundColor: AppColors.softBrandBackground,
                    iconColor: AppColors.brandPrimary,
                    onTap: () {
                      Navigator.pop(context);
                      final state = context.read<AuthProfileCubit>().state;
                      if (state case AuthProfileSuccess(
                        :final role,
                        :final roles,
                      )) {
                        RoleSwitchDialogWidget.show(
                          context,
                          currentRole: role,
                          availableRoles: roles,
                        );
                      }
                    },
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
