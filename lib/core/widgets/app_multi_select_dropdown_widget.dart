import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';

class AppMultiSelectItem<T> {
  const AppMultiSelectItem({required this.id, required this.label, this.value});

  final String id;
  final String label;
  final T? value;
}

class AppMultiSelectDropdownWidget<T> extends StatelessWidget {
  const AppMultiSelectDropdownWidget({
    required this.label,
    required this.hint,
    required this.items,
    required this.selectedIds,
    required this.onSelectionChanged,
    super.key,
  });

  final String label;
  final String hint;
  final List<AppMultiSelectItem<T>> items;
  final Set<String> selectedIds;
  final ValueChanged<Set<String>> onSelectionChanged;

  String get _selectedText {
    if (selectedIds.isEmpty) return hint;
    final names = items
        .where((item) => selectedIds.contains(item.id))
        .map((item) => item.label)
        .toList();
    if (names.isEmpty) return hint;
    return names.join(', ');
  }

  void _showMultiSelectSheet(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.cardBackground,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (sheetContext) {
        return _MultiSelectSheetContent<T>(
          label: label,
          items: items,
          initialSelectedIds: selectedIds,
          onConfirm: (newSelected) {
            onSelectionChanged(newSelected);
            Navigator.pop(sheetContext);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final hasSelection = selectedIds.isNotEmpty;

    return InkWell(
      onTap: () => _showMultiSelectSheet(context),
      borderRadius: BorderRadius.circular(12.r),
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: Icon(
            Icons.arrow_drop_down,
            color: AppColors.textSecondary,
            size: 24.r,
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: 14.w,
            vertical: 12.h,
          ),
        ),
        child: Text(
          _selectedText,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: AppTextStyles.font14Regular.copyWith(
            color: hasSelection ? AppColors.textPrimary : AppColors.placeholder,
          ),
        ),
      ),
    );
  }
}

class _MultiSelectSheetContent<T> extends StatefulWidget {
  const _MultiSelectSheetContent({
    required this.label,
    required this.items,
    required this.initialSelectedIds,
    required this.onConfirm,
  });

  final String label;
  final List<AppMultiSelectItem<T>> items;
  final Set<String> initialSelectedIds;
  final ValueChanged<Set<String>> onConfirm;

  @override
  State<_MultiSelectSheetContent<T>> createState() =>
      __MultiSelectSheetContentState<T>();
}

class __MultiSelectSheetContentState<T>
    extends State<_MultiSelectSheetContent<T>> {
  late Set<String> tempSelectedIds;
  late final TextEditingController searchController;
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    tempSelectedIds = Set<String>.from(widget.initialSelectedIds);
    searchController = TextEditingController();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  List<AppMultiSelectItem<T>> get filteredItems {
    if (searchQuery.trim().isEmpty) return widget.items;
    final q = searchQuery.trim().toLowerCase();
    return widget.items
        .where((item) => item.label.toLowerCase().contains(q))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.75,
        ),
        padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 16.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(widget.label, style: AppTextStyles.font18Bold),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(Icons.close_rounded, size: 20.r),
                ),
              ],
            ),
            const Divider(color: AppColors.border),
            hSpace(10),
            TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Search...',
                prefixIcon: Icon(Icons.search, size: 20.r),
              ),
              onChanged: (val) => setState(() => searchQuery = val),
            ),
            hSpace(12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      tempSelectedIds = widget.items.map((i) => i.id).toSet();
                    });
                  },
                  child: Text(
                    'Select All',
                    style: AppTextStyles.font12Medium.copyWith(
                      color: AppColors.brandPrimary,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      tempSelectedIds.clear();
                    });
                  },
                  child: Text(
                    'Clear All',
                    style: AppTextStyles.font12Medium.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
              ],
            ),
            hSpace(6),
            Expanded(
              child: filteredItems.isEmpty
                  ? Center(
                      child: Text(
                        'No employees found',
                        style: AppTextStyles.font13Regular.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    )
                  : ListView.builder(
                      itemCount: filteredItems.length,
                      itemBuilder: (context, index) {
                        final item = filteredItems[index];
                        final isSelected = tempSelectedIds.contains(item.id);
                        return CheckboxListTile(
                          value: isSelected,
                          title: Text(
                            item.label,
                            style: AppTextStyles.font14Medium,
                          ),
                          activeColor: AppColors.brandPrimary,
                          controlAffinity: ListTileControlAffinity.leading,
                          contentPadding: EdgeInsets.zero,
                          onChanged: (checked) {
                            setState(() {
                              if (checked == true) {
                                tempSelectedIds.add(item.id);
                              } else {
                                tempSelectedIds.remove(item.id);
                              }
                            });
                          },
                        );
                      },
                    ),
            ),
            hSpace(16),
            CustomButton(
              text: 'Done (${tempSelectedIds.length})',
              onTap: () => widget.onConfirm(tempSelectedIds),
            ),
          ],
        ),
      ),
    );
  }
}
