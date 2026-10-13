class AppPermissions {
  AppPermissions._();

  static const attendanceViewOwn = 'attendance.view_own';
  static const attendanceViewTeam = 'attendance.view_team';
  static const attendanceViewAll = 'attendance.view_all';
  static const attendanceEdit = 'attendance.edit';
  static const attendanceDelete = 'attendance.delete';
  static const attendanceApproveCorrection = 'attendance.approve_correction';
  static const employeeView = 'employee.view';
  static const employeeCreate = 'employee.create';
  static const employeeEdit = 'employee.edit';
  static const employeeDelete = 'employee.delete';
  static const employeeManageTeam = 'employee.manage_team';
  static const employeeApproveDevice = 'employee.approve_device';
  static const accountRequestView = 'account_request.view';
  static const accountRequestApprove = 'account_request.approve';
  static const remoteRequest = 'remote.request';
  static const remoteApprove = 'remote.approve';
  static const remotePolicyManage = 'remote.policy_manage';
  static const overtimeRequest = 'overtime.request';
  static const overtimeApprove = 'overtime.approve';
  static const leaveRequest = 'leave.request';
  static const leaveApprove = 'leave.approve';
  static const leaveManagerApprove = 'leave.manager_approve';
  static const leaveHrApprove = 'leave.hr_approve';
  static const leaveTypeManage = 'leave.type_manage';
  static const permitApprove = 'permit.approve';
  static const taskView = 'task.view';
  static const taskAssign = 'task.assign';
  static const taskManage = 'task.manage';
  static const planManage = 'plan.manage';
  static const orgManageBranch = 'org.manage_branch';
  static const orgManageDepartment = 'org.manage_department';
  static const orgManageShift = 'org.manage_shift';
  static const orgManagePolicy = 'org.manage_policy';
  static const customerManage = 'customer.manage';
  static const assetManage = 'asset.manage';
  static const reportView = 'report.view';
  static const reportExport = 'report.export';
  static const locationMonitor = 'location.monitor';
  static const tenantSettings = 'tenant.settings';
  static const tenantUserManage = 'tenant.user_manage';
  static const auditView = 'audit.view';

  static bool has(Iterable<String> permissions, String permission) =>
      permissions.any(
        (item) => item.trim().toLowerCase() == permission.trim().toLowerCase(),
      );

  static List<String> defaultsForRole(String role) {
    switch (role.trim().toLowerCase()) {
      case 'admin':
      case 'hr':
        return [
          attendanceViewOwn,
          attendanceViewTeam,
          attendanceViewAll,
          attendanceEdit,
          attendanceDelete,
          employeeView,
          employeeEdit,
          employeeDelete,
          taskView,
          taskAssign,
          taskManage,
          remoteRequest,
          remoteApprove,
          remotePolicyManage,
          overtimeRequest,
          overtimeApprove,
          leaveRequest,
          leaveApprove,
          leaveManagerApprove,
          leaveHrApprove,
          permitApprove,
          planManage,
        ];
      case 'supervisor':
        return [
          attendanceViewOwn,
          attendanceViewTeam,
          employeeView,
          taskView,
          taskAssign,
          leaveRequest,
          leaveManagerApprove,
          permitApprove,
          remoteRequest,
          remoteApprove,
          overtimeRequest,
          overtimeApprove,
          reportView,
        ];
      default:
        return [
          attendanceViewOwn,
          taskView,
          leaveRequest,
          remoteRequest,
          overtimeRequest,
        ];
    }
  }
}
