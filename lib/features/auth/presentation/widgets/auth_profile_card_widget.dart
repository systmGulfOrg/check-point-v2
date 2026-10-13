import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/auth/presentation/cubit/profile/auth_profile_cubit.dart';
import 'package:check_point_v2/features/auth/presentation/cubit/profile/auth_profile_state.dart';
import 'package:check_point_v2/features/auth/presentation/widgets/edit_profile_sheet_widget.dart';
import 'package:check_point_v2/features/auth/presentation/widgets/role_switch_dialog_widget.dart';
import 'package:check_point_v2/features/attendance_points/presentation/cubit/points_cubit.dart';
import 'package:check_point_v2/features/attendance_points/presentation/cubit/points_state.dart';
import 'package:check_point_v2/features/attendance_points/presentation/widgets/profile_points_badge_widget.dart';

class AuthProfileCardWidget extends StatelessWidget {
  const AuthProfileCardWidget({super.key, this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final pointsState = context.watch<PointsCubit?>()?.state;

    return BlocBuilder<AuthProfileCubit, AuthProfileState>(
      builder: (context, state) {
        return switch (state) {
          AuthProfileLoading() || AuthProfileInitial() => Container(
            height: 190.h,
            decoration: BoxDecoration(
              color: AppColors.pageBackground,
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: const Center(child: CircularProgressIndicator()),
          ),
          AuthProfileError(:final messageKey) => Container(
            width: double.infinity,
            padding: EdgeInsets.all(20.r),
            decoration: BoxDecoration(
              color: AppColors.softRedBackground,
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Text(messageKey.tr(context: context)),
          ),
          AuthProfileSuccess(
            :final name,
            :final userId,
            :final role,
            :final username,
            :final roles,
          ) =>
            InkWell(
              onTap: onTap ?? () => showEditProfileSheet(context),
              borderRadius: BorderRadius.circular(20.r),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
                decoration: BoxDecoration(
                  color: AppColors.cardBackground,
                  borderRadius: BorderRadius.circular(20.r),
                  border: Border.all(color: AppColors.border),
                  boxShadow: const [
                    BoxShadow(
                      color: AppColors.shadow,
                      blurRadius: 12,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.center,
                      children: [
                        AppAvatarWidget(
                          name: name,
                          subtitle: username,
                          radius: 32.r,
                          enablePreview: true,
                        ),
                        if (pointsState case PointsLoaded(:final summary))
                          Positioned(
                            top: -28.h,
                            child: ProfilePointsBadgeWidget(
                              tier: summary.level.tier,
                              points: summary.level.currentPoints,
                            ),
                          ),
                      ],
                    ),
                    hSpace(12),
                    Text(
                      name.isEmpty
                          ? 'profile.defaultName'.tr(context: context)
                          : name,
                      style: AppTextStyles.font18Bold,
                    ),
                    hSpace(4),
                    Text(
                      username.isEmpty ? '-' : username,
                      style: AppTextStyles.font13Regular,
                    ),
                    hSpace(14),
                    Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 8.w,
                      runSpacing: 6.h,
                      children: [
                        InkWell(
                          onTap: roles.length > 1
                              ? () => RoleSwitchDialogWidget.show(
                                  context,
                                  currentRole: role,
                                  availableRoles: roles,
                                )
                              : null,
                          borderRadius: BorderRadius.circular(12.r),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 12.w,
                              vertical: 4.h,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.softBrandBackground,
                              borderRadius: BorderRadius.circular(12.r),
                              border: roles.length > 1
                                  ? Border.all(
                                      color: AppColors.brandPrimary.withValues(
                                        alpha: 0.3,
                                      ),
                                    )
                                  : null,
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  role.isEmpty ? '-' : role,
                                  style: AppTextStyles.font12Bold.copyWith(
                                    color: AppColors.brandPrimary,
                                  ),
                                ),
                                if (roles.length > 1) ...[
                                  wSpace(4),
                                  Icon(
                                    Icons.swap_horiz_rounded,
                                    size: 14.r,
                                    color: AppColors.brandPrimary,
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ),
                        if (userId.isNotEmpty)
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 12.w,
                              vertical: 4.h,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.pageBackground,
                              borderRadius: BorderRadius.circular(12.r),
                              border: Border.all(color: AppColors.border),
                            ),
                            child: Text(
                              userId,
                              style: AppTextStyles.font12Regular,
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          _ => const SizedBox.shrink(),
        };
      },
    );
  }
}
