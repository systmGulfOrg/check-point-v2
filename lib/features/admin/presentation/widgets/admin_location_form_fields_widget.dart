import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/projects/presentation/widgets/assignee_multi_select_widget.dart';
import 'admin_locations_tab_widget.dart';

class AdminLocationFormFieldsWidget extends StatefulWidget {
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
  State<AdminLocationFormFieldsWidget> createState() =>
      _AdminLocationFormFieldsWidgetState();
}

class _AdminLocationFormFieldsWidgetState
    extends State<AdminLocationFormFieldsWidget> {
  List<String> get _selectedAssignees {
    final text = widget.descriptionController.text.trim();
    if (text.isEmpty) return const [];
    return text
        .split(RegExp(r'[,،\n]+'))
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final isCustomer = widget.category == AdminLocationCategory.customers;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'admin.locations.create.nameLabel'.tr(context: context),
          style: AppTextStyles.font12Medium,
        ),
        hSpace(8),
        CustomTextFormField(
          controller: widget.nameController,
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
          controller: widget.addressController,
          hintText: 'admin.locations.create.addressHint'.tr(context: context),
          validator: AppValidators.required(
            message: 'admin.locations.create.addressRequired'.tr(
              context: context,
            ),
            context: context,
          ),
        ),
        hSpace(16),
        if (isCustomer) ...[
          AssigneeMultiSelectWidget(
            title: 'admin.locations.create.workedAsLabel'.tr(context: context),
            hintText: 'admin.locations.create.workedAsHint'.tr(context: context),
            selectedIds: _selectedAssignees,
            useNameAsKey: true,
            onChanged: (updatedList) {
              setState(() {
                widget.descriptionController.text = updatedList.join('، ');
              });
            },
          ),
        ] else ...[
          Text(
            'admin.locations.create.descriptionLabel'.tr(context: context),
            style: AppTextStyles.font12Medium,
          ),
          hSpace(8),
          CustomTextFormField(
            controller: widget.descriptionController,
            hintText: 'admin.locations.create.descriptionHint'.tr(
              context: context,
            ),
            maxLines: 2,
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
