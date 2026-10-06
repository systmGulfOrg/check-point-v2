import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

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
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'admin.locations.create.nameRequired'.tr(context: context);
            }
            return null;
          },
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
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'admin.locations.create.addressRequired'.tr(
                context: context,
              );
            }
            return null;
          },
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
