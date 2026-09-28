# SAMCO Phase 0 - Scope Audit and Baseline Protection

## Audit date

2026-09-28

## Purpose

This document records the Phase 0 baseline for the SAMCO Attendance & Workforce Tracking implementation. It distinguishes the accepted SAMCO product scope from the current Check Point application and protects existing user work before later phases are extended.

## Baseline status

- The current working tree already contains user changes related to contractors, worker assignments, supervisor site views, geofence rendering, offline attendance synchronization, localization, routing, and dependency injection.
- Those changes are treated as user-owned and are not deleted, reset, or replaced.
- The repository currently passes `flutter analyze` with six pre-existing deprecation infos in the admin employee edit widgets.
- The repository test suite currently passes all tests.
- No backend repository is present in this Flutter workspace. API paths and response shapes must therefore remain aligned with the existing client contract until the backend contract is confirmed.

## SAMCO target scope

The target business hierarchy is:

```text
Tenant / Company
  → Project
  → Site
  → Contractor
  → Worker
  → Assignment
  → Attendance
```

The primary product roles are:

- Admin / HR: full tenant scope.
- Site Supervisor: assigned-site scope.
- Contractor: own-workforce scope.

Worker is a business record. It is not treated as a fourth primary role unless the backend contract explicitly requires worker accounts.

## Existing implementation coverage

### Phase 1 - Authentication, tenant, roles, and permissions

Existing coverage:

- Tenant lookup and secure tenant storage.
- Secure token/session storage.
- Device identity provider.
- Login role selection and selected-role validation.
- Biometric login support.
- Centralized role-based route navigation.
- Existing permission constants and permission persistence.

Remaining work:

- Add the SAMCO-specific permission vocabulary without breaking legacy permissions.
- Ensure Contractor is included in role defaults and role access checks.
- Verify every SAMCO route/action against server-side scope enforcement.
- Confirm device-limit and device-reverification behavior with the backend contract.

### Phase 2 - Projects and sites

Existing coverage:

- A project feature exists, but it is currently centered on task management.
- Existing admin location and supervisor location screens exist.
- Site boundary models and map rendering exist in the SAMCO-related changes.

Remaining work:

- Confirm whether the existing Project model can represent SAMCO project fields without breaking task workflows.
- Separate project/site attendance concepts from legacy project-task concepts where necessary.
- Complete site CRUD and boundary persistence against the confirmed API contract.
- Support both circle and polygon boundary configuration.
- Enforce active/inactive site behavior.

### Phase 3 - Contractors, workers, supervisors, and assignments

Existing coverage:

- Contractor models, API service, repository, Cubit, screens, and routes exist.
- Contractor worker records exist.
- Worker-to-site assignment models and admin assignment UI exist.
- Supervisor contractor/site screens exist.

Remaining work:

- Confirm assignment history semantics and prevent destructive history changes.
- Add explicit active-assignment validation to attendance actions.
- Complete supervisor assignment management if required by the backend.
- Replace any demo fallback identifiers with authenticated or API-provided identifiers.

### Phase 4 - Check-in, check-out, and worked hours

Existing coverage:

- Check-in/check-out API methods exist in the contractor API service.
- Attendance models include site, project, worker, time, status, geofence, device, and offline fields.
- Existing location and geofence verification services exist.
- Offline attendance queue and batch synchronization service exist.

Remaining work:

- Queue only transient network failures, never business validation or authorization failures.
- Preserve failed non-retryable actions as visible localized errors.
- Ensure check-in/check-out payloads include assignment and device information required by the backend.
- Confirm worked-hours calculation ownership between client and server.
- Add focused regression tests for geofence, offline queueing, retry behavior, and duplicate prevention.

## Scope protection decisions

1. Existing HR leave, task, remote-work, and employee modules are not deleted in Phase 0.
2. SAMCO-specific code is extended in the existing feature conventions rather than creating duplicate architecture.
3. No new package is introduced.
4. No generated file is edited manually.
5. Existing uncommitted changes remain intact.
6. Production API contracts are not invented where the backend contract is unavailable.
7. Any legacy feature removal requires a separate dependency and route audit.

## Phase 0 exit criteria

- Current implementation and uncommitted changes are inventoried.
- SAMCO requirements are mapped to existing code and remaining gaps.
- Baseline analysis and test status are recorded.
- No destructive cleanup is performed.
- The next implementation changes address confirmed gaps rather than duplicating existing functionality.
