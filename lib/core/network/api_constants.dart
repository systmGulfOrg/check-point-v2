class ApiConstants {
  const ApiConstants._();

  static const String login = '/api/Auth/Login';
  static const String tenantVerify = '/api/tenant/verify';
  static const String trialSignup = '/api/v2/public/trial-signups';
  static const String accountRequest = '/api/AccountRequest';
  static const String employees = '/api/Employee';
  static const String deleteEmployee = '/api/Auth/DeleteUser';
  static const String departments = '/api/Department';
  static const String branches = '/api/Branch';
  static const String customers = '/api/Customer';
  static const String shifts = '/api/Shift';
  static const String policies = '/api/Policy';
  static const String leaveRequests = '/api/LeaveRequest';
  static const String leaveTypes = '/api/LeaveType';
  static const String attendance = '/api/Attendance';
  static const String tasks = '/api/Task';
  static const String plans = '/api/Plan';
  static const String notifications = '/api/Notification';
  static const String accountRequests = '/api/AccountRequest';
  static const String employeeCheckIn = '/api/Attendance/in';
  static const String employeeCheckInWithoutPlan =
      '/api/Attendance/inWithoutPlan';
  static const String employeeCheckOut = '/api/Attendance/out';
  static const String employeeCheckOutWithoutPlan =
      '/api/Attendance/outWithoutPlan';
  static const String getEmployeeAttendanceHistory =
      '/api/Attendance/getEmployeeAttendanceHistory';
  static const String employeeChangePassword =
      '/api/Auth/employeeChangePassword';
  static const String trackEmployeeLocation =
      '/api/Attendance/trackEmployeeLocation';
  static const String removeTaskFromEmployee =
      '/api/Task/removeTaskFromEmployee';
  static const String removeAssignCustomerPlan =
      '/api/Plan/removeAssignCustomerPlan';
  static const String planFeedback = '/api/Plan/planFeedback';
  static const String feedBackStatus = '/api/Plan/feedBackStatus';
  static const String customerPlans = '/api/CustomerPlan';

  static const String pointsSummary = '/api/points/summary';
  static const String pointsHistory = '/api/points/history';
  static const String pointsExchange = '/api/points/exchange';
  static const String pointsBadges = '/api/points/badges';
  static const String pointsLeaderboard = '/api/points/leaderboard';
  static const String pointsPreview = '/api/points/preview';
  static const String adminPointsEmployees = '/api/admin/points/employees';

  static const String aiAgentBaseUrl = 'http://159.223.150.240:8000';
  static const String aiAgentChat = '$aiAgentBaseUrl/api/agent/chat';
  static const String aiAgentActionConfirm = '$aiAgentBaseUrl/api/agents/task/confirm';

  static const String aiChat = '/api/v2/ai/chat';
  static const String aiActionConfirm = '/api/v2/ai/action/confirm';
  static const String aiHistory = '/api/v2/ai/history';
}
