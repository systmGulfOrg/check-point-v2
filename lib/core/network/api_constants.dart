class ApiConstants {
  const ApiConstants._();

  // Auth & Tenant v2
  static const String login = '/api/v2/auth/login';
  static const String refreshToken = '/api/v2/auth/refresh';
  static const String verifyTenant = '/api/v1/tenant/verify';
  static const String selfRegistration = '/api/v2/employees/account-requests';
  static const String accountRequest = '/api/AccountRequest';
  static const String accountRequests = '/api/AccountRequest';
  static const String accountRequestStatus = '/api/AccountRequest/status';
  static const String deviceTransferRequest = '/api/Auth/DeviceTransferRequest';

  // Workforce & Attendance v2
  static const String attendanceClockIn = '/api/v2/attendance/clock-in';
  static const String attendanceClockOut = '/api/v2/attendance/clock-out';
  static const String trackingBatch = '/api/v2/attendance/tracking/batch';
  static const String attendanceCorrections = '/api/v2/attendance/corrections';

  // SAMCO Workforce & Contractor v2
  static const String samcoSiteBoundary = '/api/v2/workforce/samco/sites/{siteId}/boundary';
  static const String samcoContractorAttendance = '/api/v2/workforce/samco/attendance/contractors';
  static const String samcoWorkerBatchAttendance = '/api/v2/workforce/samco/attendance/workers/batch';
  static const String samcoWorkers = '/api/v2/workforce/samco/workers';
  static const String samcoOfflineSync = '/api/v2/workforce/samco/attendance/sync';

  // Leaves & Permissions v2
  static const String leaves = '/api/v2/leaves';
  static const String shortLeaves = '/api/v2/leaves/short-leaves';

  // Notifications & Storage v2
  static const String registerPushToken = '/api/v2/notifications/register-token';
  static const String notificationsV2 = '/api/v2/notifications';
  static const String readAllNotifications = '/api/v2/notifications/read-all';
  static const String signedUploadUrl = '/api/v2/storage/signed-upload-url';

  // AI Gateway v2
  static const String aiFaceVerify = '/api/v2/ai/face/verify';
  static const String aiGpsRisk = '/api/v2/ai/gps/risk';

  // Legacy / existing endpoints
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
  static const String employeeCheckIn = '/api/Attendance/in';
  static const String employeeCheckInWithoutPlan = '/api/Attendance/inWithoutPlan';
  static const String employeeCheckOut = '/api/Attendance/out';
  static const String employeeCheckOutWithoutPlan = '/api/Attendance/outWithoutPlan';
  static const String getEmployeeAttendanceHistory = '/api/Attendance/getEmployeeAttendanceHistory';
  static const String employeeChangePassword = '/api/Auth/employeeChangePassword';
  static const String trackEmployeeLocation = '/api/Attendance/trackEmployeeLocation';
  static const String removeTaskFromEmployee = '/api/Task/removeTaskFromEmployee';
  static const String removeAssignCustomerPlan = '/api/Plan/removeAssignCustomerPlan';
  static const String planFeedback = '/api/Plan/planFeedback';
  static const String feedBackStatus = '/api/Plan/feedBackStatus';
}

class ApiErrorCodes {
  const ApiErrorCodes._();

  static const String outsideZone = 'OUTSIDE_ZONE';
  static const String accountLocked = 'ACCOUNT_LOCKED';
  static const String oneSitePerDayViolation = 'ONE_SITE_PER_DAY_VIOLATION';
  static const String unauthorized = 'UNAUTHORIZED';
  static const String officialHoliday = 'OFFICIAL_HOLIDAY';
  static const String deviceNotApproved = 'DEVICE_NOT_APPROVED';
  static const String gpsAccuracyTooLow = 'GPS_ACCURACY_TOO_LOW';
  static const String fakeGpsDetected = 'FAKE_GPS_DETECTED';
  static const String faceSpoofDetected = 'FACE_SPOOF_DETECTED';
  static const String faceNotMatched = 'FACE_NOT_MATCHED';
}
