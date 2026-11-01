import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/attendance_points/presentation/cubit/points_cubit.dart';
import 'package:check_point_v2/features/attendance_points/presentation/cubit/points_state.dart';
import 'package:check_point_v2/features/auth/presentation/widgets/role_switch_dialog_widget.dart';

/// Avatar, name, role and username of the signed-in user, with the points
/// tier when the points feature is on.
class AuthProfileCardContentWidget extends StatelessWidget {
  const AuthProfileCardContentWidget({
    required this.name,
    required this.username,
    required this.role,
    required this.roles,
    this.imageUrl,
    super.key,
  });

  final String name;
  final String username;
  final String role;
  final List<String> roles;
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    final points = context.watch<PointsCubit?>()?.state;
    const knownRoles = {'admin', 'employee', 'supervisor', 'hr'};
    final roleLabel = knownRoles.contains(role.toLowerCase())
        ? 'auth.role.${role.toLowerCase()}'.tr(context: context)
        : role;
    return Column(
      children: [
        AppAvatarWidget(
          imageUrl: imageUrl,
          name: name,
          radius: 36.r,
          backgroundColor: AppColors.softBrandBackground,
          textColor: AppColors.brandPrimaryDark,
        ),
        hSpace(12),
        Text(
          name.isEmpty ? 'profile.defaultName'.tr(context: context) : name,
          style: AppTextStyles.font18Bold,
        ),
        hSpace(2),
        Text(
          [roleLabel, username].where((s) => s.isNotEmpty).join(' · '),
          style: AppTextStyles.font13Regular.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        if (points case PointsLoaded(:final summary)) ...[
          hSpace(10),
          AppStatusPillWidget(
            label:
                '${'points.tier.${summary.level.tier.toUpperCase()}'.tr(context: context)} · ${summary.level.currentPoints}',
            icon: Icons.workspace_premium_outlined,
            color: AppColors.amberDark,
            backgroundColor: AppColors.softYellowBackground,
          ),
        ],
        if (roles.length > 1) ...[
          hSpace(8),
          TextButton.icon(
            onPressed: () => RoleSwitchDialogWidget.show(
              context,
              currentRole: role,
              availableRoles: roles,
            ),
            icon: Icon(Icons.swap_horiz_rounded, size: 18.r),
            label: Text('auth.role.switchRole'.tr(context: context)),
          ),
        ],
      ],
    );
  }
}
