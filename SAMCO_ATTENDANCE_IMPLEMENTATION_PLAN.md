# SAMCO Attendance & Workforce Tracking System

## Comprehensive Implementation Plan

**Source specification:** `SAMCO_Attendance_Tracking_System (1) (3).pdf`
**Target project:** Check Point Flutter application
**Implementation style:** Incremental, feature-first, role-scoped, API-driven
**Status:** Phases 0-9 implemented incrementally; remaining roadmap phases are documented below

---

## 1. Purpose and Scope

The goal is to evolve the current application into the SAMCO Construction Attendance & Workforce Tracking System described in the source design document.

The final product will be project/site-centric rather than employee-centric. The primary hierarchy is:

```text
Company / Tenant
    └── Project
        └── Site
            ├── Supervisor(s)
            └── Contractor(s)
                └── Worker(s)
                    └── Assignment(s)
                        └── Attendance record(s)
```

The implementation must support:

- Authentication and role-based access.
- Project, site, contractor, worker, supervisor, and assignment management.
- Circle and polygon geofencing.
- GPS-validated check-in and check-out.
- Offline attendance capture and automatic synchronization.
- Contractor, supervisor, and admin dashboards.
- Configurable correction approval workflows.
- Notifications and operational reports.
- Device binding and security audit logging.
- Arabic/English localization with RTL/LTR support.
- Full loading, empty, error, success, offline, and permission-denied states.

The initial implementation will preserve compatible existing functionality while progressively moving the product toward the SAMCO scope. Existing unrelated features will not be deleted until the Phase 0 scope review confirms that they are outside the accepted product scope and are not required by existing flows.

---

## 2. Requirements Sources and Priority

There are two different instruction sources and they must not be mixed:

### 2.1 Product requirements from the attached PDF

The PDF defines the business product:

- The three primary roles.
- Project/site/contractor/worker relationships.
- Attendance and geofence behavior.
- Offline synchronization.
- Dashboards, reports, notifications, corrections, security, audit, and roadmap.

### 2.2 Repository engineering rules from `AGENTS.md`

`AGENTS.md` defines how the product must be implemented in this repository:

- Flutter with `flutter_bloc` and Freezed states.
- Dio and Retrofit for networking.
- `ApiResult<T>` for repository responses.
- GetIt dependency injection in `lib/core/di/service_locator.dart`.
- Freezed and JSON serializable models.
- `easy_localization` for Arabic and English.
- `flutter_screenutil_plus` for dimensions.
- Secure storage for tokens and secrets.
- Navigator 1.0 with centralized routes.
- Feature-first structure.
- No domain entities.
- No direct API or repository access from UI.
- No hand-edited generated files.
- Required tests and static analysis.

The PDF determines what the system does. `AGENTS.md` determines how the change is implemented.

---

## 3. Product Roles and Responsibilities

The PDF defines three primary roles. A Worker is a business entity and is not treated as a fourth primary role unless the backend contract explicitly requires worker accounts.

### 3.1 Admin / HR

Admin has full system visibility and control within the tenant.

Responsibilities:

- Create and edit projects.
- Create and edit sites.
- Configure site boundaries and allowed attendance methods.
- Create and manage contractor records.
- Create supervisor accounts.
- Assign supervisors to sites.
- Link contractors to projects and sites.
- Manage workers and worker assignments.
- Configure shifts, breaks, attendance rules, and tracking policies.
- View all attendance records.
- Review correction requests and approval workflows.
- Configure device limits.
- Configure location tracking policy and retention settings.
- View system-wide dashboards and reports.
- Review audit logs and security events.
- Manage system settings.

Admin scope:

```text
All projects, sites, contractors, supervisors, workers, assignments, attendance, reports, and audit data in the tenant.
```

### 3.2 Site Supervisor

Supervisor manages one or more assigned sites.

Responsibilities:

- View assigned sites.
- View all contractors operating on assigned sites.
- View all workers assigned to assigned sites.
- Review check-in and check-out records.
- Review lateness, absence, and outside-geofence cases.
- Monitor site headcount.
- View worker positions when permitted by policy.
- Review or approve actions according to the configured workflow.
- Generate site reports.
- Review expected workers who have not checked in.

Supervisor scope:

```text
Only assigned sites and all in-scope contractors/workers/attendance records within those sites.
```

### 3.3 Contractor

Contractor manages the workers belonging to that contractor.

Responsibilities:

- Add and edit worker records.
- View only owned workers.
- Record worker check-in and check-out where permitted.
- Track attendance, absence, and lateness.
- View worker location/status according to policy.
- Submit attendance correction requests.
- View reports for the contractor workforce.
- See worker site assignments.
- Assign or transfer workers when permitted.

Contractor scope:

```text
Only the contractor's workers, assignments, attendance, requests, and reports.
```

### 3.4 Worker as a Business Entity

Worker records must contain the information required by the PDF:

- Worker ID.
- Full name.
- National ID.
- Phone number.
- Photo.
- Contractor relationship.
- Project relationship through assignment.
- Site relationship through assignment.
- Job title.
- Worker code or QR code.
- Status.
- Start date.
- Documents.

If the backend later requires direct Worker login, it must be added as an explicit contract decision rather than inferred in the Flutter UI.

---

## 4. Target Feature Structure

The feature-first structure must follow the repository rules and existing conventions:

```text
lib/
  core/
    app/
    auth/
    config/
    di/
    localization/
    network/
    routes/
    services/
    storage/
    styles/
    theme/
    utils/
    widgets/
  features/
    auth/
    projects/
    sites/
    contractors/
    workers/
    assignments/
    attendance/
    tracking/
    corrections/
    notifications/
    reports/
    admin/
    supervisor/
    contractor/
```

Each new feature should use only the layers it genuinely needs:

```text
presentation → data
presentation → domain → data    when business rules or orchestration justify it
```

No entities or entity-mapping layer will be introduced. Data models and DTOs are used directly throughout the app.

---

## 5. Phase 0 - Scope Audit and Baseline Protection

### Objective

Understand the current application, protect existing user changes, and produce an evidence-based gap report before implementation.

### Activities

1. Inspect the current working tree with `git status --short`.
2. Treat all existing uncommitted changes as user-owned.
3. Inventory current features, routes, Cubits, repositories, API services, models, DI registrations, translations, and tests.
4. Compare existing modules with the SAMCO product scope.
5. Identify existing SAMCO-related work already present, including contractor management, assignments, geofence components, offline synchronization, and supervisor site views.
6. Identify overlapping legacy modules and decide whether each one is:
   - Reused.
   - Adapted.
   - Kept temporarily for compatibility.
   - Deprecated after migration.
7. Confirm the backend/API source of truth before implementing missing endpoints.
8. Confirm whether the current Employee role maps to Worker, Contractor, or an unrelated legacy role.
9. Document all contract gaps and unresolved backend decisions.

### Deliverables

- Current-state inventory.
- PDF-to-code gap matrix.
- Route and role matrix.
- Data model gap list.
- API contract gap list.
- List of candidate legacy features for removal or deprecation.
- No code deletion during this phase.

### Exit criteria

- Every PDF capability has an identified implementation location.
- Every current SAMCO-related change is accounted for.
- No destructive cleanup is proposed without a dependency check.
- Backend ownership and API availability are documented.

---

## 6. Phase 1 - Authentication, Tenant, Roles, and Permissions

### Objective

Establish a secure foundation that makes every subsequent feature role-aware and scope-aware.

### Backend/API contract

Expected operations:

```text
POST /auth/login
POST /auth/logout
POST /auth/refresh
GET  /auth/profile
GET  /auth/permissions
GET  /auth/devices
POST /auth/devices/verify
POST /auth/devices/revoke
```

The exact endpoint names must follow the available backend contract. The Flutter layer must not invent production endpoints without confirmation.

### Flutter implementation

- Preserve the existing authentication repository convention.
- Keep login orchestration in the existing login UseCase where applicable.
- Persist tokens only through secure storage.
- Initialize and send the device identity through the supported request mechanism.
- Persist tenant context and send tenant headers through the existing network layer.
- Centralize role and permission checks.
- Add role-aware initial navigation.
- Add unauthorized and forbidden handling.
- Ensure logout clears the session correctly.
- Preserve biometric behavior and test any affected storage side effects.

### Permission matrix

Every protected operation must be checked at both UI and API levels:

| Capability | Admin | Supervisor | Contractor |
|---|---:|---:|---:|
| View all projects | Yes | Assigned scope | Permitted scope |
| Manage projects | Yes | No unless explicitly configured | No |
| Manage sites | Yes | No unless explicitly configured | No |
| Manage contractors | Yes | View assigned scope | Own record only |
| Manage workers | Yes | View assigned scope | Own workers |
| Manage assignments | Yes | Configurable | Configurable |
| Check-in/check-out | Configurable | Configurable | Configurable |
| View site map | Yes | Assigned sites | Own workers if permitted |
| Approve corrections | Yes | Configurable | No unless configured |
| View global reports | Yes | No | No |
| View site reports | Yes | Assigned sites | Own workforce |
| View audit logs | Yes | Configurable | No |
| Manage device limits | Yes | No | No |

### Tests

- Login success.
- Invalid credentials.
- Role mismatch.
- Missing permission.
- Device rejection.
- Device limit exceeded.
- Token persistence.
- Logout and session clearing.
- 401 and 403 behavior.
- Biometric session behavior where affected.

### Exit criteria

- All three roles can be authenticated or explicitly blocked according to contract.
- Protected routes and actions enforce permissions.
- Sensitive values remain in secure storage and are not logged.

---

## 7. Phase 2 - Projects and Sites

### Objective

Implement the project/site structure that controls all later scope and attendance behavior.

### Project model

Required fields:

- ID.
- Name.
- Code.
- Client.
- Description where supported.
- Start date.
- End date.
- Status.
- Tenant/company reference.
- Created by.
- Site summary where returned by the API.

### Site model

Required fields:

- ID.
- Project ID.
- Name.
- Code.
- Status.
- Boundary type: `circle` or `polygon`.
- Center latitude for circle mode.
- Center longitude for circle mode.
- Radius for circle mode.
- Ordered boundary points for polygon mode.
- Assigned supervisors.
- Allowed attendance methods.
- Tracking policy.
- Retention policy where supported.

### Screens

Admin:

- Projects list.
- Create project.
- Edit project.
- Project details.
- Sites list.
- Create site.
- Edit site.
- Assign supervisors.
- Configure boundary.

Supervisor:

- Assigned sites list.
- Site details.
- Site summary.
- Site map.

Contractor:

- Assigned/available sites relevant to worker assignments.

### Validation

- Required fields must be validated before submission.
- Dates must be valid and ordered.
- Polygon must contain a valid ordered boundary.
- Circle radius must be positive and within backend limits.
- Inactive sites must not accept check-in.

### Exit criteria

- Projects and sites are available through typed API models.
- Site boundaries can be created, edited, displayed, and validated.
- Scope filtering is enforced for each role.

---

## 8. Phase 3 - Contractors, Supervisors, Workers, and Assignments

### Objective

Build the workforce hierarchy and preserve assignment history.

### Contractor management

Admin capabilities:

- Create contractor.
- Edit contractor.
- Activate/deactivate contractor.
- Assign contractor to projects and sites.
- View contractor workforce summary.

Contractor capabilities:

- View own company profile.
- View own workers.
- View owned assignments and attendance.

### Supervisor management

- Create supervisor account.
- Assign supervisor to one or more sites.
- Remove or change site assignments.
- Preserve assignment changes in audit history.

### Worker management

- Create worker.
- Edit worker.
- Change worker status.
- Upload or reference documents where the backend supports it.
- Generate or display worker code/QR value.
- Filter workers by project, site, contractor, status, and assignment.

### Assignment management

Assignment fields:

- Worker ID.
- Contractor ID.
- Project ID.
- Site ID.
- Shift ID.
- Start date.
- End date.
- Status.
- Assignment reason.
- Created by.
- History metadata.

Rules:

- A worker must have an active assignment to check in.
- Historical assignments are never deleted.
- New assignments close or supersede old assignments according to backend rules.
- Transfers must preserve the old project/site period.
- The same worker must not have conflicting active assignments unless explicitly supported.

### Screens

- Contractor workers list.
- Add worker.
- Edit worker.
- Worker details.
- Worker assignment screen.
- Assignment history.
- Admin worker directory.
- Admin contractor directory.
- Supervisor site workforce directory.

### Exit criteria

- Workers are visible only within the correct role scope.
- Assignments can be created and transferred.
- Assignment history remains available.
- Check-in validation can query active assignment data.

---

## 9. Phase 4 - Check-In, Check-Out, and Worked Hours

### Objective

Implement reliable attendance capture with server-compatible validation.

### Check-in flow

```text
Open app
  → authenticated session
  → select or detect site
  → validate active assignment
  → request current GPS position
  → validate GPS quality
  → validate circle or polygon boundary
  → validate device identity
  → validate duplicate-shift rule
  → save attendance
  → synchronize with server or queue offline
```

### Check-out flow

```text
Open app
  → load active attendance
  → request current GPS position
  → validate check-out policy
  → save check-out time and location
  → calculate worked hours
  → synchronize with server or queue offline
```

### Attendance model

The model must support:

- Attendance ID.
- Worker ID.
- Contractor ID.
- Project ID.
- Site ID.
- Assignment ID.
- Shift ID where supported.
- Business date.
- Check-in timestamp.
- Check-out timestamp.
- Status.
- Check-in location.
- Check-out location.
- Device ID or device reference.
- Source: mobile GPS, offline, admin, or other approved source.
- GPS accuracy.
- Sync status.
- Correction metadata.
- Audit metadata.

### Business rules

- No active assignment means no check-in.
- A worker cannot check in to an unassigned site unless special permission exists.
- Check-out cannot happen before check-in.
- A worker cannot check in twice in the same shift.
- Closed attendance cannot be edited directly.
- Attendance changes must use the correction workflow.
- Worked hours are calculated using check-in, check-out, shift, and break rules.

### Exit criteria

- Valid check-in and check-out flows work online.
- Invalid flows return localized failure keys.
- Attendance records contain the required location/device/source metadata.
- Worked hours are calculated consistently with the backend contract.

---

## 10. Phase 5 - Geofencing and Location Policy

### Objective

Provide accurate, permission-aware location validation without treating GPS as absolute proof.

### Circle geofence

- Calculate distance from the current position to the configured center.
- Accept when distance is within the configured radius and GPS quality is acceptable.
- Reject when outside the radius.
- Handle missing location, denied permission, disabled location services, and poor accuracy.

### Polygon geofence

- Validate that the polygon has a valid point order.
- Use a point-in-polygon algorithm such as ray casting.
- Accept positions inside the polygon.
- Reject positions outside the polygon.
- Handle boundary edge cases consistently.

### Location capture policy

Location must be treated separately from attendance. Capture may occur:

- On check-in.
- On check-out.
- At periodic intervals only when policy allows.
- When leaving the geofence.
- When operationally required.

Continuous GPS polling throughout the day must not be introduced by default.

### Privacy and retention

- Expose only permitted location data by role.
- Do not show live worker positions to unauthorized users.
- Follow the configured retention policy.
- Avoid logging precise locations unnecessarily.
- Provide user-facing permission and privacy messaging.

### Exit criteria

- Circle and polygon validation are covered by unit tests.
- Location permission failures have clear localized states.
- The map and tracking behavior respect role and policy scope.

---

## 11. Phase 6 - Offline Attendance and Synchronization

### Objective

Guarantee that poor connectivity does not cause attendance loss.

### Local queue

The local attendance queue must store the minimum required data to reconstruct and synchronize an attendance operation:

- Operation ID/idempotency key.
- Operation type: check-in or check-out.
- Worker and assignment identifiers.
- Site and project identifiers.
- Original timestamp.
- Location metadata.
- Device identity reference.
- Source.
- Retry count.
- Last error category.
- Created and updated timestamps.
- Sync state.

Sensitive tokens must not be duplicated in the queue.

### Synchronization behavior

- Save locally before attempting network synchronization when offline.
- Sync automatically when connectivity returns.
- Retry transient failures with controlled backoff.
- Stop retrying permanent validation failures and surface them clearly.
- Use idempotency to prevent duplicate server records.
- Preserve original event times.
- Provide a manual retry option where useful.
- Show the number of pending records.

### Exit criteria

- Check-in and check-out survive an offline period.
- Reconnection synchronizes records automatically.
- Duplicate synchronization does not duplicate attendance.
- Failed records remain inspectable and recoverable.

---

## 12. Phase 7 - Contractor Experience

### Navigation

```text
Home
Workers
Attendance
Requests
Reports
Profile
```

### Screens and actions

- Contractor home dashboard.
- Worker list.
- Add worker.
- Edit worker.
- Worker details.
- Worker QR/code display.
- Worker site filter.
- Attendance list.
- Attendance details.
- Correction request creation.
- Correction requests list.
- Reports.
- Profile and company details.
- Offline synchronization banner.

### Dashboard metrics

- Total workers.
- Present today.
- Absent.
- Late.
- Not checked in.
- Workers by site.

### Exit criteria

- Contractor cannot access another contractor's workers or attendance.
- Contractor actions produce correct Cubit states and API requests.
- Offline state is visible and understandable.

---

## 13. Phase 8 - Supervisor Experience

### Navigation

```text
Home
Sites
Workers
Live Attendance
Map
Requests
Reports
Profile
```

### Screens and actions

- Supervisor home dashboard.
- Assigned sites.
- Site details.
- Site workforce.
- Contractor breakdown.
- Live attendance.
- Expected workers not checked in.
- Outside-geofence list.
- Map view.
- Correction approval queue.
- Site reports.
- Profile.

### Dashboard metrics

- Total workers.
- Present.
- Absent.
- Late.
- Outside geofence.
- Checked out.
- Contractor count.
- Not checked in.

### Exit criteria

- Supervisor sees only assigned sites.
- Site dashboards reflect attendance changes.
- Map visibility follows policy.
- Approval actions respect workflow configuration.

---

## 14. Phase 9 - Admin Experience

### Navigation

```text
Dashboard
Projects
Sites
Contractors
Workers
Assignments
Attendance
Tracking
Reports
Users
Devices
Audit Logs
Settings
```

### Dashboard metrics

- Total projects.
- Total sites.
- Total contractors.
- Total workers.
- Present today.
- Absent.
- Late.
- Outside site.
- Pending approvals.
- Attendance anomalies.

### Exit criteria

- Admin can manage all configured SAMCO master data.
- Admin can inspect system-wide attendance and audit information.
- Admin-only controls are not exposed to other roles.

---

## 15. Phase 10 - Correction Requests and Configurable Approval Workflow

### Objective

Prevent direct modification of closed attendance and provide an auditable approval process.

### Correction request fields

- Request ID.
- Worker ID.
- Attendance ID.
- Requested check-in.
- Requested check-out.
- Reason.
- Attachments where supported.
- Current status.
- Requester.
- Current approver.
- Decision reason.
- Created date.
- Decision date.
- Audit information.

### Supported workflow patterns

Pattern A:

```text
Worker → Contractor → Supervisor → Approved
```

Pattern B:

```text
Contractor → Supervisor → Admin → Approved
```

The workflow must be configurable by tenant, project, or policy where supported. It must not be hardcoded into screen navigation.

### States

- Pending.
- In review.
- Approved.
- Rejected.
- Cancelled.
- Failed or expired where supported.

### Exit criteria

- Closed attendance cannot be edited directly.
- Every decision records actor, time, reason, old value, and new value.
- Unauthorized users cannot approve requests.

---

## 16. Phase 11 - Notifications

### Notification events

Contractor:

- Worker absent.
- Worker late.
- Correction approved.
- Correction rejected.
- Worker outside site.

Supervisor:

- New worker assigned.
- Worker checked in.
- Worker checked out.
- Worker outside geofence.
- Correction pending.

Admin:

- New contractor.
- New site.
- Attendance anomaly.
- Pending approval.
- System alert.

### Implementation requirements

- Use typed notification models.
- Support unread counts.
- Support read/unread state.
- Support deep-link payloads.
- Respect role and tenant scope.
- Avoid exposing sensitive data in notification previews.
- Keep delivery channel separate from notification business logic.

In-app notifications are the minimum required implementation. Push delivery may be added after the backend and platform configuration are confirmed.

---

## 17. Phase 12 - Reports

### Daily attendance report

Fields:

- Date.
- Project.
- Site.
- Contractor.
- Worker.
- Check-in.
- Check-out.
- Worked hours.
- Status.
- Location summary.
- Device/source summary.

### Site report

- Contractor count.
- Worker count.
- Present.
- Absent.
- Late.
- Outside geofence.
- Checked out.
- Not checked in.

### Contractor report

- Total workers.
- Present.
- Absent.
- Late.
- Site distribution.
- Date range filters.

### Worker attendance history

- Date.
- Status.
- Check-in.
- Check-out.
- Worked hours.
- Site.
- Correction history.

### Report behavior

- Role-specific scope.
- Date filters.
- Project/site/contractor filters.
- Empty state.
- Loading state.
- Error state.
- Pagination where necessary.
- Export only if supported by the backend contract.

---

## 18. Phase 13 - Security, Device Binding, and Audit

### API security requirements

Every API operation must enforce:

- Authentication.
- Authorization.
- Role permissions.
- Tenant scope.
- Project scope.
- Site scope.
- Device policy where relevant.

### Device binding

Required data:

- Device ID.
- Device model.
- First seen.
- Last seen.
- Account reference.
- Active/revoked status.
- Maximum allowed devices.

Default behavior:

- Worker accounts: one device by default.
- Contractor, supervisor, and admin accounts: configurable limits, commonly two or three.
- New device beyond the limit must be rejected, blocked, or require re-verification according to policy.
- Every device decision must be audited.

### Audit log

Every sensitive operation must capture:

- User.
- Role.
- Action.
- Entity type.
- Entity ID.
- Old value.
- New value.
- Date/time.
- Device/IP metadata where supported.

### Logging restrictions

Never log:

- Access tokens.
- Passwords.
- OTPs.
- Full authorization headers.
- Full sensitive request bodies.
- Unnecessary PII.

All network logging must use the existing redaction mechanism.

### Exit criteria

- Security-sensitive data is stored and transmitted through approved mechanisms.
- Device violations are visible and auditable.
- 401 and 403 flows are tested.
- No new secrets or hardcoded URLs are introduced.

---

## 19. Phase 14 - Localization, UI, Accessibility, and Responsiveness

### Localization

- Add matching keys to both Arabic and English translation files.
- Never hardcode user-facing strings.
- Translate failure localization keys only at display time.
- Use `EdgeInsetsDirectional`, `AlignmentDirectional`, and directional layout APIs.
- Mirror directional icons in RTL.
- Format dates, numbers, times, and hours using the active locale.

### Design system

- Reuse `AppColors`, `AppTextStyles`, `AppAssets`, `AppDecorations`, and existing theme tokens.
- Reuse core buttons, cards, fields, dialogs, snackbars, badges, skeletons, and navigation widgets.
- Add new shared tokens centrally when genuinely required.
- Do not place raw colors, raw asset paths, or ad hoc text styles in feature widgets.

### Widget discipline

- Screens compose widgets and dispatch actions.
- Screens do not call repositories or APIs.
- Screens do not contain business rules.
- Every BlocBuilder, BlocListener, BlocConsumer, or BlocSelector is placed in a named widget file.
- No private helper widget classes.
- No private action-flow helper methods inside screens.
- Use `CustomTextFormField` instead of raw `TextFormField`.
- Use responsive dimensions from `flutter_screenutil_plus`.
- Dispose all controllers and subscriptions.

### QA scenarios

- Arabic RTL.
- English LTR.
- Long worker and project names.
- Long Arabic labels.
- Narrow mobile screens.
- Large screens.
- Keyboard and safe-area insets.
- Loading, empty, error, disabled, focused, pressed, and success states.
- Permission denied and offline states.

---

## 20. Architecture, Networking, and Dependency Injection Rules

### Data layer

Each feature may contain:

- Retrofit API service.
- Freezed/JSON DTOs and request bodies.
- Repository contract and implementation following the existing feature convention.
- API failure mapping.

Repositories must:

- Catch exceptions.
- Map exceptions through the existing failure mapper.
- Return `ApiResult<T>`.
- Never leak raw exceptions to Cubits.

### Domain layer

Create a domain repository contract or UseCase only when justified by:

- Multi-step orchestration.
- Multiple repository coordination.
- Meaningful business rules.
- Reusable transformation.
- Complex validation.

Do not create a domain layer merely for structure.

### Cubits

- Use Cubit by default.
- Use Bloc only when event handling or transformers are required.
- Use Freezed union states with initial, loading, success, and error as applicable.
- Match states exhaustively with Dart 3 switch expressions/patterns.
- Keep Cubits free from Flutter widgets and direct API service dependencies.

### DI

All registrations remain in `lib/core/di/service_locator.dart` in this order:

```text
External clients
    → API services
    → repositories
    → use cases
    → Cubits
```

Use:

- Lazy singletons for services, repositories, and UseCases.
- Factories for Cubits.
- Named constructors.
- Public injected fields.

### Routing

- Keep route names in `AppRoutes`.
- Keep construction in centralized `AppRouter`.
- Create Cubits with `sl<>()` inside routes.
- Pass arguments through `RouteSettings.arguments`.
- Validate route arguments safely.
- Preserve explicit route settings.
- Do not push widget instances directly.

---

## 21. API Contract Map

The PDF proposes the following functional API groups. Actual implementation must align with the available backend contract.

### Authentication

```text
POST /auth/login
POST /auth/logout
POST /auth/refresh
```

### Projects

```text
GET  /projects
GET  /projects/{id}
POST /projects
PUT  /projects/{id}
```

### Sites

```text
GET  /sites
GET  /sites/{id}
POST /sites
PUT  /sites/{id}
```

### Contractors

```text
GET  /contractors
GET  /contractors/{id}
POST /contractors
PUT  /contractors/{id}
```

### Workers

```text
GET  /workers
GET  /workers/{id}
POST /workers
PUT  /workers/{id}
```

### Attendance

```text
POST /attendance/check-in
POST /attendance/check-out
GET  /attendance
GET  /attendance/worker/{id}
GET  /attendance/site/{id}
GET  /attendance/contractor/{id}
```

### Tracking

```text
POST /locations
GET  /locations/worker/{id}
GET  /locations/site/{id}
```

### Corrections

```text
POST /attendance/corrections
GET  /attendance/corrections
POST /attendance/corrections/{id}/approve
POST /attendance/corrections/{id}/reject
```

Additional endpoints may be required for assignments, devices, audit logs, notifications, reports, and workflow configuration.

---

## 22. Testing Strategy

Tests must mirror `lib/` and use the project's approved tools:

- `flutter_test`.
- `bloc_test`.
- `mocktail`.

### Required coverage

Every new or changed repository:

- Success response.
- Server failure.
- Network failure.
- Timeout or relevant distinct failure.
- Request projection.
- Returned model projection.

Every new or changed Cubit:

- Initial state.
- Loading state.
- Success state.
- Error state.
- Every meaningful side effect.
- Every list mutation or pagination result.

Every new or changed UseCase:

- Success behavior.
- Business rule failure.
- Repository failure.
- Multi-step failure behavior.

Every changed screen flow:

- At least one widget test using the real Cubit body with a fake repository.
- Loading, empty, error, and success rendering.
- Action dispatch.
- Localization-sensitive behavior where relevant.

### Mandatory domain-specific tests

- Role scope isolation.
- Assignment prerequisite.
- Assignment history preservation.
- Circle geofence.
- Polygon geofence.
- Duplicate check-in prevention.
- Check-out ordering.
- Offline queue persistence.
- Sync retry and idempotency.
- Correction approval authorization.
- Device limit enforcement.
- Audit side effects.

---

## 23. Generated Code and Verification Commands

After changing any Freezed, JSON serializable, or Retrofit source:

```bash
dart run build_runner build --delete-conflicting-outputs
```

Focused validation:

```bash
flutter analyze
flutter test <relevant-test-paths>
```

Full validation before delivery:

```bash
flutter analyze
flutter test
```

The final report must include:

- Changed files.
- Generated files produced by the toolchain.
- Focused tests executed.
- Full tests executed.
- Static analysis result.
- Known pre-existing failures.
- Remaining risks.

---

## 24. MVP Delivery Boundary

### MVP must include

- Authentication.
- Roles and permissions.
- Projects.
- Sites.
- Contractors.
- Workers.
- Assignments.
- Circle and polygon geofence support.
- Check-in and check-out.
- GPS and timestamp capture.
- Offline attendance protection.
- Supervisor dashboard.
- Admin dashboard.
- Contractor dashboard.
- Core reports.
- Basic audit and device enforcement.

### Phase 2 capabilities

- Live tracking.
- Notifications.
- Attendance corrections.
- Mature offline synchronization.
- Advanced reports.
- Configurable workflows.

### Phase 3 capabilities

- Leave management integration.
- Overtime.
- Payroll integration.
- Documents.
- Advanced analytics.

The existing HR leave/task functionality must not be treated as part of the SAMCO MVP unless the accepted scope explicitly requires integration with it.

---

## 25. End-to-End Acceptance Scenarios

### Scenario A - Admin setup

1. Admin logs in from an approved device.
2. Admin creates a project.
3. Admin creates a site inside the project.
4. Admin defines a circle or polygon geofence.
5. Admin creates a supervisor and assigns the supervisor to the site.
6. Admin creates or links a contractor to the project/site.
7. Contractor account becomes available within the correct scope.

### Scenario B - Contractor workforce setup

1. Contractor logs in.
2. Contractor sees only its own workforce.
3. Contractor creates a worker.
4. Contractor assigns the worker to a project, site, and shift.
5. Assignment history is created.
6. Contractor can see the worker in the correct site view.

### Scenario C - Successful online attendance

1. Worker/authorized user opens the attendance action.
2. The system validates the session and device.
3. The system validates the active assignment.
4. The system reads GPS.
5. The system confirms the worker is inside the site boundary.
6. Check-in is saved with timestamp, location, device, and source.
7. Supervisor dashboard updates.
8. Check-out later calculates worked hours.

### Scenario D - Rejected attendance

The system rejects the operation when:

- No active assignment exists.
- The selected site is not assigned.
- The worker is outside the geofence.
- The worker already checked in during the shift.
- The device is not authorized.
- Location permission or quality is insufficient.

The user receives a localized, non-sensitive explanation.

### Scenario E - Offline attendance

1. User checks in without Internet.
2. Attendance is saved locally.
3. The app shows a pending synchronization state.
4. Connectivity returns.
5. The operation synchronizes automatically.
6. The server receives the original timestamp.
7. The local operation becomes synced.
8. Retrying does not create a duplicate record.

### Scenario F - Correction workflow

1. A closed attendance record requires correction.
2. The authorized requester submits a correction.
3. The configured approver receives a notification.
4. The approver approves or rejects with a reason.
5. The attendance is updated only after approval.
6. Old value, new value, actor, date, and device are recorded in the audit log.

---

## 26. Definition of Done

A phase is complete only when:

- The phase scope is implemented without bypassing repository rules.
- All relevant API models, repositories, Cubits, routes, and DI registrations are complete.
- Generated code has been regenerated where required.
- Success and distinct failure paths are tested.
- The UI supports Arabic and English.
- RTL and LTR layouts are reviewed.
- Loading, empty, error, disabled, and success states are handled.
- Role and scope restrictions are verified.
- Sensitive data is not logged.
- Focused tests pass.
- Static analysis passes for the affected code.
- Existing unrelated changes remain intact.
- Any known limitation is documented before moving to the next phase.

---

## 27. Non-Negotiable Repository Rules

The implementation must not violate these rules from `AGENTS.md`:

- Do not replace the fixed Flutter stack.
- Do not add overlapping packages without explicit approval.
- Do not create entities or entity mappings.
- Do not put business logic in screens.
- Do not call APIs or repositories directly from UI.
- Do not use raw `TextFormField` outside the approved core widget.
- Do not hardcode user-facing strings.
- Do not hardcode colors, styles, or asset paths in feature widgets.
- Do not put tokens or secrets in source control.
- Do not use `shared_preferences` for tokens or secrets.
- Do not log tokens, passwords, OTPs, or sensitive request bodies.
- Do not hand-edit generated files.
- Do not create feature-local route builders.
- Do not use anonymous or direct widget routes.
- Use named constructor parameters for injectable classes.
- Keep injected fields public.
- Use `ApiResult<T>` and centralized failure mapping.
- Use exhaustive Freezed state matching.
- Dispose controllers and subscriptions.
- Run build generation after generator-source changes.
- Add deterministic tests for success, failures, projections, and side effects.
- Preserve existing user changes and avoid unrelated refactors.

---

## 28. Proposed Execution Order

```text
Phase 0  → Scope audit and baseline protection
Phase 1  → Authentication, tenant, roles, and permissions
Phase 2  → Projects and sites
Phase 3  → Contractors, workers, supervisors, and assignments
Phase 4  → Check-in, check-out, and worked hours
Phase 5  → Geofencing and location policy
Phase 6  → Offline attendance and synchronization
Phase 7  → Contractor experience
Phase 8  → Supervisor experience
Phase 9  → Admin experience
Phase 10 → Correction requests and approval workflows
Phase 11 → Notifications
Phase 12 → Reports
Phase 13 → Security, devices, and audit
Phase 14 → Localization, UI polish, accessibility, and responsiveness
Phase 15 → Full testing, regression validation, and release readiness
```

No phase should be marked complete while its role scope, error states, security behavior, localization, or tests remain incomplete.
