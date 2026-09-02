import 'package:flutter/material.dart';

import '../../../supervisor/presentation/widgets/supervisor_tasks_filter_widget.dart';

class AdminTasksFilterWidget extends StatelessWidget {
  const AdminTasksFilterWidget({
    required this.selectedIndex,
    required this.onSelected,
    super.key,
  });

  final int selectedIndex;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    return SupervisorTasksFilterWidget(
      selectedIndex: selectedIndex,
      onFilterSelected: onSelected,
    );
  }
}
