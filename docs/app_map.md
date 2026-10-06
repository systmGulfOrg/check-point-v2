# Check Point HRM — Application UI & Flow Map
> **Phase 1 Deliverable:** Complete map of all screens, navigation routes, user flows, input fields/buttons, API endpoints used, and UI states (`Loading`, `Success`, `Empty`, `Error`).

---

## 1. Global Navigation & Route Graph

```mermaid
flowchart TD
    Splash[/App Launch/] --> LoginScreen[/login]
    
    LoginScreen --> RequestAccessScreen[/request-access]
    LoginScreen --> AdminMainScreen[/admin]
    LoginScreen --> SupervisorMainScreen[/supervisor]
    LoginScreen --> EmployeeMainScreen[/employee]
    
    subgraph Admin Routes
        AdminMainScreen --> AdminHomeScreen
        AdminMainScreen --> AdminRequestsScreen
        AdminMainScreen --> AdminEmployeesScreen
        AdminMainScreen --> AdminManageScreen
        AdminMainScreen --> AdminSettingsScreen
        
        AdminManageScreen --> AdminDepartmentsScreen[/admin/departments]
        AdminManageScreen --> AdminLocationsScreen[/admin/locations]
        AdminManageScreen --> AdminShiftsPoliciesScreen[/admin/shifts-policies]
        AdminManageScreen --> AdminPermissionsScreen[/admin/permissions]
        AdminManageScreen --> AdminLeaveManagementScreen[/admin/leave-management]
        AdminManageScreen --> AdminTasksScreen[/admin/tasks]
        AdminManageScreen --> AdminPendingDevicesScreen[/admin/pending-devices]
        AdminManageScreen --> AdminPlansScreen[/admin/plans]
        AdminManageScreen --> AdminAttendanceScreen[/admin/attendance]
        
        AdminEmployeesScreen --> AdminCreateEmployeeScreen[/admin/employees/create]
        AdminEmployeesScreen --> AdminEmployeeProfileScreen[/admin/employees/profile]
        AdminEmployeesScreen --> AdminDeletedEmployeesScreen[/admin/employees/deleted]
        AdminEmployeeProfileScreen --> AdminEmployeeAuditScreen[/admin/employees/audit]
        AdminPermissionsScreen --> AdminPermissionDetailsScreen[/admin/permissions/details]
        AdminShiftsPoliciesScreen --> AdminShiftDetailsScreen[/admin/shifts-policies/details]
    end
    
    subgraph Supervisor Routes
        SupervisorMainScreen --> SupervisorHomeScreen
        SupervisorMainScreen --> EmployeeClockScreen
        SupervisorMainScreen --> SupervisorTeamScreen
        SupervisorMainScreen --> SupervisorAttendanceScreen
        SupervisorMainScreen --> ProjectsScreen[/projects]
        SupervisorMainScreen --> SupervisorProfileScreen
        
        SupervisorMainScreen -. Bottom Sheet .-> SupervisorLeaveManagementScreen[/supervisor/leave-management]
        SupervisorMainScreen -. Bottom Sheet .-> SupervisorPlansScreen[/supervisor/plans]
        SupervisorMainScreen -. Bottom Sheet .-> SupervisorNotificationsScreen[/supervisor/notifications]
        SupervisorMainScreen -. Bottom Sheet .-> RemoteWorkScreen[/remote-work]
    end
    
    subgraph Employee Routes
        EmployeeMainScreen --> EmployeeHomeScreen
        EmployeeMainScreen --> EmployeeClockScreen
        EmployeeMainScreen --> ProjectsScreen
        EmployeeMainScreen --> EmployeePlansScreen
        EmployeeMainScreen --> LeavesDashboardScreen[/leaves/dashboard]
        EmployeeMainScreen --> EmployeeSettingsScreen[/employee/settings]
        
        LeavesDashboardScreen --> RequestLeaveScreen[/leaves/request]
        LeavesDashboardScreen --> RequestPermissionScreen[/permissions/request]
    end
    
    subgraph Shared Projects
        ProjectsScreen --> ProjectBoardScreen
    end
```

---

## 2. Screen-by-Screen UI & Component Specification

### 2.1 Authentication Feature (`lib/features/auth/`)

#### 1. `LoginScreen` (`/login`)
- **Inputs & Controls:**
  - `RoleSwitcherWidget`: Radio / Chips for `Admin` | `Supervisor` | `Employee` (Key: `role_switcher`)
  - `AuthLabeledFieldWidget` (Username): `TextFormField` (Key: `username_input_field`)
  - `AuthLabeledFieldWidget` (Password): `TextFormField` with Obscure toggle icon button (Key: `password_input_field`, `toggle_password_obscure`)
  - `CheckboxListTile` (Biometric toggle): Toggles biometric credentials storage (Key: `biometric_login_checkbox`)
  - `LoginSubmitButtonWidget`: Submits login credentials (Key: `login_submit_button`)
  - `BiometricLoginButtonWidget`: Direct biometrics quick login (Key: `quick_biometric_button`)
  - `TextButton` ("Request Access"): Navigates to `/request-access` (Key: `request_access_button`)
  - `LanguageSwitcherWidget`: Toggles Arabic $\leftrightarrow$ English
- **API Endpoints:**
  - `POST /api/Auth/Login`
  - `POST /api/Auth/DeviceTransferRequest`
  - `GET /api/AccountRequest/status?mobileId=...`
- **States:**
  - `Initial`: Clean login form with stored biometric user if configured.
  - `Loading`: Progress indicator inside submit button, inputs disabled.
  - `Success`: Navigates to `/admin`, `/supervisor`, or `/employee`.
  - `DeviceTransferRequired`: Displays modal dialog for device transfer re-binding.
  - `Error`: Displays localized error banner or rate limit countdown timer.

#### 2. `RequestAccessScreen` (`/request-access`)
- **Inputs & Controls:**
  - Full Name (`name_field`), National ID (`national_id_field`), Phone (`phone_field`), Email (`email_field`), Department Dropdown (`department_dropdown`), Job Title (`job_title_field`).
  - Submit Button (`submit_request_access_button`).
- **API Endpoints:**
  - `POST /api/AccountRequest`
  - `GET /api/Department`
- **States:** `Initial`, `Loading`, `Success` (navigates back with confirmation), `Error`.

---

### 2.2 Employee Domain (`lib/features/employee/`)

#### 1. `EmployeeHomeScreen` (Tab 0)
- **Components:** Profile header card, Today Shift & Policy badge, Upcoming Holiday card, Tasks Carousel, Visit Plans preview card.
- **Controls:** "View All Tasks" $\rightarrow$ switches to Projects tab; "View All Plans" $\rightarrow$ switches to Plans tab.
- **API Endpoints:** `GET /api/Employee/{id}`, `GET /api/v1/leaves/holidays`.

#### 2. `EmployeeClockScreen` (Tab 1)
- **Components:**
  - `UpcomingHolidayCardBlocBuilderWidget`: Displays active holiday greetings if today is an official holiday.
  - `EmployeeClockCardWidget`: Shows Shift times, Worked hours counter, Clock-in / Clock-out time labels, Large Clock Action Button (`clock_toggle_button`).
  - `EmployeeAttendanceFilterWidget`: Days filter chips (`All`, `Today`, `Last 7`, `Last 30`), Status filters (`Attended`, `Late`, `Early`).
  - `EmployeeAttendanceLocationSheetWidget`: Geofencing circle/polygon visualization on Google Map, Branch/Customer location selector, Selfie camera preview, Submit Check-In/Out button (`location_sheet_confirm_button`).
- **API Endpoints:**
  - `POST /api/Attendance/in`, `POST /api/Attendance/inWithoutPlan`
  - `POST /api/Attendance/out`, `POST /api/Attendance/outWithoutPlan`
  - `GET /api/Attendance/employeeId/{id}`
  - `GET /api/Branch`, `GET /api/Customer/customerType/{type}`
- **States:** `Initial`, `Loading`, `CheckInSuccess`, `CheckOutSuccess`, `AreaValidationError`, `Error`.

#### 3. `EmployeePlansScreen` (Tab 3)
- **Components:** Date picker bar, List of Customer Visit Plans, Customer coordinates badge, Feedback submission modal.
- **API Endpoints:** `GET /api/Plan/employee/{id}`, `POST /api/Plan/planFeedback`, `POST /api/Plan/removeAssignCustomerPlan`.

#### 4. `EmployeeSettingsScreen` (Tab 5)
- **Components:** User profile overview, Language toggle, Change Password expansion tile (`current_password_field`, `new_password_field`, `confirm_password_field`, `change_password_button`), Logout tile (`logout_button`).
- **API Endpoints:** `PUT /api/Auth/employeeChangePassword`.

---

### 2.3 Leaves & Permissions Feature (`lib/features/leaves/`)

#### 1. `LeavesDashboardScreen` (`/leaves/dashboard`)
- **Components:**
  - `LeaveBalanceSummaryWidget`: Cards showing Annual, Sick, Casual balance.
  - `UpcomingHolidayCardWidget`: Next corporate holiday preview.
  - Filter Bar (`All`, `Pending`, `Approved`, `Rejected`).
  - Requests List with Timeline Stepper (`LeaveApprovalTimelineWidget`).
  - Floating Action Buttons: Request Leave (`request_leave_fab`), Request Permission (`request_permission_fab`).
- **API Endpoints:** `GET /api/v1/leaves/balances`, `GET /api/LeaveRequest/employeeId/{id}`, `DELETE /api/LeaveRequest/{id}`.

#### 2. `RequestLeaveScreen` (`/leaves/request`)
- **Inputs & Controls:**
  - Leave Type dropdown (`leave_type_dropdown`), Start Date picker (`start_date_picker`), End Date picker (`end_date_picker`), Reason text area (`reason_field`), File attachment picker (`attachment_button`), Submit button (`submit_leave_button`).
- **API Endpoints:** `GET /api/LeaveType`, `POST /api/LeaveRequest`.

#### 3. `RequestPermissionScreen` (`/permissions/request`)
- **Inputs & Controls:**
  - Date picker (`permission_date_picker`), From Time picker (`from_time_picker`), To Time picker (`to_time_picker`), Reason input (`permission_reason_field`), Submit button (`submit_permission_button`).
- **API Endpoints:** `POST /api/v1/leaves/permissions/request`.

---

### 2.4 Supervisor Domain (`lib/features/supervisor/`)

#### 1. `SupervisorHomeScreen` (Tab 0)
- **Components:** Metric counters (Present, Late, On Leave, Remote), Subordinates quick list, Pending approvals queue.

#### 2. `SupervisorTeamScreen` (Tab 2)
- **Components:** Search bar (`team_search_bar`), Department staff list, Staff detail sheet (toggle attendance permission, toggle plan permission).
- **API Endpoints:** `GET /api/Employee/departmentId/{id}`, `POST /api/Employee/employeeId/{id}/attendancePermission/{flag}`.

#### 3. `SupervisorAttendanceScreen` (Tab 3)
- **Components:** Date selector, Tabs (`All`, `Late Comers`, `Early Leavers`), Subordinate attendance cards, Manual Check-In/Out action modal.
- **API Endpoints:** `GET /api/Attendance/departmentId/{id}`, `GET /api/Attendance/lateComers/{day}`, `GET /api/Attendance/earlyLeavers/{day}`.

#### 4. `SupervisorLeaveManagementScreen` (`/supervisor/leave-management`)
- **Components:** Pending leave requests queue, Request approval timeline, Approve button (`approve_request_button`), Reject button (`reject_request_button`), Rejection reason dialog.
- **API Endpoints:** `GET /api/LeaveRequest/departmentId/{id}`, `PUT /api/LeaveRequest/leaveRequestStatus`, `PATCH /api/v2/leave-requests/{ulid}/status`.

#### 5. `SupervisorPlansScreen` (`/supervisor/plans`)
- **Components:** Plan list, Create visit plan FAB (`create_plan_fab`), Customer dropdown, Assignee staff dropdown, Target date.
- **API Endpoints:** `GET /api/Plan/department/{id}`, `POST /api/Plan`.

---

### 2.5 Admin Domain (`lib/features/admin/`)

#### 1. `AdminEmployeesScreen`
- **Controls:** Search text field (`employee_search_field`), Department filter dropdown, Add Employee FAB (`add_employee_fab`), Deleted Employees trash button (`deleted_employees_button`), Employee card (Edit, Delete, Audit, Permissions).
- **API Endpoints:** `GET /api/Employee`, `POST /api/Employee`, `PUT /api/Employee/{id}`, `DELETE /api/Auth/DeleteUser/{userId}`.

#### 2. `AdminCreateEmployeeScreen` (`/admin/employees/create`)
- **Inputs:** Name (`name_input`), Username (`username_input`), Email (`email_input`), Phone (`phone_input`), Password (`password_input`), Department (`department_select`), Branch (`branch_select`), Shift (`shift_select`), Policy (`policy_select`), Role (`role_select`). Submit button (`create_employee_submit_button`).

#### 3. `AdminDeletedEmployeesScreen` (`/admin/employees/deleted`)
- **Controls:** Deleted staff list, Restore button (`restore_employee_button`), Permanent Delete button (`permanent_delete_button`).
- **API Endpoints:** `GET /api/Employee/deleted`, `POST /api/Employee/{id}/restore`, `DELETE /api/Employee/{id}/permanent`.

#### 4. `AdminPermissionsScreen` & `AdminPermissionDetailsScreen`
- **Controls:** Permissions catalog list, toggle switches per permission item (`permission_switch_{key}`), Save permissions button (`save_permissions_button`).
- **API Endpoints:** `GET /api/v2/permissions/catalogue`, `GET /api/v2/users/{id}/permissions`, `PUT /api/v2/users/{id}/permissions`.

#### 5. `AdminPendingDevicesScreen` (`/admin/pending-devices`)
- **Controls:** Pending device transfer list, Approve device button (`approve_device_button`), Reject device button (`reject_device_button`).
- **API Endpoints:** `GET /api/v2/devices/pending`, `POST /api/v2/employees/{id}/devices`, `DELETE /api/v2/employees/{id}/devices/{deviceId}`.

#### 6. `AdminShiftsPoliciesScreen` & `AdminShiftDetailsScreen`
- **Controls:** Shift cards list, Add Shift button, Policy cards list, Grace period input, Overtime rate, Assign Shift/Policy to department modal.
- **API Endpoints:** `GET /api/Shift`, `POST /api/Shift`, `GET /api/Policy/shift/{id}`, `POST /api/Policy`, `POST /api/Shift/assignShift`.

#### 7. `AdminDepartmentsScreen` & `AdminLocationsScreen`
- **Controls:** Add / Edit / Delete department and branch modals with GPS radius & Polygon geofence coordinates editor.
- **API Endpoints:** `GET /api/Department`, `POST /api/Department`, `GET /api/Branch`, `POST /api/Branch`.

---

### 2.6 Projects & Kanban Board (`lib/features/projects/`)

#### 1. `ProjectsScreen` (`/projects`)
- **Controls:** Projects list cards, Create Project FAB (`create_project_fab`), Project name, color picker, description.
- **API Endpoints:** `GET /api/v2/projects`, `POST /api/v2/projects`, `PUT /api/v2/projects/{id}`, `DELETE /api/v2/projects/{id}`.

#### 2. `ProjectBoardScreen`
- **Controls:** Horizontal Kanban columns, Add Column button (`add_status_column_button`), Drag column reorder handle, Add Task card button (`add_task_card_button`), Task card detail sheet (Assignee multi-select, Tags chips, File attachment uploader, Task audit logs).
- **API Endpoints:**
  - `GET /api/v2/projects/{id}/tasks`, `POST /api/v2/projects/{id}/tasks`
  - `PUT /api/v2/projects/{id}/statuses/reorder`
  - `PATCH /api/v2/tasks/{id}/status`
  - `PUT /api/v2/tasks/{id}/assignees`
  - `POST /api/v2/tasks/{id}/attachments`
  - `GET /api/v2/tasks/{id}/audit`

---

### 2.7 Remote Work Feature (`lib/features/remote_work/`)

#### 1. `RemoteWorkScreen` (`/remote-work`)
- **Controls:** Tab 0 (My Requests): Request remote day modal, calendar selector, reason; Tab 1 (Policies / Team Approvals for Supervisor/Admin): Remote policies list, Create policy modal, Approve/Reject subordinate remote requests.
- **API Endpoints:** `GET /api/v2/remote-policies`, `GET /api/v2/remote-requests`, `POST /api/v2/remote-requests`, `PATCH /api/v2/remote-requests/{id}/status`.

---

### 2.8 Notifications Feature (`lib/features/notifications/`)

#### 1. `SupervisorNotificationsScreen` (`/supervisor/notifications`)
- **Controls:** Notifications list with read/unread indicators, Mark all as read button (`mark_all_read_button`), Tap notification item to mark single read.
- **API Endpoints:** `GET /api/v2/notifications`, `PATCH /api/v2/notifications/{id}/read`, `POST /api/v2/notifications/read-all`.
