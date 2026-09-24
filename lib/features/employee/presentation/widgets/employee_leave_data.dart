class EmployeeLeaveData {
  const EmployeeLeaveData({
    required this.id,
    required this.leaveType,
    required this.status,
    required this.dateRange,
    this.reason,
    required this.appliedDate,
    this.managerName,
    this.managerActionAt,
    this.managerRejectionReason,
    this.hrName,
    this.hrActionAt,
    this.hrRejectionReason,
  });

  final String id;
  final String leaveType;
  final String status;
  final String dateRange;
  final String? reason;
  final String appliedDate;
  final String? managerName;
  final String? managerActionAt;
  final String? managerRejectionReason;
  final String? hrName;
  final String? hrActionAt;
  final String? hrRejectionReason;
}
