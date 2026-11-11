/// Route arguments for the employee record screen.
class EmployeeRecordArgs {
  const EmployeeRecordArgs({this.employeeId = 'me', this.employeeName});

  /// `me` for your own record, otherwise the employee id (team/admin views).
  final String employeeId;
  final String? employeeName;
}
