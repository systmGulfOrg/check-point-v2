import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/core.dart';

class AdminSettingsSectionCardWidget extends StatelessWidget {
  const AdminSettingsSectionCardWidget({
    required this.sectionTitleKey,
    required this.tiles,
    super.key,
  });

  final String sectionTitleKey;
  final List<Widget> tiles;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          sectionTitleKey.tr(context: context),
          style: AppTextStyles.font12Bold.copyWith(
            color: AppColors.textSecondary,
            letterSpacing: 0.5,
          ),
        ),
        hSpace(8),
        Container(
          decoration: BoxDecoration(
            color: AppColors.cardBackground,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: AppColors.border),
            boxShadow: const [
              BoxShadow(
                color: AppColors.shadow,
                blurRadius: 10,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            children: [
              for (int i = 0; i < tiles.length; i++) ...[
                if (i > 0) const Divider(color: AppColors.border, height: 1),
                tiles[i],
              ],
            ],
          ),
        ),
      ],
    );
  }
}
