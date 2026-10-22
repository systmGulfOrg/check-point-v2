import '../routes/routes.dart';

class PushRouteResolver {
  const PushRouteResolver._();

  static String? resolve(String? type, [Map<String, dynamic>? data]) {
    final isApproval = data?['target'] == 'approval' ||
        data?['recipientRole'] == 'approver';

    switch (type) {
      case 'leave.submitted':
        return isApproval
            ? AppRoutes.supervisorLeaveManagement
            : AppRoutes.leavesDashboard;

      case 'leave.approvemanager':
      case 'leave.rejectmanager':
      case 'leave.approvehr':
      case 'leave.rejecthr':
      case 'leave.cancelled':
        return AppRoutes.leavesDashboard;

      case 'leave.pendinghr':
        return isApproval
            ? AppRoutes.adminLeaveManagement
            : AppRoutes.leavesDashboard;

      case 'permit.created':
        return isApproval
            ? AppRoutes.supervisorPlans
            : AppRoutes.permissionsRequest;

      case 'permit.manager_approved':
      case 'permit.approved':
      case 'permit.rejected':
        return AppRoutes.permissionsRequest;

      case 'overtime.created':
      case 'overtime.approved':
      case 'overtime.rejected':
        return AppRoutes.overtime;

      case 'remote.created':
      case 'remote.approved':
      case 'remote.rejected':
        return AppRoutes.remoteWork;

      case 'attendanceCorrection.created':
      case 'attendanceCorrection.approved':
      case 'attendanceCorrection.rejected':
      case 'attendance.team_checkin':
        return AppRoutes.supervisorAttendance;

      default:
        return null;
    }
  }
}
