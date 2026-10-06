import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/admin/data/models/permissions/admin_permissions_catalogue_model.dart';

class AdminPermissionsPickerDialogWidget extends StatefulWidget {
  const AdminPermissionsPickerDialogWidget({
    required this.catalogue,
    required this.initialSelectedPermissions,
    super.key,
  });

  final AdminPermissionsCatalogueModel catalogue;
  final Set<String> initialSelectedPermissions;

  static Future<Set<String>?> show(
    BuildContext context, {
    required AdminPermissionsCatalogueModel catalogue,
    required Set<String> initialSelectedPermissions,
  }) {
    return showDialog<Set<String>>(
      context: context,
      barrierDismissible: true,
      builder: (_) => AdminPermissionsPickerDialogWidget(
        catalogue: catalogue,
        initialSelectedPermissions: initialSelectedPermissions,
      ),
    );
  }

  @override
  State<AdminPermissionsPickerDialogWidget> createState() =>
      _AdminPermissionsPickerDialogWidgetState();
}

class _AdminPermissionsPickerDialogWidgetState
    extends State<AdminPermissionsPickerDialogWidget> {
  late final Set<String> tempSelected;
  late final TextEditingController searchController;
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    tempSelected = Set<String>.from(widget.initialSelectedPermissions);
    searchController = TextEditingController();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  Map<String, List<String>> _getGroupedPermissions() {
    final grouped = <String, List<String>>{};
    final query = searchQuery.trim().toLowerCase();

    for (final perm in widget.catalogue.catalogue) {
      if (query.isNotEmpty && !perm.toLowerCase().contains(query)) {
        continue;
      }
      final group = perm.split('.').first;
      grouped.putIfAbsent(group, () => []).add(perm);
    }
    return grouped;
  }

  void _toggleGroup(List<String> permissions, bool selectAll) {
    setState(() {
      if (selectAll) {
        tempSelected.addAll(permissions);
      } else {
        tempSelected.removeAll(permissions);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final grouped = _getGroupedPermissions();
    final allPermsCount = widget.catalogue.catalogue.length;
    final totalSelected = tempSelected.length;

    return Dialog(
      backgroundColor: AppColors.white,
      insetPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.85,
          maxWidth: 500.w,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(20.w, 18.h, 14.w, 12.h),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(8.r),
                    decoration: BoxDecoration(
                      color: AppColors.softBlueBackground,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Icon(
                      Icons.security_rounded,
                      color: AppColors.brandPrimary,
                      size: 20.r,
                    ),
                  ),
                  vSpace(12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'admin.employeeWizard.permissionsDialogTitle'.tr(
                            context: context,
                          ),
                          style: AppTextStyles.font16Bold.copyWith(
                            color: AppColors.brandInk,
                          ),
                        ),
                        Text(
                          '$totalSelected / $allPermsCount ${'admin.employeeWizard.permissionsSelectedCount'.tr(context: context)}',
                          style: AppTextStyles.font12Regular.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close_rounded),
                    color: AppColors.textSecondary,
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ),
            const Divider(height: 1, color: AppColors.border),

            // Search Bar & Quick Actions
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              child: Column(
                children: [
                  CustomTextFormField(
                    hintText: 'admin.employeeWizard.permissionsSearchHint'.tr(
                      context: context,
                    ),
                    controller: searchController,
                    prefixIcon: Icon(
                      Icons.search_rounded,
                      size: 20.r,
                      color: AppColors.placeholder,
                    ),
                    suffixIcon: searchQuery.isNotEmpty
                        ? IconButton(
                            icon: Icon(Icons.clear_rounded, size: 18.r),
                            onPressed: () {
                              searchController.clear();
                              setState(() => searchQuery = '');
                            },
                          )
                        : null,
                    onChanged: (val) {
                      setState(() => searchQuery = val);
                    },
                  ),
                  hSpace(8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton.icon(
                        onPressed: () {
                          setState(() {
                            tempSelected.addAll(widget.catalogue.catalogue);
                          });
                        },
                        icon: Icon(Icons.done_all_rounded, size: 16.r),
                        label: Text(
                          'admin.employeeWizard.selectAll'.tr(context: context),
                          style: AppTextStyles.font12Medium,
                        ),
                      ),
                      TextButton.icon(
                        onPressed: () {
                          setState(() {
                            tempSelected.clear();
                          });
                        },
                        icon: Icon(Icons.clear_all_rounded, size: 16.r),
                        label: Text(
                          'admin.employeeWizard.deselectAll'.tr(
                            context: context,
                          ),
                          style: AppTextStyles.font12Medium.copyWith(
                            color: AppColors.error,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Divider(height: 1, color: AppColors.border),

            // Permission Groups List
            Expanded(
              child: grouped.isEmpty
                  ? Center(
                      child: Padding(
                        padding: EdgeInsets.all(24.r),
                        child: Text(
                          'admin.employeeWizard.noPermissionsFound'.tr(
                            context: context,
                          ),
                          style: AppTextStyles.font14Regular.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ),
                    )
                  : ListView.separated(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 12.h,
                      ),
                      itemCount: grouped.length,
                      separatorBuilder: (context, index) => hSpace(8),
                      itemBuilder: (context, index) {
                        final entry = grouped.entries.elementAt(index);
                        final groupName = entry.key;
                        final perms = entry.value;
                        final groupSelectedCount = perms
                            .where((p) => tempSelected.contains(p))
                            .length;
                        final isAllGroupSelected =
                            groupSelectedCount == perms.length;

                        return Container(
                          decoration: BoxDecoration(
                            color: AppColors.pageBackground,
                            borderRadius: BorderRadius.circular(12.r),
                            border: Border.all(color: AppColors.border),
                          ),
                          child: Theme(
                            data: Theme.of(
                              context,
                            ).copyWith(dividerColor: Colors.transparent),
                            child: ExpansionTile(
                              tilePadding: EdgeInsets.symmetric(
                                horizontal: 12.w,
                                vertical: 2.h,
                              ),
                              childrenPadding: EdgeInsets.symmetric(
                                horizontal: 12.w,
                                vertical: 4.h,
                              ),
                              title: Row(
                                children: [
                                  Text(
                                    groupName,
                                    style: AppTextStyles.font14Bold.copyWith(
                                      color: AppColors.brandInk,
                                    ),
                                  ),
                                  vSpace(8),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 8.w,
                                      vertical: 2.h,
                                    ),
                                    decoration: BoxDecoration(
                                      color: groupSelectedCount > 0
                                          ? AppColors.softBlueBackground
                                          : AppColors.border.withValues(
                                              alpha: 0.4,
                                            ),
                                      borderRadius: BorderRadius.circular(6.r),
                                    ),
                                    child: Text(
                                      '$groupSelectedCount/${perms.length}',
                                      style: AppTextStyles.font12Bold.copyWith(
                                        color: groupSelectedCount > 0
                                            ? AppColors.brandPrimary
                                            : AppColors.textSecondary,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: Icon(
                                      isAllGroupSelected
                                          ? Icons.check_box_rounded
                                          : Icons
                                                .check_box_outline_blank_rounded,
                                      size: 20.r,
                                      color: isAllGroupSelected
                                          ? AppColors.brandPrimary
                                          : AppColors.textSecondary,
                                    ),
                                    onPressed: () => _toggleGroup(
                                      perms,
                                      !isAllGroupSelected,
                                    ),
                                  ),
                                  const Icon(Icons.expand_more_rounded),
                                ],
                              ),
                              children: perms.map((perm) {
                                final isSelected = tempSelected.contains(perm);
                                return CheckboxListTile(
                                  dense: true,
                                  contentPadding: EdgeInsets.zero,
                                  title: Text(
                                    perm,
                                    style: AppTextStyles.font13Regular.copyWith(
                                      color: isSelected
                                          ? AppColors.brandInk
                                          : AppColors.textSecondary,
                                      fontWeight: isSelected
                                          ? FontWeight.w600
                                          : FontWeight.w400,
                                    ),
                                  ),
                                  value: isSelected,
                                  activeColor: AppColors.brandPrimary,
                                  onChanged: (val) {
                                    setState(() {
                                      if (val == true) {
                                        tempSelected.add(perm);
                                      } else {
                                        tempSelected.remove(perm);
                                      }
                                    });
                                  },
                                );
                              }).toList(),
                            ),
                          ),
                        );
                      },
                    ),
            ),

            const Divider(height: 1, color: AppColors.border),

            // Bottom Actions
            Padding(
              padding: EdgeInsets.all(16.r),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        side: const BorderSide(color: AppColors.border),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      child: Text(
                        'admin.employeeWizard.cancel'.tr(context: context),
                        style: AppTextStyles.font14Medium.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ),
                  ),
                  vSpace(12),
                  Expanded(
                    child: CustomButton(
                      text:
                          '${'admin.employeeWizard.savePermissions'.tr(context: context)} ($totalSelected)',
                      onTap: () => Navigator.of(context).pop(tempSelected),
                      backgroundColor: AppColors.brandPrimary,
                      height: 48,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
