import '../routes/routes.dart';

/// Maps a push notification's `type` (the backend's NOTIFICATION_TYPES key,
/// e.g. "leave.submitted") to a route to open on tap.
///
/// The backend's `data.route` field is never navigated to directly — only
/// `type` is trusted, through this allow-list. A server-supplied route
/// string reaching `Navigator.pushNamed` unchecked would let a compromised
/// or buggy backend open any screen in the app; mapping through a fixed
/// switch keeps the set of reachable screens equal to what this file lists,
/// no matter what the payload contains (AGENTS §17: never trust external
/// input as a security boundary without validating it client-side too).
///
/// Returns null for an unknown type, so the caller can simply not navigate
/// rather than guess.
class PushRouteResolver {
  const PushRouteResolver._();

  static String? resolve(String? type) {
    switch (type) {
      case 'leave.submitted':
      case 'leave.approvemanager':
      case 'leave.rejectmanager':
      case 'leave.approvehr':
      case 'leave.rejecthr':
      case 'leave.cancelled':
      case 'leave.pendinghr':
        return AppRoutes.leavesDashboard;

      case 'permit.created':
      case 'permit.manager_approved':
      case 'permit.approved':
      case 'permit.rejected':
        return AppRoutes.permissionsRequest;

      case 'overtime.approved':
      case 'overtime.rejected':
        return AppRoutes.overtime;

      case 'remote.approved':
      case 'remote.rejected':
        return AppRoutes.remoteWork;

      case 'attendanceCorrection.approved':
      case 'attendanceCorrection.rejected':
        return AppRoutes.supervisorAttendance;

      default:
        return null;
    }
  }
}
