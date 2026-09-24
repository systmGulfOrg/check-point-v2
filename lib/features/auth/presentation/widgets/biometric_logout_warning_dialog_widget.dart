import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:check_point_v2/core/core.dart';

class BiometricLogoutWarningDialogWidget extends StatelessWidget {
  const BiometricLogoutWarningDialogWidget({super.key});

  @override
  Widget build(BuildContext context) => CustomDialogWidget(
    title: 'auth.logout.biometricWarningTitle'.tr(context: context),
    message: 'auth.logout.biometricWarningMessage'.tr(context: context),
    icon: Icons.fingerprint_rounded,
    iconColor: AppColors.error,
    iconBackgroundColor: AppColors.softRedBackground,
    confirmLabel: 'auth.logout.confirm'.tr(context: context),
    confirmButtonColor: AppColors.error,
    cancelLabel: 'auth.logout.cancel'.tr(context: context),
    onConfirm: () => Navigator.pop(context, true),
  );
}
