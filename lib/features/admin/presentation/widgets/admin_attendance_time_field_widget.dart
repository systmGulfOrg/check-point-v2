import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:check_point_v2/core/core.dart';

class AdminAttendanceTimeFieldWidget extends StatelessWidget {
  const AdminAttendanceTimeFieldWidget({
    required this.labelKey,
    required this.controller,
    this.validator,
    super.key,
  });

  final String labelKey;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  TimeOfDay _parseInitialTime(String text) {
    if (text.isEmpty || text == '--:--') return TimeOfDay.now();
    final clean = text.trim().toUpperCase();
    final isPm = clean.contains('PM');
    final isAm = clean.contains('AM');
    final timePart = clean.replaceAll('AM', '').replaceAll('PM', '').trim();
    final parts = timePart.split(':');
    if (parts.length >= 2) {
      var h = int.tryParse(parts[0]) ?? 12;
      final m = int.tryParse(parts[1]) ?? 0;
      if (isPm && h < 12) h += 12;
      if (isAm && h == 12) h = 0;
      return TimeOfDay(hour: h.clamp(0, 23), minute: m.clamp(0, 59));
    }
    return TimeOfDay.now();
  }

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
          validator: validator,
          onTap: () async {
            final time = await showTimePicker(
              context: context,
              initialTime: _parseInitialTime(controller.text),
            );
            if (time != null && context.mounted) {
              final h = time.hour.toString().padLeft(2, '0');
              final m = time.minute.toString().padLeft(2, '0');
              controller.text = '$h:$m';
            }
          },
        ),
      ],
    );
  }
}
