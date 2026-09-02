import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/core.dart';

class SupervisorCreateTaskFieldWidget extends StatelessWidget {
  const SupervisorCreateTaskFieldWidget({
    required this.labelKey,
    required this.hintKey,
    required this.controller,
    super.key,
    this.maxLines = 1,
    this.readOnly = false,
    this.onTap,
    this.suffixIcon,
  });

  final String labelKey;
  final String hintKey;
  final TextEditingController controller;
  final int maxLines;
  final bool readOnly;
  final VoidCallback? onTap;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(labelKey.tr(context: context), style: AppTextStyles.font12Medium),
        hSpace(8),
        CustomTextFormField(
          controller: controller,
          hintText: hintKey.tr(context: context),
          maxLines: maxLines,
          readOnly: readOnly,
          onTap: onTap,
          suffixIcon: suffixIcon,
        ),
      ],
    );
  }
}
