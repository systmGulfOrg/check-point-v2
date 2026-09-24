import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:check_point_v2/core/core.dart';
import '../admin_employee_profile_info_card_widget.dart';

class AdminEmployeeEditEmergencyCardWidget extends StatelessWidget {
  const AdminEmployeeEditEmergencyCardWidget({
    required this.emergencyNameController,
    required this.emergencyRelationController,
    required this.emergencyPhoneController,
    super.key,
  });

  final TextEditingController emergencyNameController;
  final TextEditingController emergencyRelationController;
  final TextEditingController emergencyPhoneController;

  @override
  Widget build(BuildContext context) {
    return AdminEmployeeProfileInfoCardWidget(
      title: 'employee.profile.sectionEmergency'.tr(context: context),
      icon: Icons.emergency_outlined,
      children: [
        CustomTextFormField(
          controller: emergencyNameController,
          hintText: 'employee.profile.emergencyName'.tr(context: context),
          prefixIcon: const Icon(Icons.person_pin_outlined, color: AppColors.brandPrimary),
        ),
        hSpace(10),
        CustomTextFormField(
          controller: emergencyRelationController,
          hintText: 'employee.profile.emergencyRelation'.tr(context: context),
          prefixIcon: const Icon(Icons.favorite_outline_rounded, color: AppColors.brandPrimary),
        ),
        hSpace(10),
        CustomTextFormField(
          controller: emergencyPhoneController,
          hintText: 'employee.profile.emergencyPhone'.tr(context: context),
          keyboardType: TextInputType.phone,
          prefixIcon: const Icon(Icons.phone_in_talk_outlined, color: AppColors.brandPrimary),
        ),
      ],
    );
  }
}
