import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';

class AdminWizardFieldWidget extends StatelessWidget {
  const AdminWizardFieldWidget({
    required this.label,
    required this.child,
    super.key,
    this.required = true,
  });

  final String label;
  final Widget child;
  final bool required;

  @override
  Widget build(BuildContext context) => Padding(
    padding: EdgeInsets.only(bottom: 14.h),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          required ? '$label *' : label,
          textAlign: TextAlign.right,
          style: AppTextStyles.font13SemiBold,
        ),
        hSpace(7),
        child,
      ],
    ),
  );
}
