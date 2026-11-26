import '../routes/routes.dart';

class PushRouteResolver {
  const PushRouteResolver._();

  static String? resolve(
    String? type, [
    Map<String, dynamic>? data,
    String? key,
    bool isAdmin = false,
  ]) {
    final effectiveType = _resolveEffectiveType(type, data, key);
    final isApproval =
        data?['target'] == 'approval' || data?['recipientRole'] == 'approver';

    switch (effectiveType) {
      case 'leave.submitted':
      case 'leave.admin_objection':
        return isApproval
            ? AppRoutes.supervisorLeaveManagement
            : AppRoutes.leavesDashboard;

      case 'leave.approvemanager':
      case 'leave.rejectmanager':
      case 'leave.approvehr':
      case 'leave.rejecthr':
      case 'leave.cancelled':
      case 'leave.revoked':
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

      case 'permit.hr_info_approved':
      case 'permit.hr_info_rejected':
      case 'permit.created_no_manager':
        return isApproval
            ? AppRoutes.adminLeaveManagement
            : AppRoutes.permissionsRequest;

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
        return AppRoutes.supervisorAttendance;

      case 'attendance.team_checkin':
        return isAdmin
            ? AppRoutes.adminAttendance
            : AppRoutes.supervisorAttendance;

      case 'attendance.offline_pending':
        return AppRoutes.pendingAttendanceVerification;

      case 'attendance.offline_approved':
      case 'attendance.offline_rejected':
        return AppRoutes.employeeRecord;

      case 'device.pending':
        return AppRoutes.adminPendingDevices;

      case 'accountRequest.created':
        return AppRoutes.admin;

      case 'employee.account_deleted':
        return AppRoutes.adminDeletedEmployees;

      case 'points.red':
      case 'points.black':
      case 'points.green_pending':
      case 'gamification.rank_first':
        return AppRoutes.myPoints;

      case 'disciplinary.violation_logged':
      case 'disciplinary.appeal_status':
        return AppRoutes.disciplinaryDeductions;

      default:
        return null;
    }
  }

  static String? _resolveEffectiveType(
    String? type,
    Map<String, dynamic>? data,
    String? key,
  ) {
    if (type != null && type.trim().isNotEmpty) {
      return type.trim();
    }
    final dataType = data?['type'];
    if (dataType is String && dataType.trim().isNotEmpty) {
      return dataType.trim();
    }
    if (key != null && key.startsWith('notifications.')) {
      var trimmed = key.substring('notifications.'.length);
      if (trimmed.endsWith('.title')) {
        trimmed = trimmed.substring(0, trimmed.length - '.title'.length);
      } else if (trimmed.endsWith('.body')) {
        trimmed = trimmed.substring(0, trimmed.length - '.body'.length);
      }
      if (trimmed.isNotEmpty) return trimmed;
    }
    return null;
  }
}
