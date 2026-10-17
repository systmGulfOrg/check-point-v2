import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/auth/presentation/cubit/profile/auth_profile_cubit.dart';
import 'package:check_point_v2/features/auth/presentation/widgets/role_switch_dialog_widget.dart';
import 'package:check_point_v2/features/notifications/presentation/widgets/notifications_icon_button_bloc_selector_widget.dart';

class EmployeeHeaderWidget extends StatelessWidget {
  const EmployeeHeaderWidget({
    required this.titleKey,
    required this.userName,
    required this.dateText,
    this.notificationCount = 0,
    super.key,
  });

  final String titleKey;
  final String userName;
  final String dateText;
  final int notificationCount;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              titleKey.tr(context: context),
              style: AppTextStyles.font24Bold,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                BlocBuilder<AuthProfileCubit, AuthProfileState>(
                  builder: (context, state) {
                    return switch (state) {
                      AuthProfileSuccess(:final roles, :final role)
                          when roles.length > 1 =>
                        Padding(
                          padding: EdgeInsetsDirectional.only(end: 8.w),
                          child: Container(
                            height: 40.r,
                            decoration: BoxDecoration(
                              color: AppColors.softBrandBackground,
                              borderRadius: BorderRadius.circular(20.r),
                              border: Border.all(
                                color: AppColors.brandPrimary.withValues(
                                  alpha: 0.3,
                                ),
                              ),
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () => RoleSwitchDialogWidget.show(
                                  context,
                                  currentRole: role,
                                  availableRoles: roles,
                                ),
                                borderRadius: BorderRadius.circular(20.r),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 10.w,
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.swap_horiz_rounded,
                                        color: AppColors.brandPrimary,
                                        size: 18.r,
                                      ),
                                      wSpace(4),
                                      Text(
                                        role,
                                        style: AppTextStyles.font12Bold
                                            .copyWith(
                                              color: AppColors.brandPrimary,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      _ => const SizedBox.shrink(),
                    };
                  },
                ),
                const NotificationsIconButtonBlocSelectorWidget(),
              ],
            ),
          ],
        ),
        hSpace(16),
        Text(
          'employee.home.greeting'.tr(context: context),
          style: AppTextStyles.font14Regular,
        ),
        hSpace(4),
        Text(userName, style: AppTextStyles.font20Bold),
        hSpace(4),
        Text(dateText, style: AppTextStyles.font13Regular),
      ],
    );
  }
}
