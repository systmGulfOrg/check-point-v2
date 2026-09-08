class ApiConstants {
  const ApiConstants._();

  static const String login = '/api/Auth/Login';
  static const String accountRequest = '/api/AccountRequest';
  static const String employees = '/api/Employee';
  static const String deleteEmployee = '/api/Auth/DeleteUser';
  static const String departments = '/api/Department';
  static const String branches = '/api/Branch';
  static const String customers = '/api/Customer';
  static const String shifts = '/api/Shift';
  static const String policies = '/api/Policy';
  static const String leaveRequests = '/api/LeaveRequest';
  static const String attendance = '/api/Attendance';
  static const String tasks = '/api/Task';
  static const String plans = '/api/Plan';
  static const String notifications = '/api/Notification';
  static const String accountRequests = '/api/AccountRequest';
  static const String employeeCheckIn = '/api/Attendance/employeeCheckIn';
  static const String employeeCheckInWithoutPlan = '/api/Attendance/employeeCheckInWithoutPlan';
  static const String employeeCheckOut = '/api/Attendance/employeeCheckOut';
  static const String employeeCheckOutWithoutPlan = '/api/Attendance/employeeCheckOutWithoutPlan';
  static const String getEmployeeAttendanceHistory = '/api/Attendance/getEmployeeAttendanceHistory';
  static const String employeeChangePassword = '/api/Auth/employeeChangePassword';
  static const String trackEmployeeLocation = '/api/Attendance/trackEmployeeLocation';
  static const String removeTaskFromEmployee = '/api/Task/removeTaskFromEmployee';
  static const String removeAssignCustomerPlan = '/api/Plan/removeAssignCustomerPlan';
  static const String planFeedback = '/api/Plan/planFeedback';
  static const String feedBackStatus = '/api/Plan/feedBackStatus';
}
