import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import 'admin_shift_card_widget.dart';
import 'admin_shift_data.dart';

class AdminShiftsListWidget extends StatelessWidget {
  const AdminShiftsListWidget({required this.onShiftTap, super.key});

  final ValueChanged<String> onShiftTap;

  static const _shifts = <AdminShiftData>[
    AdminShiftData(
      nameKey: 'admin.shifts.items.morning.name',
      descriptionKey: 'admin.shifts.items.morning.description',
      policiesCount: 2,
    ),
    AdminShiftData(
      nameKey: 'admin.shifts.items.standard.name',
      descriptionKey: 'admin.shifts.items.standard.description',
      policiesCount: 1,
    ),
    AdminShiftData(
      nameKey: 'admin.shifts.items.afternoon.name',
      descriptionKey: 'admin.shifts.items.afternoon.description',
      policiesCount: 1,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _shifts.length,
      separatorBuilder: (_, _) => hSpace(10),
      itemBuilder: (_, index) => AdminShiftCardWidget(
        shift: _shifts[index],
        onTap: () => onShiftTap(_shifts[index].nameKey),
      ),
    );
  }
}
