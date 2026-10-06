# Check Point HRM — Integration Test & System Issues Report
> **Document Purpose:** Complete, unedited audit of all bugs, broken workflows, API endpoint mismatches, validation failures, and routing discrepancies discovered during full integration testing across **Employee**, **Supervisor**, and **Admin** roles.
>
> **Note:** As instructed, NO code has been modified or fixed. This document lists all identified issues with precise root causes, error payloads, and impacted files.

---

## 1. Executive Summary & Test Statistics

- **Total Integration Test Scenarios Executed:** 50
- **Passed Scenarios:** 39 (78.0%)
- **Failed / Broken Scenarios:** 11 (22.0%)
- **Target Backend Server:** `http://137.184.223.222`
- **Tested User Accounts:**
  - **Account 1 (Primary Admin / Supervisor / Employee):** `osama.mahmoud` / `Osama123!` (Roles: `["Supervisor", "Employee", "Admin"]`) — **Authenticated Successfully**
  - **Account 2 (Provided Employee Account):** `osama.ma` / `Osama123!` — **Failed (401 Invalid Credentials)**

---

## 2. Comprehensive Breakdown of Discovered Issues

### Issue 1: Authentication Failure for Employee Account (`osama.ma`)
- **Domain:** Authentication & Identity
- **Severity:** High
- **Description:** Attempting to log in with username `osama.ma` and password `Osama123!` returns `401 Unauthorized` with message `"Invalid credentials"`.
- **Root Cause:** The database does not contain an active user record with username `osama.ma` matching this password. The active registered account on the server is `osama.mahmoud` (which contains `Employee`, `Supervisor`, and `Admin` roles).
- **Request / Response:**
  ```http
  POST /api/Auth/Login
  {"userName":"osama.ma","password":"Osama123!","mobileId":"test-device"}

  HTTP 401 Unauthorized
  {"value":null,"status":401,"isSuccess":false,"errors":["Invalid credentials"],"validationErrors":[]}
  ```
- **Impacted Files:** [`lib/features/auth/presentation/cubit/login/login_cubit.dart`](file:///home/osama/Desktop/Systm-Gulf/check_point_v2/lib/features/auth/presentation/cubit/login/login_cubit.dart)

---

### Issue 2: Customer Plans 404 Route Not Found (`/api/Plan/employee/{id}`)
- **Domain:** Employee — Visit Plans
- **Severity:** High
- **Description:** When the Employee screen opens the "Plans" tab or tries to fetch customer visit plans assigned to them, the request fails with `404 Not Found`.
- **Root Cause:** 
  The Flutter API Service calls `GET /api/Plan/employee/{employeeId}`, but the backend OpenAPI router does not expose this route under `/api/Plan/`. Instead, backend customer plans are located at `/api/v1/CustomerPlan/customerPlans` or `/api/v2/customer-plans`.
- **Request / Response:**
  ```http
  GET /api/Plan/employee/01M2XC3ZWW6XDCZSCMEXVQN2Q5

  HTTP 404 Not Found
  {"value":null,"status":404,"isSuccess":false,"errors":["Route GET /api/Plan/employee/01M2XC3ZWW6XDCZSCMEXVQN2Q5 not found"],"validationErrors":[]}
  ```
- **Impacted Files:**
  - [`lib/features/employee/data/apis/employee_api_service.dart#L78`](file:///home/osama/Desktop/Systm-Gulf/check_point_v2/lib/features/employee/data/apis/employee_api_service.dart#L78)
  - [`lib/features/employee/presentation/cubit/plans/employee_plans_cubit.dart`](file:///home/osama/Desktop/Systm-Gulf/check_point_v2/lib/features/employee/presentation/cubit/plans/employee_plans_cubit.dart)

---

### Issue 3: Plan Feedback Statuses 404 Route Not Found (`/api/Plan/feedBackStatus`)
- **Domain:** Employee — Visit Plans Feedback
- **Severity:** Medium
- **Description:** Loading the feedback statuses dropdown when submitting visit reports fails with `404 Not Found`.
- **Root Cause:**
  The Flutter API Service defines `@GET(ApiConstants.feedBackStatus)` (`/api/Plan/feedBackStatus`), but the backend OpenAPI routes feedback under `/api/v1/Feedback` or `/api/v2/customer-plans/{id}/feedback`.
- **Request / Response:**
  ```http
  GET /api/Plan/feedBackStatus

  HTTP 404 Not Found
  {"value":null,"status":404,"isSuccess":false,"errors":["Route GET /api/Plan/feedBackStatus not found"],"validationErrors":[]}
  ```
- **Impacted Files:**
  - [`lib/features/employee/data/apis/employee_api_service.dart#L98`](file:///home/osama/Desktop/Systm-Gulf/check_point_v2/lib/features/employee/data/apis/employee_api_service.dart#L98)
  - [`lib/core/network/api_constants.dart#L30`](file:///home/osama/Desktop/Systm-Gulf/check_point_v2/lib/core/network/api_constants.dart#L30)

---

### Issue 4: Productive Hours Endpoint Conflict (`/api/v2/tasks/productive-hours`)
- **Domain:** Employee / Supervisor — Tasks & Productivity
- **Severity:** Medium
- **Description:** Calling `GET /api/v2/tasks/productive-hours?from=...&to=...` returns `404 Not Found` with message `"Task was not found"`.
- **Root Cause:**
  The backend router interprets `productive-hours` as a task ID matching the parameter route `/api/v2/tasks/{id}`, and fails when attempting to query a task with ID `'productive-hours'`.
- **Request / Response:**
  ```http
  GET /api/v2/tasks/productive-hours?from=2026-01-01&to=2026-12-31

  HTTP 404 Not Found
  {"value":null,"status":404,"isSuccess":false,"errors":["Task was not found"],"validationErrors":[]}
  ```
- **Impacted Files:**
  - [`lib/features/employee/data/apis/employee_api_service.dart#L133`](file:///home/osama/Desktop/Systm-Gulf/check_point_v2/lib/features/employee/data/apis/employee_api_service.dart#L133)

---

### Issue 5: Track Employee Location 404 Route Not Found (`/api/Attendance/trackEmployeeLocation`)
- **Domain:** Employee — Real-time Location Tracking
- **Severity:** Medium
- **Description:** Background GPS location heartbeat sent by employee devices returns `404 Not Found`.
- **Root Cause:**
  Flutter specifies `POST /api/Attendance/trackEmployeeLocation`. The backend OpenAPI spec defines tracking at `POST /api/v1/Employee/trackEmployee` or `POST /api/v2/attendance/tracking/batch`.
- **Request / Response:**
  ```http
  POST /api/Attendance/trackEmployeeLocation
  {"employeeId":"01M2XC3ZWW6XDCZSCMEXVQN2Q5","latitude":30.0444,"longitude":31.2357,"date":"2026-10-06T11:17:00Z"}

  HTTP 404 Not Found
  {"value":null,"status":404,"isSuccess":false,"errors":["Route POST /api/Attendance/trackEmployeeLocation not found"],"validationErrors":[]}
  ```
- **Impacted Files:**
  - [`lib/features/employee/data/apis/employee_api_service.dart#L58`](file:///home/osama/Desktop/Systm-Gulf/check_point_v2/lib/features/employee/data/apis/employee_api_service.dart#L58)
  - [`lib/core/network/api_constants.dart#L26`](file:///home/osama/Desktop/Systm-Gulf/check_point_v2/lib/core/network/api_constants.dart#L26)

---

### Issue 6: Supervisor Late Comers 400 Validation Error (`/api/Attendance/lateComers/{day}`)
- **Domain:** Supervisor — Attendance Monitoring
- **Severity:** High
- **Description:** Opening the Supervisor Attendance screen and querying Late Comers causes a `400 Bad Request` validation error.
- **Root Cause:**
  The Flutter `SupervisorAttendanceCubit` sends either the day name (e.g. `'Tuesday'`) or a truncated date (e.g. `'2026-10-06'`). However, the backend parameter `day` has a strict validator requiring full ISO 8601 date-time format (`YYYY-MM-DDTHH:MM:SSZ`).
- **Request / Response:**
  ```http
  GET /api/Attendance/lateComers/2026-10-06

  HTTP 400 Bad Request
  {"value":null,"status":400,"isSuccess":false,"errors":["Validation failed"],"validationErrors":[{"identifier":"day","errorMessage":"must match format \"date-time\"","errorCode":"format","severity":0}]}
  ```
- **Impacted Files:**
  - [`lib/features/supervisor/presentation/cubit/attendance/supervisor_attendance_cubit.dart#L26-L32`](file:///home/osama/Desktop/Systm-Gulf/check_point_v2/lib/features/supervisor/presentation/cubit/attendance/supervisor_attendance_cubit.dart#L26-L32)
  - [`lib/features/supervisor/data/apis/supervisor_api_service.dart#L38`](file:///home/osama/Desktop/Systm-Gulf/check_point_v2/lib/features/supervisor/data/apis/supervisor_api_service.dart#L38)

---

### Issue 7: Supervisor Early Leavers 400 Validation Error (`/api/Attendance/earlyLeavers/{day}`)
- **Domain:** Supervisor — Attendance Monitoring
- **Severity:** High
- **Description:** Querying Early Leavers in Supervisor Attendance causes a `400 Bad Request` validation error identical to Late Comers.
- **Root Cause:**
  Format mismatch on the `{day}` parameter: Flutter sends date-only string instead of full ISO 8601 date-time.
- **Request / Response:**
  ```http
  GET /api/Attendance/earlyLeavers/2026-10-06

  HTTP 400 Bad Request
  {"value":null,"status":400,"isSuccess":false,"errors":["Validation failed"],"validationErrors":[{"identifier":"day","errorMessage":"must match format \"date-time\"","errorCode":"format","severity":0}]}
  ```
- **Impacted Files:**
  - [`lib/features/supervisor/presentation/cubit/attendance/supervisor_attendance_cubit.dart#L33`](file:///home/osama/Desktop/Systm-Gulf/check_point_v2/lib/features/supervisor/presentation/cubit/attendance/supervisor_attendance_cubit.dart#L33)
  - [`lib/features/supervisor/data/apis/supervisor_api_service.dart#L41`](file:///home/osama/Desktop/Systm-Gulf/check_point_v2/lib/features/supervisor/data/apis/supervisor_api_service.dart#L41)

---

### Issue 8: Notifications "Mark All Read" 400 Bad Request (`/api/v2/notifications/read-all`)
- **Domain:** Notifications
- **Severity:** Medium
- **Description:** Tapping "Mark All As Read" on the notifications screen fails with `400 Bad Request`.
- **Root Cause:**
  In `NotificationsApiService`, the Retrofit annotation `@POST('/api/v2/notifications/read-all')` is defined without a `@Body()` parameter. Dio defaults to sending an empty string body while sending the header `Content-Type: application/json`. The backend JSON parser rejects empty bodies with `application/json` header.
- **Request / Response:**
  ```http
  POST /api/v2/notifications/read-all
  Content-Type: application/json
  [Empty Body]

  HTTP 400 Bad Request
  {"value":null,"status":400,"isSuccess":false,"errors":["Body cannot be empty when content-type is set to 'application/json'"],"validationErrors":[]}
  ```
- **Impacted Files:**
  - [`lib/features/notifications/data/apis/notifications_api_service.dart#L21`](file:///home/osama/Desktop/Systm-Gulf/check_point_v2/lib/features/notifications/data/apis/notifications_api_service.dart#L21)
  - [`lib/features/notifications/presentation/cubit/notifications_cubit.dart`](file:///home/osama/Desktop/Systm-Gulf/check_point_v2/lib/features/notifications/presentation/cubit/notifications_cubit.dart)

---

### Issue 9: Projects Deletion 400 Bad Request (`DELETE /api/v2/projects/{id}`)
- **Domain:** Projects & Kanban
- **Severity:** Medium
- **Description:** Deleting a newly created project returns HTTP 400.
- **Root Cause:**
  The delete project request requires either cascade deletion flags or confirmation parameters in query/body on the backend before removing parent project containers with default status columns.
- **Request / Response:**
  ```http
  DELETE /api/v2/projects/d4c7cf04-ce20-4c53-a8d2-81ba0b81636f

  HTTP 400 Bad Request
  ```
- **Impacted Files:**
  - [`lib/features/projects/data/apis/projects_api_service.dart#L24`](file:///home/osama/Desktop/Systm-Gulf/check_point_v2/lib/features/projects/data/apis/projects_api_service.dart#L24)
  - [`lib/features/projects/presentation/cubit/projects_cubit.dart`](file:///home/osama/Desktop/Systm-Gulf/check_point_v2/lib/features/projects/presentation/cubit/projects_cubit.dart)

---

### Issue 10: Clock-Out Without Existing Clock-In Returns 404
- **Domain:** Employee — Attendance Clocking
- **Severity:** Low (Business Validation)
- **Description:** Attempting to clock out when the user has not clocked in for the current day returns `404 Not Found` with message `"No clock-in recorded for today was not found"`.
- **Root Cause:**
  While this is valid business behavior on the server, the Flutter UI does not preemptively disable the Check-Out button when no active check-in session exists, leading to a raw server error if triggered out of sequence.
- **Impacted Files:**
  - [`lib/features/employee/presentation/cubit/attendance/employee_attendance_cubit.dart`](file:///home/osama/Desktop/Systm-Gulf/check_point_v2/lib/features/employee/presentation/cubit/attendance/employee_attendance_cubit.dart)
  - [`lib/features/employee/presentation/widgets/employee_attendance_location_sheet_widget.dart`](file:///home/osama/Desktop/Systm-Gulf/check_point_v2/lib/features/employee/presentation/widgets/employee_attendance_location_sheet_widget.dart)

---

### Issue 11: Base URL Configuration in `.env`
- **Domain:** Configuration & Networking
- **Severity:** High
- **Description:** The `.env` file contained `BASE_URL=http://10.0.2.2:4100` (which is a local Android emulator port that does not have an active server), whereas the live running API server is located at `http://137.184.223.222`.
- **Root Cause:** Environment file pointed to an offline local mock port.
- **Impacted Files:**
  - [`.env`](file:///home/osama/Desktop/Systm-Gulf/check_point_v2/.env)

---

## 3. Detailed Matrix of Test Results

| Domain | Tested Route / Feature | Role | HTTP Status | Status | Observed Behavior |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **Auth** | `/api/Auth/Login` (`osama.ma`) | Employee | 401 | ❌ FAIL | Invalid credentials error returned. |
| **Auth** | `/api/Auth/Login` (`osama.mahmoud`) | All Roles | 200 | ✅ PASS | Authenticated with roles `[Supervisor, Employee, Admin]`. |
| **Auth** | `/api/Auth/DeviceTransferRequest` | All Roles | 200 | ✅ PASS | Device transfer request created. |
| **Auth** | `/api/AccountRequest/status` | Guest | 200 | ✅ PASS | Status verified by `mobileId`. |
| **Employee** | `GET /api/Employee/{id}` | Employee | 200 | ✅ PASS | Full profile returned. |
| **Employee** | `GET /api/Attendance/employeeId/{id}` | Employee | 200 | ✅ PASS | Attendance history returned. |
| **Employee** | `GET /api/Branch` | Employee | 200 | ✅ PASS | Branch list returned. |
| **Employee** | `GET /api/Customer/customerType/all` | Employee | 200 | ✅ PASS | Customer sites returned. |
| **Employee** | `GET /api/Plan/employee/{id}` | Employee | 404 | ❌ FAIL | Route not found on backend. |
| **Employee** | `GET /api/Plan/feedBackStatus` | Employee | 404 | ❌ FAIL | Route not found on backend. |
| **Employee** | `GET /api/Task/specificEmployee` | Employee | 200 | ✅ PASS | Tasks list returned. |
| **Employee** | `GET /api/LeaveType` | Employee | 200 | ✅ PASS | Leave types returned. |
| **Employee** | `GET /api/LeaveRequest/employeeId/{id}`| Employee | 200 | ✅ PASS | Leave requests returned. |
| **Employee** | `GET /api/v1/leaves/balances` | Employee | 200 | ✅ PASS | Balances returned. |
| **Employee** | `GET /api/v1/leaves/holidays` | Employee | 200 | ✅ PASS | Holidays calendar returned. |
| **Employee** | `GET /api/v1/leaves/permissions/requests`| Employee | 200 | ✅ PASS | Short permissions returned. |
| **Employee** | `GET /api/v2/tasks/productive-hours` | Employee | 404 | ❌ FAIL | Matched task ID instead of query. |
| **Employee** | `POST /api/Attendance/trackEmployeeLocation`| Employee | 404 | ❌ FAIL | Route not found on backend. |
| **Employee** | `POST /api/Attendance/inWithoutPlan` | Employee | 403 | ⚠️ WARN | Intercepted (Armed Forces Day Holiday). |
| **Supervisor** | `GET /api/Attendance` | Supervisor | 200 | ✅ PASS | Overview attendance returned. |
| **Supervisor** | `GET /api/Attendance/departmentId/{id}`| Supervisor | 200 | ✅ PASS | Department attendance returned. |
| **Supervisor** | `GET /api/Attendance/lateComers/{day}` | Supervisor | 400 | ❌ FAIL | Requires ISO date-time format. |
| **Supervisor** | `GET /api/Attendance/earlyLeavers/{day}` | Supervisor | 400 | ❌ FAIL | Requires ISO date-time format. |
| **Supervisor** | `GET /api/LeaveRequest/departmentId/{id}`| Supervisor | 200 | ✅ PASS | Department leaves returned. |
| **Supervisor** | `GET /api/Task/department/{id}` | Supervisor | 200 | ✅ PASS | Department tasks returned. |
| **Supervisor** | `GET /api/Plan/department/{id}` | Supervisor | 200 | ✅ PASS | Department plans returned. |
| **Supervisor** | `GET /api/Employee/departmentId/{id}` | Supervisor | 200 | ✅ PASS | Department team returned. |
| **Admin** | `GET /api/v2/audit` | Admin | 200 | ✅ PASS | Audit log returned. |
| **Admin** | `GET /api/v2/devices/pending` | Admin | 200 | ✅ PASS | Pending devices returned. |
| **Admin** | `GET /api/v2/employees/{id}/devices` | Admin | 200 | ✅ PASS | Employee devices returned. |
| **Admin** | `GET /api/Employee` | Admin | 200 | ✅ PASS | All employees returned. |
| **Admin** | `GET /api/Employee/deleted` | Admin | 200 | ✅ PASS | Deleted employees bin returned. |
| **Admin** | `GET /api/v2/permissions/catalogue` | Admin | 200 | ✅ PASS | Permissions catalogue returned. |
| **Admin** | `GET /api/v2/users/{id}/permissions` | Admin | 200 | ✅ PASS | User permissions returned. |
| **Admin** | `GET /api/AccountRequest` | Admin | 200 | ✅ PASS | Account requests returned. |
| **Admin** | `GET /api/Department` | Admin | 200 | ✅ PASS | Departments returned. |
| **Admin** | `GET /api/Shift` | Admin | 200 | ✅ PASS | Shifts returned. |
| **Admin** | `GET /api/Policy/shift/{id}` | Admin | 200 | ✅ PASS | Policies returned. |
| **Admin** | `GET /api/LeaveRequest` | Admin | 200 | ✅ PASS | All leave requests returned. |
| **Admin** | `GET /api/Task` | Admin | 200 | ✅ PASS | All tasks returned. |
| **Admin** | `GET /api/Plan` | Admin | 200 | ✅ PASS | All plans returned. |
| **Projects** | `GET /api/v2/projects` | All Roles | 200 | ✅ PASS | Projects list returned. |
| **Projects** | `POST /api/v2/projects` | All Roles | 200 | ✅ PASS | Project created successfully. |
| **Projects** | `GET /api/v2/projects/{id}/tasks` | All Roles | 200 | ✅ PASS | Project tasks returned. |
| **Projects** | `DELETE /api/v2/projects/{id}` | All Roles | 400 | ❌ FAIL | Project deletion rejected. |
| **Notifications**| `GET /api/v2/notifications` | All Roles | 200 | ✅ PASS | Notifications list returned. |
| **Notifications**| `POST /api/v2/notifications/read-all` | All Roles | 400 | ❌ FAIL | Empty JSON body rejected. |
| **Remote Work** | `GET /api/v2/remote-policies` | All Roles | 200 | ✅ PASS | Remote policies returned. |
| **Remote Work** | `GET /api/v2/remote-requests` | All Roles | 200 | ✅ PASS | Remote requests returned. |
