import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'admin_locations_tab_widget.dart';

class AdminLocationSheetHeaderWidget extends StatelessWidget {
  const AdminLocationSheetHeaderWidget({
    required this.category,
    required this.isEdit,
    required this.onClose,
    super.key,
  });

  final AdminLocationCategory category;
  final bool isEdit;
  final VoidCallback onClose;

  String get _titleKey => switch (category) {
    AdminLocationCategory.branches =>
      isEdit
          ? 'admin.locations.create.editBranchTitle'
          : 'admin.locations.create.branchTitle',
    AdminLocationCategory.customers =>
      isEdit
          ? 'admin.locations.create.editCustomerTitle'
          : 'admin.locations.create.customerTitle',
  };

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              _titleKey.tr(context: context),
              style: AppTextStyles.font18Bold,
            ),
            IconButton(
              onPressed: onClose,
              icon: Icon(Icons.close_rounded, size: 20.r),
            ),
          ],
        ),
        const Divider(color: AppColors.border),
      ],
    );
  }
}
