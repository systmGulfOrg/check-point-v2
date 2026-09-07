import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/core.dart';

class AdminLocationSheetActionsWidget extends StatelessWidget {
  const AdminLocationSheetActionsWidget({
    required this.isLoading,
    required this.onCancel,
    required this.onSave,
    super.key,
  });

  final bool isLoading;
  final VoidCallback onCancel;
  final VoidCallback onSave;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomButton(
            text: 'admin.locations.create.cancel'.tr(context: context),
            onTap: onCancel,
            backgroundColor: AppColors.pageBackground,
            textColor: AppColors.textPrimary,
          ),
        ),
        vSpace(12),
        Expanded(
          child: CustomButton(
            text: 'admin.locations.create.save'.tr(context: context),
            onTap: onSave,
            isLoading: isLoading,
          ),
        ),
      ],
    );
  }
}
