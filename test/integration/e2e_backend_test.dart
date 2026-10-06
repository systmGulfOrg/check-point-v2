import 'dart:convert';
import 'package:http/http.dart' as http;

const baseUrl = 'http://127.0.0.1:4100';

class TestResult {
  final String category;
  final String name;
  final bool passed;
  final int statusCode;
  final String details;
  final dynamic requestBody;
  final dynamic responseBody;

  TestResult({
    required this.category,
    required this.name,
    required this.passed,
    required this.statusCode,
    required this.details,
    this.requestBody,
    this.responseBody,
  });
}

final List<TestResult> results = [];

Future<void> main() async {
  // 1. AUTH TESTS
  await testAuth();

  // If login succeeds, get token and user info
  final loginRes = await http.post(
    Uri.parse('$baseUrl/api/Auth/Login'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({
      'userName': 'osama.mahmoud',
      'password': 'Osama123!',
      'mobileId': 'test-integration-device-01',
    }),
  );

  if (loginRes.statusCode != 200) {
    return;
  }

  final loginJson = jsonDecode(loginRes.body);
  final token = loginJson['value']['token'] as String;
  final employeeId = loginJson['value']['employeeId'] as String;
  final userId = loginJson['value']['id'] as String;
  final headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token',
  };

  // 2. EMPLOYEE DOMAIN TESTS
  await testEmployeeDomain(headers, employeeId, userId);

  // 3. SUPERVISOR DOMAIN TESTS
  await testSupervisorDomain(headers, employeeId);

  // 4. ADMIN DOMAIN TESTS
  await testAdminDomain(headers, employeeId, userId);

  // 5. PROJECTS V2 TESTS
  await testProjectsV2(headers);

  // 6. NOTIFICATIONS TESTS
  await testNotifications(headers);

  // 7. REMOTE WORK TESTS
  await testRemoteWork(headers, employeeId);

  // ignore: avoid_print
  print('\n==================== TEST RESULTS ====================');
  int passedCount = 0;
  int failedCount = 0;
  for (final r in results) {
    final status = r.passed ? '✅ PASS' : '❌ FAIL';
    if (r.passed) {
      passedCount++;
    } else {
      failedCount++;
    }
    // ignore: avoid_print
    print('$status [${r.category}] ${r.name} (${r.statusCode}) -> ${r.details}');
  }
  // ignore: avoid_print
  print('======================================================');
  // ignore: avoid_print
  print('Total: ${results.length} | Passed: $passedCount | Failed: $failedCount');
}

Future<void> testAuth() async {
  // Test invalid login: osama.ma
  try {
    final res = await http.post(
      Uri.parse('$baseUrl/api/Auth/Login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'userName': 'osama.ma',
        'password': 'Osama123!',
        'mobileId': 'test-device',
      }),
    );
    results.add(TestResult(
      category: 'Auth',
      name: 'Login with employee username "osama.ma"',
      passed: res.statusCode == 200,
      statusCode: res.statusCode,
      details: res.statusCode == 200 ? 'Success' : 'User osama.ma returned ${res.statusCode}: ${res.body}',
      responseBody: res.body,
    ));
  } catch (e) {
    results.add(TestResult(
      category: 'Auth',
      name: 'Login with osama.ma',
      passed: false,
      statusCode: 0,
      details: e.toString(),
    ));
  }

  // Test valid login: osama.mahmoud
  try {
    final res = await http.post(
      Uri.parse('$baseUrl/api/Auth/Login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'userName': 'osama.mahmoud',
        'password': 'Osama123!',
        'mobileId': 'test-device',
      }),
    );
    results.add(TestResult(
      category: 'Auth',
      name: 'Login with "osama.mahmoud"',
      passed: res.statusCode == 200,
      statusCode: res.statusCode,
      details: res.statusCode == 200 ? 'Success' : 'Failed: ${res.body}',
      responseBody: res.body,
    ));
  } catch (e) {
    results.add(TestResult(
      category: 'Auth',
      name: 'Login with osama.mahmoud',
      passed: false,
      statusCode: 0,
      details: e.toString(),
    ));
  }

  // Test Device Transfer Request
  try {
    final res = await http.post(
      Uri.parse('$baseUrl/api/Auth/DeviceTransferRequest'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'userName': 'osama.mahmoud',
        'password': 'Osama123!',
        'mobileId': 'new-device-id-999',
      }),
    );
    results.add(TestResult(
      category: 'Auth',
      name: 'Device Transfer Request',
      passed: res.statusCode >= 200 && res.statusCode < 300,
      statusCode: res.statusCode,
      details: 'Status: ${res.statusCode} Body: ${res.body}',
      responseBody: res.body,
    ));
  } catch (e) {
    results.add(TestResult(
      category: 'Auth',
      name: 'Device Transfer Request',
      passed: false,
      statusCode: 0,
      details: e.toString(),
    ));
  }

  // Test Account Request Status
  try {
    final res = await http.get(
      Uri.parse('$baseUrl/api/AccountRequest/status?mobileId=test-device'),
    );
    results.add(TestResult(
      category: 'Auth',
      name: 'Account Request Status by mobileId',
      passed: res.statusCode >= 200 && res.statusCode < 300,
      statusCode: res.statusCode,
      details: 'Status: ${res.statusCode} Body: ${res.body}',
      responseBody: res.body,
    ));
  } catch (e) {
    results.add(TestResult(
      category: 'Auth',
      name: 'Account Request Status',
      passed: false,
      statusCode: 0,
      details: e.toString(),
    ));
  }
}

Future<void> testEmployeeDomain(Map<String, String> headers, String employeeId, String userId) async {
  // 1. Get Employee Profile
  await runGetTest('Employee', 'Get Employee by ID (/api/Employee/$employeeId)', '/api/Employee/$employeeId', headers);

  // 2. Attendance History
  await runGetTest('Employee', 'Get Attendance History for employee', '/api/Attendance/employeeId/$employeeId?itemCount=10&index=0', headers);

  // 3. Branches
  await runGetTest('Employee', 'Get Branches (/api/Branch)', '/api/Branch', headers);

  // 4. Customers by Type
  await runGetTest('Employee', 'Get Customers by Type (/api/Customer/customerType/all)', '/api/Customer/customerType/all', headers);

  // 5. Employee Plans
  await runGetTest('Employee', 'Get Customer Plans for Employee (/api/Plan/employee/$employeeId)', '/api/Plan/employee/$employeeId', headers);

  // 6. Feedback Statuses
  await runGetTest('Employee', 'Get Feedback Statuses (/api/Plan/feedBackStatus)', '/api/Plan/feedBackStatus', headers);

  // 7. Employee Tasks
  await runGetTest('Employee', 'Get Employee Tasks (/api/Task/specificEmployee?employeeId=$employeeId)', '/api/Task/specificEmployee?employeeId=$employeeId', headers);

  // 8. Leave Types
  await runGetTest('Employee', 'Get Leave Types (/api/LeaveType)', '/api/LeaveType', headers);

  // 9. Leave Requests for Employee
  await runGetTest('Employee', 'Get Leave Requests for Employee (/api/LeaveRequest/employeeId/$employeeId)', '/api/LeaveRequest/employeeId/$employeeId', headers);

  // 10. Leave Balances V1
  await runGetTest('Employee', 'Get Leave Balances (/api/v1/leaves/balances)', '/api/v1/leaves/balances', headers);

  // 11. Official Holidays V1
  await runGetTest('Employee', 'Get Official Holidays (/api/v1/leaves/holidays)', '/api/v1/leaves/holidays', headers);

  // 12. Short Leaves / Permissions V1
  await runGetTest('Employee', 'Get Short Leaves Requests (/api/v1/leaves/permissions/requests)', '/api/v1/leaves/permissions/requests', headers);

  // 13. Task Time Logs V2
  await runGetTest('Employee', 'Get Productive Hours (/api/v2/tasks/productive-hours?from=2026-01-01&to=2026-12-31)', '/api/v2/tasks/productive-hours?from=2026-01-01&to=2026-12-31', headers);

  // 14. Track Employee Location
  try {
    final res = await http.post(
      Uri.parse('$baseUrl/api/Attendance/trackEmployeeLocation'),
      headers: headers,
      body: jsonEncode({
        'employeeId': employeeId,
        'latitude': 30.0444,
        'longitude': 31.2357,
        'date': DateTime.now().toIso8601String(),
      }),
    );
    results.add(TestResult(
      category: 'Employee',
      name: 'Track Employee Location (/api/Attendance/trackEmployeeLocation)',
      passed: res.statusCode >= 200 && res.statusCode < 300,
      statusCode: res.statusCode,
      details: 'Status: ${res.statusCode} Body: ${res.body}',
    ));
  } catch (e) {
    results.add(TestResult(category: 'Employee', name: 'Track Location', passed: false, statusCode: 0, details: e.toString()));
  }

  // 15. Test Check In Without Plan
  try {
    final res = await http.post(
      Uri.parse('$baseUrl/api/Attendance/inWithoutPlan'),
      headers: headers,
      body: jsonEncode({
        'employeeId': employeeId,
        'latitude': 30.0444,
        'longitude': 31.2357,
        'area': 'Office',
        'attendanceDate': DateTime.now().toIso8601String(),
        'clockInTime': DateTime.now().toIso8601String(),
      }),
    );
    // 200 = Success, 403 = Official Holiday Protection (Armed Forces Day)
    final isPassed = (res.statusCode >= 200 && res.statusCode < 300) ||
        (res.statusCode == 403 && res.body.contains('إجازة'));
    results.add(TestResult(
      category: 'Employee',
      name: 'Check In Without Plan (/api/Attendance/inWithoutPlan)',
      passed: isPassed,
      statusCode: res.statusCode,
      details: isPassed
          ? (res.statusCode == 200 ? 'Clock in recorded' : 'Holiday policy enforced correctly (403)')
          : 'Failed (${res.statusCode}): ${res.body}',
    ));
  } catch (e) {
    results.add(TestResult(category: 'Employee', name: 'Check In Without Plan', passed: false, statusCode: 0, details: e.toString()));
  }

  // 16. Test Check Out Without Plan
  try {
    final res = await http.post(
      Uri.parse('$baseUrl/api/Attendance/outWithoutPlan'),
      headers: headers,
      body: jsonEncode({
        'employeeId': employeeId,
        'latitude': 30.0444,
        'longitude': 31.2357,
        'area': 'Office',
        'attendanceDate': DateTime.now().toIso8601String(),
        'clockOutTime': DateTime.now().toIso8601String(),
      }),
    );
    // 200 = Success, 404 = Expected when check-in was blocked by holiday
    final isPassed = (res.statusCode >= 200 && res.statusCode < 300) ||
        (res.statusCode == 404 && res.body.contains('clock-in')) ||
        (res.statusCode == 403 && res.body.contains('إجازة'));
    results.add(TestResult(
      category: 'Employee',
      name: 'Check Out Without Plan (/api/Attendance/outWithoutPlan)',
      passed: isPassed,
      statusCode: res.statusCode,
      details: isPassed
          ? (res.statusCode == 200 ? 'Clock out recorded' : 'Consistent state response (${res.statusCode})')
          : 'Failed (${res.statusCode}): ${res.body}',
    ));
  } catch (e) {
    results.add(TestResult(category: 'Employee', name: 'Check Out Without Plan', passed: false, statusCode: 0, details: e.toString()));
  }
}

Future<void> testSupervisorDomain(Map<String, String> headers, String employeeId) async {
  // 1. Attendance overview
  await runGetTest('Supervisor', 'Get Attendance Overview (/api/Attendance)', '/api/Attendance?itemCount=50&index=0', headers);

  // 2. Attendance by Department
  await runGetTest('Supervisor', 'Get Department Attendance (/api/Attendance/departmentId/6)', '/api/Attendance/departmentId/6', headers);

  // 3. Late Comers
  await runGetTest('Supervisor', 'Get Late Comers (/api/Attendance/lateComers/Tuesday)', '/api/Attendance/lateComers/Tuesday', headers);

  // 4. Early Leavers
  await runGetTest('Supervisor', 'Get Early Leavers (/api/Attendance/earlyLeavers/Tuesday)', '/api/Attendance/earlyLeavers/Tuesday', headers);

  // 5. Leave Requests for Department
  await runGetTest('Supervisor', 'Get Department Leave Requests (/api/LeaveRequest/departmentId/6)', '/api/LeaveRequest/departmentId/6', headers);

  // 6. Supervisor Tasks
  await runGetTest('Supervisor', 'Get Tasks by Department (/api/Task/department/6)', '/api/Task/department/6', headers);

  // 7. Supervisor Plans
  await runGetTest('Supervisor', 'Get Plans by Department (/api/Plan/department/6)', '/api/Plan/department/6', headers);

  // 8. Team Employees
  await runGetTest('Supervisor', 'Get Department Employees (/api/Employee/departmentId/6)', '/api/Employee/departmentId/6', headers);
}

Future<void> testAdminDomain(Map<String, String> headers, String employeeId, String userId) async {
  // 1. Audit Logs V2
  await runGetTest('Admin', 'Get Audit Logs (/api/v2/audit)', '/api/v2/audit?entityId=$userId', headers);

  // 2. Pending Devices V2
  await runGetTest('Admin', 'Get Pending Devices (/api/v2/devices/pending)', '/api/v2/devices/pending', headers);

  // 3. Employee Devices V2
  await runGetTest('Admin', 'Get Employee Devices (/api/v2/employees/$employeeId/devices)', '/api/v2/employees/$employeeId/devices', headers);

  // 4. All Employees
  await runGetTest('Admin', 'Get Employees (/api/Employee)', '/api/Employee?itemCount=20&index=0', headers);

  // 5. Deleted Employees
  await runGetTest('Admin', 'Get Deleted Employees (/api/Employee/deleted)', '/api/Employee/deleted', headers);

  // 6. Permissions Catalogue V2
  await runGetTest('Admin', 'Get Permissions Catalogue (/api/v2/permissions/catalogue)', '/api/v2/permissions/catalogue', headers);

  // 7. User Permissions V2
  await runGetTest('Admin', 'Get User Permissions (/api/v2/users/$userId/permissions)', '/api/v2/users/$userId/permissions', headers);

  // 8. Account Requests
  await runGetTest('Admin', 'Get Account Requests (/api/AccountRequest)', '/api/AccountRequest?itemCount=20&index=0', headers);

  // 9. Departments
  await runGetTest('Admin', 'Get Departments (/api/Department)', '/api/Department?itemCount=50&index=0', headers);

  // 10. Shifts
  await runGetTest('Admin', 'Get Shifts (/api/Shift)', '/api/Shift', headers);

  // 11. Policies
  await runGetTest('Admin', 'Get Policies by Shift (/api/Policy/shift/1)', '/api/Policy/shift/1', headers);

  // 12. All Leave Requests
  await runGetTest('Admin', 'Get All Leave Requests (/api/LeaveRequest)', '/api/LeaveRequest', headers);

  // 13. All Tasks
  await runGetTest('Admin', 'Get Tasks (/api/Task)', '/api/Task?itemCount=50&index=0', headers);

  // 14. All Plans
  await runGetTest('Admin', 'Get Plans (/api/Plan)', '/api/Plan', headers);
}

Future<void> testProjectsV2(Map<String, String> headers) async {
  // 1. Get Projects
  await runGetTest('Projects', 'Get Projects (/api/v2/projects)', '/api/v2/projects', headers);

  // Test Project Lifecycle
  try {
    // Create Project
    final createRes = await http.post(
      Uri.parse('$baseUrl/api/v2/projects'),
      headers: headers,
      body: jsonEncode({
        'name': 'Integration Test Project ${DateTime.now().millisecondsSinceEpoch}',
        'description': 'Automated Integration Test Project',
        'color': '#3B82F6',
      }),
    );
    final createPassed = createRes.statusCode >= 200 && createRes.statusCode < 300;
    results.add(TestResult(
      category: 'Projects',
      name: 'Create Project (/api/v2/projects)',
      passed: createPassed,
      statusCode: createRes.statusCode,
      details: 'Status: ${createRes.statusCode} Body: ${createRes.body}',
    ));

    if (createPassed) {
      final createJson = jsonDecode(createRes.body);
      final projectId = (createJson['id'] ?? createJson['value']?['id'])?.toString();
      if (projectId != null) {
        // Get Tasks for Project
        await runGetTest('Projects', 'Get Project Tasks (/api/v2/projects/$projectId/tasks)', '/api/v2/projects/$projectId/tasks', headers);

        // Delete Test Project
        final delRes = await http.delete(
          Uri.parse('$baseUrl/api/v2/projects/$projectId'),
          headers: headers,
        );
        results.add(TestResult(
          category: 'Projects',
          name: 'Delete Project (/api/v2/projects/$projectId)',
          passed: delRes.statusCode >= 200 && delRes.statusCode < 300,
          statusCode: delRes.statusCode,
          details: 'Status: ${delRes.statusCode}',
        ));
      }
    }
  } catch (e) {
    results.add(TestResult(category: 'Projects', name: 'Project Lifecycle', passed: false, statusCode: 0, details: e.toString()));
  }
}

Future<void> testNotifications(Map<String, String> headers) async {
  // 1. Get Notifications
  await runGetTest('Notifications', 'Get Notifications (/api/v2/notifications)', '/api/v2/notifications?unreadOnly=false&itemCount=50&index=0', headers);

  // 2. Mark All Read
  try {
    final res = await http.post(
      Uri.parse('$baseUrl/api/v2/notifications/read-all'),
      headers: headers,
    );
    results.add(TestResult(
      category: 'Notifications',
      name: 'Mark All Notifications Read (/api/v2/notifications/read-all)',
      passed: res.statusCode >= 200 && res.statusCode < 300,
      statusCode: res.statusCode,
      details: 'Status: ${res.statusCode} Body: ${res.body}',
    ));
  } catch (e) {
    results.add(TestResult(category: 'Notifications', name: 'Mark All Read', passed: false, statusCode: 0, details: e.toString()));
  }
}

Future<void> testRemoteWork(Map<String, String> headers, String employeeId) async {
  // 1. Get Remote Policies
  await runGetTest('RemoteWork', 'Get Remote Policies (/api/v2/remote-policies)', '/api/v2/remote-policies', headers);

  // 2. Get Remote Requests
  await runGetTest('RemoteWork', 'Get Remote Requests (/api/v2/remote-requests)', '/api/v2/remote-requests?itemCount=100', headers);
}

Future<void> runGetTest(String category, String name, String endpoint, Map<String, String> headers) async {
  try {
    final res = await http.get(Uri.parse('$baseUrl$endpoint'), headers: headers);
    final isSuccess = res.statusCode >= 200 && res.statusCode < 300;
    results.add(TestResult(
      category: category,
      name: name,
      passed: isSuccess,
      statusCode: res.statusCode,
      details: isSuccess ? 'OK (${res.body.length} bytes)' : 'Failed (${res.statusCode}): ${res.body}',
      responseBody: res.body,
    ));
  } catch (e) {
    results.add(TestResult(
      category: category,
      name: name,
      passed: false,
      statusCode: 0,
      details: 'Network Exception: $e',
    ));
  }
}
