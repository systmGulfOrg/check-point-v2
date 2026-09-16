# Implementation Plan — BRD: Remote Attendance, Permits & Leave Management
**Based on:** `checkpoint_business_requirements_attendance_leaves.md`  
**Date:** 2026-09-15  
**Scope:** Backend (Node.js/Fastify/Prisma) + Mobile (Flutter)

---

## Gap Analysis: Current State vs. Requirements

### ✅ Already Implemented
| Feature | Status |
|---|---|
| Leave types CRUD | ✅ Done |
| Leave request submission (Employee) | ✅ Done (simple Pending→Approved/Rejected) |
| Leave balance calculation | ✅ Done |
| Leave overlap check | ✅ Done |
| Leave year quota check | ✅ Done |
| Permits (ShortLeave) model in Prisma | ✅ Schema exists |
| ShortLeave submit/list in Flutter | ✅ Basic UI exists |
| Remote work policy CRUD | ✅ Done |
| Remote work request + approval | ✅ Done |
| Leave cancel | ✅ Done |

### ❌ Missing — Needs Implementation

| # | Gap | BRD Reference |
|---|---|---|
| 1 | **48-hour advance notice rule** not enforced (backend) | §4.1 |
| 2 | **Casual Leave exemption** from 48-hour rule not implemented | §4.1 |
| 3 | **Two-stage approval** (Manager → HR) doesn't exist — only one-stage today | §4.2 |
| 4 | `LeaveRequest` schema missing `managerId`, `managerActionAt`, `managerRejectionReason`, `hrId`, `hrActionAt`, `hrRejectionReason` | §4.2 / §5.3 |
| 5 | `status` enum missing `PendingHR`, `RejectedByManager`, `RejectedByHR` | §4.2 |
| 6 | **Rejection reason min 10 chars** not validated | §4.3 |
| 7 | **Employee leave request history** with full actor/timestamp/reason visibility | §4.4 |
| 8 | `ShortLeave` model missing `permitType` (LATE_ARRIVAL / EARLY_DEPARTURE / TEMPORARY_EXIT) | §3.2 / §5.2 |
| 9 | `ShortLeave` missing `durationMinutes`, `expectedWindowStart`, `expectedWindowEnd` | §5.2 |
| 10 | **Attendance reconciliation** — linking approved permit to attendance record | §3.3 |
| 11 | Flutter: Leave request card doesn't show manager/HR action details | §4.4 |
| 12 | Flutter: No 2-stage status display (PendingHR, RejectedByManager, etc.) | §4.2 |
| 13 | Flutter: Permit request form missing type selection | §3.2 |
| 14 | Flutter: Supervisor leave approve screen only has one-stage approve | §4.2 |

---

## Phases

---

## 🔵 Phase 1 — Database Schema Migration (Backend)
**Estimated effort:** Small  
**Risk:** Migration required — must be backward compatible

### 1.1 Extend `LeaveRequest` table
Add two-stage approval columns to `leave_requests`:

```prisma
model LeaveRequest {
  // ... existing fields ...
  
  // Stage 1 — Line Manager
  managerId               String?
  managerActionAt         DateTime?
  managerRejectionReason  String?

  // Stage 2 — HR
  hrId                    String?
  hrActionAt              DateTime?
  hrRejectionReason       String?
}
```

### 1.2 Extend `ApprovalStatus` enum
```prisma
enum ApprovalStatus {
  Pending           // waiting for manager
  PendingHR         // manager approved, waiting for HR
  Approved          // HR approved (final)
  RejectedByManager // manager rejected
  RejectedByHR      // HR rejected
  Cancelled
}
```

### 1.3 Extend `ShortLeave` (Permit) table
Add permit type and time window:

```prisma
enum PermitType {
  LateArrival
  EarlyDeparture
  TemporaryExit
}

model ShortLeave {
  // ... existing fields ...
  permitType            PermitType    @default(LateArrival)
  durationMinutes       Int?
  expectedWindowStart   String?       // HH:mm
  expectedWindowEnd     String?       // HH:mm
}
```

### 1.4 Mark `isCasualLeave` on `LeaveType`
```prisma
model LeaveType {
  // ... existing fields ...
  isCasual  Boolean  @default(false)
}
```

**Files to change (Backend):**
- `apps/api/prisma/schema.prisma`
- Run: `npx prisma migrate dev --name two_stage_leave_approval`

---

## 🔵 Phase 2 — Backend: Leave Request Business Logic
**Estimated effort:** Medium  
**Depends on:** Phase 1

### 2.1 48-hour advance notice enforcement
In `PATCH /leave-requests` (submit), **before** creating the record:

```typescript
// Enforce 48-hour rule unless leave type is isCasual
const hoursDiff = (start.getTime() - Date.now()) / 3_600_000;
if (!type.isCasual && hoursDiff < 48) {
  throw new BadRequestError(
    'Leave must be requested at least 48 hours in advance',
    'ERR_LEAVE_SUBMISSION_WINDOW_VIOLATION'
  );
}
```

### 2.2 Two-stage approval: Manager → HR
Replace single `PATCH /leave-requests/:id/status` with proper two-stage logic:

```
PATCH /leave-requests/:id/status
  body: { action: 'ApproveManager' | 'RejectManager' | 'ApproveHR' | 'RejectHR', reason?: string }
```

State machine:
- `Pending` + `ApproveManager` → `PendingHR` (sets `managerId`, `managerActionAt`)
- `Pending` + `RejectManager` → `RejectedByManager` (requires `reason`, min 10 chars)
- `PendingHR` + `ApproveHR` → `Approved` (sets `hrId`, `hrActionAt`, deducts balance)
- `PendingHR` + `RejectHR` → `RejectedByHR` (requires `reason`, min 10 chars)

### 2.3 Role-based action gating
- Only users with `LEAVE_APPROVE` permission who are the employee's direct manager can do `ApproveManager` / `RejectManager`
- Only users with `LEAVE_APPROVE` + HR role/flag can do `ApproveHR` / `RejectHR`
- Self-approval remains blocked

### 2.4 Rejection reason validation
```typescript
if (body.reason && body.reason.trim().length < 10) {
  throw new BadRequestError('Rejection reason must be at least 10 characters');
}
if (['RejectManager', 'RejectHR'].includes(body.action) && !body.reason) {
  throw new BadRequestError('Rejection reason is required');
}
```

### 2.5 Employee leave list — expose full audit trail
`GET /leave-requests` response must include:
- `managerId`, `managerActionAt`, `managerRejectionReason`, `managerName`
- `hrId`, `hrActionAt`, `hrRejectionReason`, `hrName`

**Files to change (Backend):**
- `apps/api/src/modules/workforce/leave.routes.ts`

---

## 🔵 Phase 3 — Backend: Permit (ShortLeave) Enhancements
**Estimated effort:** Small-Medium  
**Depends on:** Phase 1

### 3.1 Permit type selection
Update `POST /permissions/request` (v1 compat) and any v2 endpoint to accept:
```typescript
permitType: z.enum(['LateArrival', 'EarlyDeparture', 'TemporaryExit'])
durationMinutes: z.number().int().min(1).max(480).optional()
expectedWindowStart: HHMM.optional()
expectedWindowEnd: HHMM.optional()
```

### 3.2 Attendance reconciliation (Phase 3 bonus)
When an admin approves a permit for date X, the backend should:
1. Check if an attendance record exists for that employee on date X
2. If yes, attach `permitId` to that `attendance_record`
3. Recalculate the attendance status (LATE → LATE_JUSTIFIED if covered by permit window)

**Files to change (Backend):**
- `apps/api/src/modules/compat/v1.routes.ts` (short leave endpoints)
- `apps/api/src/modules/attendance/attendance.service.ts` (reconciliation logic)

---

## 🔴 Phase 4 — Flutter: Leave Model & Cubit Update
**Estimated effort:** Medium  
**Depends on:** Phase 2

### 4.1 Update `LeaveRequestModel`
Add new fields:
```dart
@freezed
class LeaveRequestModel with _$LeaveRequestModel {
  const factory LeaveRequestModel({
    required String id,
    required String leaveTypeId,
    required String employeeId,
    required DateTime startDate,
    required DateTime endDate,
    required int totalDays,
    required String status,       // now includes PendingHR, RejectedByManager, etc.
    String? reason,
    String? attachmentUrl,
    DateTime? createdAt,
    // NEW — Stage 1
    String? managerId,
    String? managerName,
    DateTime? managerActionAt,
    String? managerRejectionReason,
    // NEW — Stage 2
    String? hrId,
    String? hrName,
    DateTime? hrActionAt,
    String? hrRejectionReason,
  }) = _LeaveRequestModel;
}
```

### 4.2 Update `LeaveRequestBody`
No changes needed — submission body stays the same.

### 4.3 Update `LeavesApiService`
No new endpoints needed. Response model changes handle everything.

### 4.4 Update `LeavesCubit`
- Add `loadMyLeaveRequests()` method to show history with audit trail
- Add `cancelLeave(String id)` method

**Files to change (Flutter):**
- `lib/features/leaves/data/models/leave_request_model.dart`
- `lib/features/leaves/presentation/cubit/leaves_cubit.dart`
- `lib/features/leaves/presentation/cubit/leaves_state.dart`
- Run `build_runner`

---

## 🔴 Phase 5 — Flutter: Supervisor/Admin Leave Approval UI
**Estimated effort:** Medium  
**Depends on:** Phase 4

### 5.1 Supervisor leave approval screen
Current: one `Approve` / `Reject` action.  
New: Show current stage clearly. Supervisor can only do **Stage 1** (Manager action).

- Show badge: `Pending Manager Review` / `Pending HR Review`
- Reject dialog: **mandatory** reason field (min 10 chars enforced in UI too)
- Action button changes based on status:
  - Status `Pending` → show `Approve (as Manager)` + `Reject`
  - Status `PendingHR` → show `Approve (as HR)` + `Reject` (only for HR role)

**Files to change (Flutter):**
- `lib/features/supervisor/presentation/cubit/leave_requests/supervisor_leave_requests_cubit.dart`
- `lib/features/supervisor/presentation/screens/` (leave approval screen)
- `lib/features/admin/presentation/cubit/leave_requests/admin_leave_requests_cubit.dart`

### 5.2 Employee leave history card
Each leave card must show:
- Status chip with proper color per stage
- Manager's name + timestamp + reason (if rejected)
- HR's name + timestamp + reason (if rejected)
- Timeline-style UI for the full audit trail

**Files to change (Flutter):**
- `lib/features/leaves/presentation/screens/leaves_dashboard_screen.dart`
- New widget: `lib/features/leaves/presentation/widgets/leave_request_card_widget.dart`
- New widget: `lib/features/leaves/presentation/widgets/leave_approval_timeline_widget.dart`

---

## 🔴 Phase 6 — Flutter: Permit (إذن) Form Enhancement
**Estimated effort:** Small  
**Depends on:** Phase 3

### 6.1 Update `ShortLeaveRequestBody`
```dart
@freezed
class ShortLeaveRequestBody with _$ShortLeaveRequestBody {
  const factory ShortLeaveRequestBody({
    required String permitType,   // LateArrival | EarlyDeparture | TemporaryExit
    required DateTime date,
    required String startTime,    // HH:mm
    required String endTime,      // HH:mm
    required double totalHours,
    int? durationMinutes,
    String? reason,
  }) = _ShortLeaveRequestBody;
}
```

### 6.2 Update permit request screen
- Add permit type selector (3 options with Arabic labels)
- Update time window fields to reflect selected type
- Arabic translations for all new keys

**Files to change (Flutter):**
- `lib/features/leaves/data/models/short_leave_request_body.dart`
- `lib/features/leaves/data/models/short_leave_model.dart`
- `lib/features/leaves/presentation/screens/request_permission_screen.dart`
- `assets/translations/ar.json` + `en.json`
- Run `build_runner`

---

## 🟡 Phase 7 — Translation Keys
**Estimated effort:** Small  
**Parallel with Phases 4-6**

New keys needed in `ar.json` + `en.json`:

```json
{
  "leaves": {
    "status": {
      "pending": "في انتظار الموافقة",
      "pendingHR": "في انتظار موافقة الموارد البشرية",
      "approved": "معتمد",
      "rejectedByManager": "مرفوض من المدير",
      "rejectedByHR": "مرفوض من الموارد البشرية",
      "cancelled": "ملغى"
    },
    "rejection": {
      "managerRejected": "رُفض من المدير",
      "hrRejected": "رُفض من الموارد البشرية",
      "reason": "سبب الرفض",
      "reasonHint": "اكتب سبب الرفض (10 أحرف على الأقل)",
      "reasonRequired": "سبب الرفض إلزامي"
    },
    "approval": {
      "approveAsManager": "اعتماد (كمدير)",
      "approveAsHR": "اعتماد (كموارد بشرية)",
      "stage1": "المرحلة 1: موافقة المدير",
      "stage2": "المرحلة 2: موافقة الموارد البشرية"
    },
    "errors": {
      "48hourRule": "يجب تقديم الطلب قبل 48 ساعة على الأقل من تاريخ الإجازة"
    }
  },
  "permits": {
    "type": {
      "lateArrival": "إذن تأخير",
      "earlyDeparture": "إذن انصراف مبكر",
      "temporaryExit": "إذن خروج مؤقت"
    }
  }
}
```

---

## Execution Order

```
Phase 1 (DB Schema)
    ↓
Phase 2 (Backend Leave Logic) ─── Phase 3 (Backend Permits)
    ↓
Phase 4 (Flutter Models)
    ↓
Phase 5 (Flutter Approval UI) ─── Phase 6 (Flutter Permits)
    ↓
Phase 7 (Translations) ← can start in parallel with Phase 4
```

---

## Notes & Risks

> [!IMPORTANT]
> Phase 1 requires a **Prisma migration** on the live DB. Must be run on the server after deploying Phase 1 code. Existing `Pending`/`Approved`/`Rejected` data will keep working — the new columns are nullable.

> [!WARNING]
> The `ApprovalStatus` enum change is **breaking** for any existing Flutter code that pattern-matches on status strings. Phase 4 must handle all old and new statuses gracefully.

> [!NOTE]
> The v1 compat routes (`/api/v1/leaves/*`) are used by the Flutter app today. We will update those routes to support the new fields while keeping backward compatibility.

> [!TIP]
> Phases 2 and 3 can be deployed independently. The Flutter app will continue to work with single-stage approval until Phase 4-5 are shipped.
