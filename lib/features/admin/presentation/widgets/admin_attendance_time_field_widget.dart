import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:check_point_v2/core/core.dart';

class AdminAttendanceTimeFieldWidget extends StatelessWidget {
  const AdminAttendanceTimeFieldWidget({
    required this.labelKey,
    required this.controller,
    super.key,
  });

  final String labelKey;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(labelKey.tr(context: context), style: AppTextStyles.font12Medium),
        hSpace(8),
        CustomTextFormField(
          controller: controller,
          hintText: 'supervisor.plans.create.timeHint'.tr(context: context),
          readOnly: true,
          onTap: () async {
            final time = await showTimePicker(
              context: context,
              initialTime: TimeOfDay.now(),
            );
            if (time != null && context.mounted) {
              controller.text = time.format(context);
            }
          },
        ),
      ],
    );
  }
}
