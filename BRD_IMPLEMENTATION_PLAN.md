# BRD Implementation Plan — Remote Attendance, Permits & Leave Management

## Scope and delivery decisions

- Implement the BRD's mandatory requirements only.
- Deliver backend-first, then integrate Flutter against stable API contracts.
- Version one stores in-app notifications only; FCM delivery is deferred.
- Optional recommendations (VPN detection, quotas, offline signed cache) are deferred.

## Phases

### Phase 1 — Backend foundation and contracts

- Stabilize attendance, permit, leave, productive-hours, and notification data contracts.
- Add safe Prisma migration(s) for missing BRD fields while preserving legacy records.
- Standardize machine-readable error codes and role-specific approval permissions.
- Add API contract and tenant-isolation tests.

### Phase 2 — Remote attendance

- Support shift-bound remote check-in/out without office geofence enforcement.
- Persist separate check-in/check-out location metadata and mock-location status.
- Expose nominal hours, lateness, early departure, and remote status in attendance responses.

### Phase 3 — Permit workflow and reconciliation

- Create, list, approve, and reject the three permit types.
- Enforce rejection reasons and manager authorization.
- Link approved permits to attendance and exempt covered late/early minutes.

### Phase 4 — Task-driven productive hours

- Record employee task duration by date.
- Aggregate verified task time and compare it with nominal shift hours.
- Expose under-allocation flags and manager summaries.

### Phase 5 — Leave workflow hardening

- Enforce the 48-hour rule and casual-leave exemption server-side.
- Enforce Manager → HR transitions and update final leave balances transactionally.
- Return actor names, roles, timestamps, and rejection reasons.

### Phase 6 — In-app notifications

- Create notifications for leave and permit lifecycle transitions.
- Support unread counts, read state, and deep-link payloads.

### Phase 7 — Flutter data integration

- Update Retrofit services, DTOs, repositories, Cubits, DI, and failure mapping.
- Remove direct API/repository access from screens.
- Add leave history, permit workflow, attendance metadata, productive-hours, and notification data flows.

### Phase 8 — Flutter UI

- Update attendance, permit, leave timeline, approval, and notification screens using existing core widgets and design tokens.
- Preserve Arabic/English localization, RTL/LTR behavior, loading, empty, error, and action states.

### Phase 9 — Verification and release readiness

- Run backend typecheck/tests and Flutter generation, analysis, unit tests, and widget tests.
- Validate migration compatibility, tenant isolation, approval authorization, and end-to-end state transitions.

## Phase 1 execution checklist

1. Confirm current schema, migrations, routes, clients, and working-tree state.
2. Define the canonical status/error-code/permission contract.
3. Add the minimum schema fields and relations required by later phases.
4. Add migration tests and API tests for validation, authorization, and tenant isolation.
5. Regenerate Prisma/Flutter outputs only after source changes, then run focused checks.

## Acceptance criteria

- Legacy leave and attendance records remain readable.
- Every rejection requires at least 10 characters.
- Manager and HR actions cannot cross approval stages or roles.
- Non-casual leave submitted inside 48 hours returns `ERR_LEAVE_SUBMISSION_WINDOW_VIOLATION`.
- All new endpoints return stable typed payloads and machine-readable errors.
- No tokens, secrets, or sensitive request bodies are logged.

## Implementation status

- Phase 1–7: implemented for the mandatory backend contracts and Flutter data flows. This includes the verified Prisma migration, remote attendance metadata/geofence behavior, permit linkage, productive-time endpoints, two-stage leave rules, queued in-app notifications, Flutter Retrofit/repositories/Cubits/DI, and notification/permit screens.
- Verification completed: Prisma schema valid, Prisma Client generated, migration applied and database up to date, backend typecheck passed, focused backend suite passed (98/98), and targeted Flutter analysis passed with no issues.
- Remaining non-BRD baseline issues: the repository-wide Flutter suite has four pre-existing/fixture-dependent failures (secure-storage plugin mock and unrelated admin Cubit expectations); repository-wide backend tests also contain unrelated legacy auth/employee/v1 fixture failures. These are recorded rather than masked.
