import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:check_point_v2/core/core.dart';

class RequestAccessWelcomeWidget extends StatelessWidget {
  const RequestAccessWelcomeWidget({super.key});

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        'auth.requestAccess.welcomeTitle'.tr(context: context),
        textAlign: TextAlign.center,
        style: AppTextStyles.font24Bold.copyWith(
          color: AppColors.brandInk,
          height: 1.25,
        ),
      ),
      hSpace(8),
      Text(
        'auth.requestAccess.welcomeDescription'.tr(context: context),
        textAlign: TextAlign.center,
        style: AppTextStyles.font14Regular.copyWith(height: 1.65),
      ),
    ],
  );
}
