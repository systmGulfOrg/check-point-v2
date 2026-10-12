import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/auth/presentation/cubit/profile/auth_profile_cubit.dart';
import 'package:check_point_v2/features/auth/presentation/cubit/profile/auth_profile_state.dart';
import 'package:check_point_v2/features/auth/presentation/widgets/role_switch_dialog_widget.dart';

class SupervisorTopBarWidget extends StatelessWidget {
  const SupervisorTopBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image.asset(AppAssets.logo, height: 45.h, fit: BoxFit.contain),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            BlocBuilder<AuthProfileCubit, AuthProfileState>(
              builder: (context, state) {
                return state.maybeWhen(
                  success: (name, userId, role, username, permissions, roles) {
                    if (roles.length <= 1) return const SizedBox.shrink();
                    return Padding(
                      padding: EdgeInsetsDirectional.only(end: 8.w),
                      child: Container(
                        height: 40.r,
                        decoration: BoxDecoration(
                          color: AppColors.softBrandBackground,
                          borderRadius: BorderRadius.circular(20.r),
                          border: Border.all(
                            color: AppColors.brandPrimary.withValues(alpha: 0.3),
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
                              padding: EdgeInsets.symmetric(horizontal: 10.w),
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
                                    style: AppTextStyles.font12Bold.copyWith(
                                      color: AppColors.brandPrimary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  orElse: () => const SizedBox.shrink(),
                );
              },
            ),
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
          ],
        ),
      ],
    );
  }
}
