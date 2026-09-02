import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/core.dart';

class AuthLabeledFieldWidget extends StatelessWidget {
  const AuthLabeledFieldWidget({
    required this.labelKey,
    required this.hintKey,
    super.key,
    this.controller,
    this.keyboardType,
    this.obscureText = false,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
  });

  final String labelKey;
  final String hintKey;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool obscureText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelKey.tr(context: context),
          style: AppTextStyles.font14SemiBold,
        ),
        hSpace(10),
        CustomTextFormField(
          controller: controller,
          hintText: hintKey.tr(context: context),
          keyboardType: keyboardType,
          obscureText: obscureText,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          validator: validator,
        ),
      ],
    );
  }
}
