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
        return AppMultiSelectSheetContentWidget<T>(
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
