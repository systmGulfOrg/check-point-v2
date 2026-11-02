import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/auth/presentation/cubit/profile/auth_profile_cubit.dart';
import 'package:check_point_v2/features/auth/presentation/widgets/role_switch_dialog_widget.dart';

/// Role switch chip, shown only to users with more than one role.
class EmployeeRoleSwitchBlocBuilderWidget extends StatelessWidget {
  const EmployeeRoleSwitchBlocBuilderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthProfileCubit, AuthProfileState>(
      builder: (context, state) => switch (state) {
        AuthProfileSuccess(:final roles, :final role) when roles.length > 1 =>
          Padding(
            padding: EdgeInsetsDirectional.only(end: 8.w),
            child: Material(
              color: AppColors.softBrandBackground,
              borderRadius: BorderRadius.circular(20.r),
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
                    vertical: 8.h,
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
        _ => const SizedBox.shrink(),
      },
    );
  }
}
