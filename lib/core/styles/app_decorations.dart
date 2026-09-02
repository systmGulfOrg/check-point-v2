import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppDecorations {
  const AppDecorations._();

  static const BoxDecoration card = BoxDecoration(
    color: AppColors.cardBackground,
    borderRadius: BorderRadius.all(Radius.circular(18)),
    border: Border.fromBorderSide(BorderSide(color: AppColors.border)),
    boxShadow: [
      BoxShadow(color: AppColors.shadow, blurRadius: 12, offset: Offset(0, 4)),
    ],
  );
}
