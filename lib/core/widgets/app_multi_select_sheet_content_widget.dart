import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';

class AppMultiSelectSheetContentWidget<T> extends StatefulWidget {
  const AppMultiSelectSheetContentWidget({
    required this.label,
    required this.items,
    required this.initialSelectedIds,
    required this.onConfirm,
    super.key,
  });

  final String label;
  final List<AppMultiSelectItem<T>> items;
  final Set<String> initialSelectedIds;
  final ValueChanged<Set<String>> onConfirm;

  @override
  State<AppMultiSelectSheetContentWidget<T>> createState() =>
      _AppMultiSelectSheetContentWidgetState<T>();
}

class _AppMultiSelectSheetContentWidgetState<T>
    extends State<AppMultiSelectSheetContentWidget<T>> {
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
