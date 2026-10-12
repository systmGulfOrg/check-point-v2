import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:check_point_v2/features/admin/data/models/locations/branch_response_model.dart';
import 'package:check_point_v2/features/admin/data/models/locations/customer_response_model.dart';

class EmployeeAttendanceTargetDropdownWidget extends StatelessWidget {
  const EmployeeAttendanceTargetDropdownWidget({
    required this.type,
    required this.branches,
    required this.customers,
    required this.selectedBranch,
    required this.selectedCustomer,
    required this.onBranchChanged,
    required this.onCustomerChanged,
    super.key,
  });

  final String type;
  final List<BranchModel> branches;
  final List<CustomerModel> customers;
  final BranchModel? selectedBranch;
  final CustomerModel? selectedCustomer;
  final ValueChanged<BranchModel> onBranchChanged;
  final ValueChanged<CustomerModel> onCustomerChanged;

  @override
  Widget build(BuildContext context) {
    final isBranch = type == 'Branch' || type == 'Site';
    final branchId = selectedBranch?.id?.toString();
    final customerId = selectedCustomer?.id;
    final hasBranch = branchId != null &&
        branches.any((item) => item.id?.toString() == branchId);
    final hasCustomer = customerId != null &&
        customers.any((item) => item.id == customerId);
    final currentValue =
        isBranch ? (hasBranch ? branchId : null) : (hasCustomer ? customerId : null);

    return DropdownButtonFormField<String>(
      key: ValueKey('emp_loc_${currentValue ?? 'none'}'),
      initialValue: currentValue,
      decoration: InputDecoration(labelText: 'attendance.location'.tr()),
      items: isBranch
          ? branches
                .where((item) => item.id != null)
                .map(
                  (item) => DropdownMenuItem(
                    value: item.id.toString(),
                    child: Text(item.name ?? 'Branch'),
                  ),
                )
                .toList()
          : customers
                .where((item) => item.id != null)
                .map(
                  (item) => DropdownMenuItem(
                    value: item.id,
                    child: Text(item.name ?? type),
                  ),
                )
                .toList(),
      onChanged: (value) {
        if (value == null) return;
        if (isBranch) {
          final selected = branches.firstWhere(
            (item) => item.id.toString() == value,
          );
          onBranchChanged(selected);
        } else {
          final selected = customers.firstWhere((item) => item.id == value);
          onCustomerChanged(selected);
        }
      },
    );
  }
}
