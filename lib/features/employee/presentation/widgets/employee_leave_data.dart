class EmployeeLeaveData {
  const EmployeeLeaveData({
    required this.id,
    required this.leaveType,
    required this.status,
    required this.dateRange,
    this.reason,
    required this.appliedDate,
  });

  final String id;
  final String leaveType;
  final String status;
  final String dateRange;
  final String? reason;
  final String appliedDate;
}
