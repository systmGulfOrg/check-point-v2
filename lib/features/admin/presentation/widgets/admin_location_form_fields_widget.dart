import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'admin_locations_tab_widget.dart';

class AdminLocationFormFieldsWidget extends StatelessWidget {
  const AdminLocationFormFieldsWidget({
    required this.category,
    required this.nameController,
    required this.addressController,
    required this.descriptionController,
    super.key,
  });

  final AdminLocationCategory category;
  final TextEditingController nameController;
  final TextEditingController addressController;
  final TextEditingController descriptionController;

  static const List<String> _defaultEmployeeSuggestions = [
    'أحمد',
    'محمد',
    'عمر',
    'سارة',
    'خالد',
  ];

  void _toggleEmployee(String employeeName) {
    final currentText = descriptionController.text.trim();
    final names = currentText
        .split(RegExp(r'[,،、\n]+'))
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toList();

    if (names.contains(employeeName)) {
      names.remove(employeeName);
    } else {
      names.add(employeeName);
    }
    descriptionController.text = names.join('، ');
  }

  @override
  Widget build(BuildContext context) {
    final isCustomer = category == AdminLocationCategory.customers;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'admin.locations.create.nameLabel'.tr(context: context),
          style: AppTextStyles.font12Medium,
        ),
        hSpace(8),
        CustomTextFormField(
          controller: nameController,
          hintText: 'admin.locations.create.nameHint'.tr(context: context),
          validator: AppValidators.required(
            message: 'admin.locations.create.nameRequired'.tr(context: context),
            context: context,
          ),
        ),
        hSpace(16),
        Text(
          'admin.locations.create.addressLabel'.tr(context: context),
          style: AppTextStyles.font12Medium,
        ),
        hSpace(8),
        CustomTextFormField(
          controller: addressController,
          hintText: 'admin.locations.create.addressHint'.tr(context: context),
          validator: AppValidators.required(
            message: 'admin.locations.create.addressRequired'.tr(
              context: context,
            ),
            context: context,
          ),
        ),
        hSpace(16),
        Text(
          isCustomer
              ? 'admin.locations.create.workedAsLabel'.tr(context: context)
              : 'admin.locations.create.descriptionLabel'.tr(context: context),
          style: AppTextStyles.font12Medium,
        ),
        hSpace(8),
        CustomTextFormField(
          controller: descriptionController,
          hintText: isCustomer
              ? 'admin.locations.create.workedAsHint'.tr(context: context)
              : 'admin.locations.create.descriptionHint'.tr(context: context),
          maxLines: 2,
        ),
        if (isCustomer) ...[
          hSpace(8),
          Wrap(
            spacing: 6.w,
            runSpacing: 6.h,
            children: _defaultEmployeeSuggestions.map((emp) {
              final isSelected = descriptionController.text.contains(emp);
              return ActionChip(
                avatar: Icon(
                  isSelected ? Icons.check_circle_rounded : Icons.person_outline_rounded,
                  size: 14.r,
                  color: isSelected ? AppColors.brandPrimary : AppColors.textSecondary,
                ),
                label: Text(
                  emp,
                  style: AppTextStyles.font11Medium.copyWith(
                    color: isSelected ? AppColors.brandPrimary : AppColors.textPrimary,
                  ),
                ),
                backgroundColor: isSelected
                    ? AppColors.softBrandBackground
                    : AppColors.fieldBackground,
                side: BorderSide(
                  color: isSelected
                      ? AppColors.brandPrimary.withValues(alpha: 0.4)
                      : AppColors.border,
                ),
                onPressed: () => _toggleEmployee(emp),
              );
            }).toList(),
          ),
        ],
        hSpace(16),
        Text(
          'admin.locations.create.geofenceTitle'.tr(context: context),
          style: AppTextStyles.font12Medium,
        ),
        hSpace(4),
        Text(
          'admin.locations.create.geofenceDescription'.tr(context: context),
          style: AppTextStyles.font12Regular.copyWith(
            color: AppColors.placeholder,
          ),
        ),
        hSpace(8),
      ],
    );
  }
}
