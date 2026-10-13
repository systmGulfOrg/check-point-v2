import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:check_point_v2/features/auth/presentation/cubit/profile/auth_profile_cubit.dart';
import 'package:check_point_v2/features/auth/presentation/cubit/profile/auth_profile_state.dart';
import 'package:check_point_v2/features/auth/presentation/widgets/edit_profile_sheet_widget.dart';
import 'employee_settings_tile_widget.dart';

class EmployeeProfileNameTileBlocBuilderWidget extends StatelessWidget {
  const EmployeeProfileNameTileBlocBuilderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthProfileCubit, AuthProfileState>(
      builder: (context, state) {
        final name = state.maybeWhen(
          success: (fullName, userId, role, username, permissions, roles) =>
              fullName.trim().isNotEmpty ? fullName : username,
          orElse: () => '',
        );
        return EmployeeSettingsTileWidget(
          icon: Icons.person_outline_rounded,
          titleKey: 'employee.settings.profileInfo',
          valueKey: name,
          onTap: () => showEditProfileSheet(context),
        );
      },
    );
  }
}
