import 'package:check_point_v2/core/routes/routes.dart';
import 'package:check_point_v2/core/routing/push_route_resolver.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('PushRouteResolver', () {
    test('resolves leave types to leavesDashboard', () {
      expect(
        PushRouteResolver.resolve('leave.submitted'),
        AppRoutes.leavesDashboard,
      );
      expect(
        PushRouteResolver.resolve('leave.approvemanager'),
        AppRoutes.leavesDashboard,
      );
      expect(
        PushRouteResolver.resolve('leave.rejectmanager'),
        AppRoutes.leavesDashboard,
      );
      expect(
        PushRouteResolver.resolve('leave.approvehr'),
        AppRoutes.leavesDashboard,
      );
      expect(
        PushRouteResolver.resolve('leave.rejecthr'),
        AppRoutes.leavesDashboard,
      );
      expect(
        PushRouteResolver.resolve('leave.cancelled'),
        AppRoutes.leavesDashboard,
      );
      expect(
        PushRouteResolver.resolve('leave.pendinghr'),
        AppRoutes.leavesDashboard,
      );
    });

    test('resolves permit types to permissionsRequest', () {
      expect(
        PushRouteResolver.resolve('permit.created'),
        AppRoutes.permissionsRequest,
      );
      expect(
        PushRouteResolver.resolve('permit.manager_approved'),
        AppRoutes.permissionsRequest,
      );
      expect(
        PushRouteResolver.resolve('permit.approved'),
        AppRoutes.permissionsRequest,
      );
      expect(
        PushRouteResolver.resolve('permit.rejected'),
        AppRoutes.permissionsRequest,
      );
    });

    test('resolves overtime types to overtime', () {
      expect(
        PushRouteResolver.resolve('overtime.approved'),
        AppRoutes.overtime,
      );
      expect(
        PushRouteResolver.resolve('overtime.rejected'),
        AppRoutes.overtime,
      );
    });

    test('resolves remote work types to remoteWork', () {
      expect(
        PushRouteResolver.resolve('remote.approved'),
        AppRoutes.remoteWork,
      );
      expect(
        PushRouteResolver.resolve('remote.rejected'),
        AppRoutes.remoteWork,
      );
    });

    test('resolves attendance correction types to supervisorAttendance', () {
      expect(
        PushRouteResolver.resolve('attendanceCorrection.approved'),
        AppRoutes.supervisorAttendance,
      );
      expect(
        PushRouteResolver.resolve('attendanceCorrection.rejected'),
        AppRoutes.supervisorAttendance,
      );
    });

    test('resolves team checkin based on admin vs supervisor role', () {
      expect(
        PushRouteResolver.resolve('attendance.team_checkin'),
        AppRoutes.supervisorAttendance,
      );
      expect(
        PushRouteResolver.resolve('attendance.team_checkin', null, null, true),
        AppRoutes.adminAttendance,
      );
    });

    test('falls back to notification i18n key when type is null', () {
      expect(
        PushRouteResolver.resolve(
          null,
          null,
          'notifications.remote.created.title',
        ),
        AppRoutes.remoteWork,
      );
      expect(
        PushRouteResolver.resolve(
          null,
          const {'target': 'approval'},
          'notifications.leave.submitted.title',
        ),
        AppRoutes.supervisorLeaveManagement,
      );
    });

    test('resolves device, offline, points, and disciplinary types', () {
      expect(
        PushRouteResolver.resolve('device.pending'),
        AppRoutes.adminPendingDevices,
      );
      expect(
        PushRouteResolver.resolve('attendance.offline_pending'),
        AppRoutes.pendingAttendanceVerification,
      );
      expect(
        PushRouteResolver.resolve('points.red'),
        AppRoutes.myPoints,
      );
      expect(
        PushRouteResolver.resolve('disciplinary.violation_logged'),
        AppRoutes.disciplinaryDeductions,
      );
    });

    test('returns null for unknown types', () {
      expect(PushRouteResolver.resolve(null), isNull);
      expect(PushRouteResolver.resolve('unknown.type'), isNull);
      expect(PushRouteResolver.resolve('/admin/hack'), isNull);
    });
  });
}
