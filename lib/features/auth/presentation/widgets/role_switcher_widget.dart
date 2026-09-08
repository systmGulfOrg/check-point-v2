import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'role_switcher_item_widget.dart';

class RoleSwitcherWidget extends StatelessWidget {
  const RoleSwitcherWidget({
    required this.roles,
    required this.selectedRole,
    required this.onRoleSelected,
    super.key,
  });

  final List<String> roles;
  final String selectedRole;
  final ValueChanged<String> onRoleSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(3.r),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(7.r),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: roles.map((roleKey) {
          return Expanded(
            child: RoleSwitcherItemWidget(
              roleKey: roleKey,
              isSelected: selectedRole == roleKey,
              onTap: () => onRoleSelected(roleKey),
            ),
          );
        }).toList(),
      ),
    );
  }
}
