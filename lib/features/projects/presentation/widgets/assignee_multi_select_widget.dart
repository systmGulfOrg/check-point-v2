import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/core/di/service_locator.dart';
import 'package:check_point_v2/features/admin/data/models/employee/employee_model.dart';
import 'package:check_point_v2/features/admin/data/repos/admin_employee_repo.dart';

class AssigneeMultiSelectWidget extends StatefulWidget {
  const AssigneeMultiSelectWidget({
    required this.selectedIds,
    required this.onChanged,
    this.fallbackOptions = const [],
    super.key,
  });

  final List<String> selectedIds;
  final ValueChanged<List<String>> onChanged;
  final List<String> fallbackOptions;

  @override
  State<AssigneeMultiSelectWidget> createState() =>
      _AssigneeMultiSelectWidgetState();
}

class _AssigneeMultiSelectWidgetState extends State<AssigneeMultiSelectWidget> {
  List<EmployeeModel> _employees = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchEmployees();
  }

  Future<void> _fetchEmployees() async {
    setState(() => _isLoading = true);
    try {
      final repo = sl<AdminEmployeeRepo>();
      final result = await repo.getEmployees(page: 0, pageSize: 100);
      result.when(
        success: (list) {
          if (mounted) {
            setState(() {
              _employees = list;
              _isLoading = false;
            });
          }
        },
        failure: (_) {
          if (mounted) {
            setState(() => _isLoading = false);
          }
        },
      );
    } catch (_) {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  String _getDisplayName(String id) {
    final found = _employees.firstWhere(
      (e) => e.id == id || e.name == id || e.userName == id,
      orElse: () => EmployeeModel(id: id, name: id),
    );
    return found.name?.isNotEmpty == true
        ? found.name!
        : (found.userName?.isNotEmpty == true ? found.userName! : id);
  }

  void _openSelectionSheet() {
    final currentSelected = Set<String>.from(widget.selectedIds);
    final searchController = TextEditingController();

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.transparent,
      builder: (ctx) {
        final keyboardHeight = MediaQuery.of(ctx).viewInsets.bottom;
        return Padding(
          padding: EdgeInsets.only(bottom: keyboardHeight),
          child: Container(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(ctx).size.height * 0.75,
            ),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
            ),
            padding: EdgeInsets.all(20.r),
            child: SafeArea(
              child: StatefulBuilder(
                builder: (sheetContext, setSheetState) {
                  final query = searchController.text.trim().toLowerCase();

                  // Build item list combining fetched employees and fallback string options
                  final allItems = <Map<String, String>>[];
                  final addedKeys = <String>{};

                  for (final emp in _employees) {
                    final key = emp.id ?? emp.name ?? '';
                    if (key.isNotEmpty && !addedKeys.contains(key)) {
                      addedKeys.add(key);
                      allItems.add({
                        'key': key,
                        'label': emp.name ?? emp.userName ?? key,
                        'sub': emp.position ?? emp.departmentName ?? '',
                      });
                    }
                  }

                  for (final fallback in widget.fallbackOptions) {
                    if (fallback.isNotEmpty && !addedKeys.contains(fallback)) {
                      addedKeys.add(fallback);
                      allItems.add({
                        'key': fallback,
                        'label': fallback,
                        'sub': '',
                      });
                    }
                  }

                  for (final selected in widget.selectedIds) {
                    if (selected.isNotEmpty && !addedKeys.contains(selected)) {
                      addedKeys.add(selected);
                      allItems.add({
                        'key': selected,
                        'label': selected,
                        'sub': '',
                      });
                    }
                  }

                  final filtered = allItems.where((item) {
                    if (query.isEmpty) return true;
                    return item['label']!.toLowerCase().contains(query) ||
                        item['key']!.toLowerCase().contains(query) ||
                        item['sub']!.toLowerCase().contains(query);
                  }).toList();

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              'projects.selectAssignees'.tr(context: context),
                              style: AppTextStyles.font18Bold,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.close_rounded),
                            onPressed: () => Navigator.pop(sheetContext),
                          ),
                        ],
                      ),
                      SizedBox(height: 8.h),
                      CustomTextFormField(
                        hintText: 'common.search'.tr(context: context),
                        controller: searchController,
                        prefixIcon: const Icon(Icons.search_rounded),
                        onChanged: (_) => setSheetState(() {}),
                      ),
                      SizedBox(height: 12.h),
                      Expanded(
                        child: _isLoading
                            ? Skeletonizer(
                                enabled: true,
                                child: ListView.builder(
                                  itemCount: 5,
                                  itemBuilder: (context, index) =>
                                      CheckboxListTile(
                                        value: false,
                                        onChanged: (_) {},
                                        title: Text(
                                          'Loading Employee Name $index',
                                        ),
                                        subtitle: const Text(
                                          'Loading Department',
                                        ),
                                      ),
                                ),
                              )
                            : filtered.isEmpty
                            ? Center(
                                child: Text(
                                  'projects.noAssignees'.tr(context: context),
                                  style: AppTextStyles.font14Regular,
                                ),
                              )
                            : ListView.builder(
                                itemCount: filtered.length,
                                itemBuilder: (context, index) {
                                  final item = filtered[index];
                                  final itemKey = item['key']!;
                                  final isChecked = currentSelected.contains(
                                    itemKey,
                                  );
                                  return CheckboxListTile(
                                    value: isChecked,
                                    activeColor: AppColors.brandPrimary,
                                    title: Text(
                                      item['label']!,
                                      style: AppTextStyles.font14Bold,
                                    ),
                                    subtitle: item['sub']!.isNotEmpty
                                        ? Text(
                                            item['sub']!,
                                            style: AppTextStyles.font12Regular
                                                .copyWith(
                                                  color:
                                                      AppColors.textSecondary,
                                                ),
                                          )
                                        : null,
                                    onChanged: (val) {
                                      setSheetState(() {
                                        if (val == true) {
                                          currentSelected.add(itemKey);
                                        } else {
                                          currentSelected.remove(itemKey);
                                        }
                                      });
                                    },
                                  );
                                },
                              ),
                      ),
                      SizedBox(height: 12.h),
                      SizedBox(
                        width: double.infinity,
                        child: CustomButton(
                          text: 'common.save'.tr(context: context),
                          icon: Icons.check_rounded,
                          onTap: () {
                            widget.onChanged(currentSelected.toList());
                            Navigator.pop(sheetContext);
                          },
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                'projects.assignees'.tr(context: context),
                style: AppTextStyles.font14Bold,
              ),
            ),
            TextButton.icon(
              onPressed: _openSelectionSheet,
              icon: const Icon(Icons.add_rounded, size: 16),
              label: Text(
                'common.select'.tr(context: context),
                style: AppTextStyles.font12Bold.copyWith(
                  color: AppColors.brandPrimary,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 4.h),
        InkWell(
          onTap: _openSelectionSheet,
          borderRadius: BorderRadius.circular(12.r),
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
            decoration: BoxDecoration(
              color: AppColors.pageBackground,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: AppColors.border),
            ),
            child: widget.selectedIds.isEmpty
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'projects.selectAssignees'.tr(context: context),
                        style: AppTextStyles.font13Regular.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const Icon(
                        Icons.arrow_drop_down_rounded,
                        color: AppColors.textSecondary,
                      ),
                    ],
                  )
                : Wrap(
                    spacing: 6.w,
                    runSpacing: 6.h,
                    children: widget.selectedIds.map((id) {
                      final name = _getDisplayName(id);
                      return Chip(
                        backgroundColor: AppColors.softBrandBackground,
                        deleteIconColor: AppColors.brandPrimary,
                        avatar: CircleAvatar(
                          backgroundColor: AppColors.brandPrimary,
                          child: Text(
                            name.isNotEmpty ? name[0].toUpperCase() : '?',
                            style: AppTextStyles.font12Bold.copyWith(
                              color: AppColors.white,
                            ),
                          ),
                        ),
                        label: Text(
                          name,
                          style: AppTextStyles.font12Medium.copyWith(
                            color: AppColors.brandPrimary,
                          ),
                        ),
                        onDeleted: () {
                          final updated = List<String>.from(widget.selectedIds)
                            ..remove(id);
                          widget.onChanged(updated);
                        },
                      );
                    }).toList(),
                  ),
          ),
        ),
      ],
    );
  }
}
