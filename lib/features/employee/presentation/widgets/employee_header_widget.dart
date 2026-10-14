import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/auth/presentation/cubit/profile/auth_profile_cubit.dart';
import 'package:check_point_v2/features/auth/presentation/widgets/role_switch_dialog_widget.dart';

class EmployeeHeaderWidget extends StatelessWidget {
  const EmployeeHeaderWidget({
    required this.titleKey,
    required this.userName,
    required this.dateText,
    required this.notificationCount,
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
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      width: 40.r,
                      height: 40.r,
                      decoration: BoxDecoration(
                        color: AppColors.cardBackground,
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.border),
                        boxShadow: const [
                          BoxShadow(
                            color: AppColors.shadow,
                            blurRadius: 8,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {},
                        icon: Icon(
                          Icons.notifications_none_rounded,
                          color: AppColors.brandInk,
                          size: 20.r,
                        ),
                      ),
                    ),
                    if (notificationCount > 0)
                      Positioned(
                        top: -2.h,
                        right: -2.w,
                        child: Container(
                          padding: EdgeInsets.all(4.r),
                          decoration: const BoxDecoration(
                            color: AppColors.brandPrimary,
                            shape: BoxShape.circle,
                          ),
                          constraints: BoxConstraints(
                            minWidth: 16.r,
                            minHeight: 16.r,
                          ),
                          child: Center(
                            child: Text(
                              '$notificationCount',
                              style: AppTextStyles.font11Medium.copyWith(
                                color: AppColors.white,
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
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
