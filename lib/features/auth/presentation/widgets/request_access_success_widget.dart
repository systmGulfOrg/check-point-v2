import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/core.dart';

class RequestAccessSuccessWidget extends StatelessWidget {
  const RequestAccessSuccessWidget({required this.onBack, super.key});

  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) => Column(
    children: [
      Container(
        width: 76.r,
        height: 76.r,
        decoration: const BoxDecoration(
          color: AppColors.softGreenBackground,
          shape: BoxShape.circle,
        ),
        child: Icon(Icons.check_rounded, color: AppColors.success, size: 42),
      ),
      hSpace(22),
      Text(
        'auth.requestAccess.successTitle'.tr(context: context),
        textAlign: TextAlign.center,
        style: AppTextStyles.font20Bold.copyWith(color: AppColors.brandInk),
      ),
      hSpace(10),
      Text(
        'auth.requestAccess.successDescription'.tr(context: context),
        textAlign: TextAlign.center,
        style: AppTextStyles.font14Regular.copyWith(height: 1.65),
      ),
      hSpace(28),
      CustomButton(
        text: 'auth.requestAccess.back'.tr(context: context),
        onTap: onBack,
        gradient: AppColors.brandGradient,
        height: 54,
      ),
    ],
  );
}
