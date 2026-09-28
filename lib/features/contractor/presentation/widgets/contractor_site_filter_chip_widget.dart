import 'package:flutter/material.dart';
import 'package:check_point_v2/core/styles/app_colors.dart';
import 'package:check_point_v2/core/styles/app_text_styles.dart';

class ContractorSiteFilterChipWidget extends StatelessWidget {
  const ContractorSiteFilterChipWidget({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onSelected,
  });

  final String label;
  final bool isSelected;
  final ValueChanged<bool> onSelected;

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: Text(
        label,
        style: AppTextStyles.font11Medium.copyWith(
          color: isSelected ? AppColors.white : AppColors.textPrimary,
          fontWeight: FontWeight.w600,
        ),
      ),
      selected: isSelected,
      selectedColor: AppColors.brandPrimary,
      backgroundColor: AppColors.pageBackground,
      onSelected: onSelected,
    );
  }
}
