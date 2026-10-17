import 'package:check_point_v2/core/bloc/safe_cubit.dart';

import 'package:check_point_v2/core/auth/auth_session_storage.dart';
import 'package:check_point_v2/features/employee/data/models/plans/employee_plan_feedback_request_body.dart';
import 'package:check_point_v2/features/employee/data/models/plans/employee_remove_plan_request_body.dart';
import 'package:check_point_v2/features/admin/data/models/plans/admin_plan_model.dart';
import 'package:check_point_v2/features/employee/data/repos/employee_attendance_repo.dart';
import 'employee_plans_state.dart';

class EmployeePlansCubit extends SafeCubit<EmployeePlansState> {
  EmployeePlansCubit({
    required this.attendanceRepo,
    required this.sessionStorage,
  }) : super(const EmployeePlansState.initial());

  final EmployeeAttendanceRepo attendanceRepo;
  final AuthSessionStorage sessionStorage;

  Future<void> loadMyPlans() async {
    emit(const EmployeePlansState.loading());
    final employeeId = await sessionStorage.readUserId() ?? '';
    final result = await attendanceRepo.getCustomerPlansForEmployee(employeeId);
    result.when(
      success: (data) => safeEmit(EmployeePlansState.success(data)),
      failure: (_) => safeEmit(const EmployeePlansState.success([])),
    );
  }

  Future<void> addPlanFeedback({
    required int customerPlanId,
    required String status,
    String? imageUrl,
    String? notes,
  }) async {
    emit(const EmployeePlansState.loading());
    final requestBody = EmployeePlanFeedbackRequestBody(
      customerPlanId: customerPlanId,
      status: status,
      imageUrl: imageUrl,
      notes: notes,
    );
    final result = await attendanceRepo.addPlanFeedback(requestBody);
    await result.when(
      success: (_) async {
        await loadMyPlans();
        safeEmit(
          const EmployeePlansState.actionSuccess(
            'Plan feedback added successfully',
          ),
        );
      },
      failure: (failure) async =>
          safeEmit(EmployeePlansState.error(failure.messageKey)),
    );
  }

  Future<bool> createPlan({
    required String title,
    required String description,
    required String startDate,
    required String endDate,
  }) async {
    final employeeId = await sessionStorage.readUserId() ?? '';
    final result = await attendanceRepo.createPlan(
      CreatePlanRequestBody(
        title: title,
        description: description,
        startDate: startDate,
        endDate: endDate,
        assignedEmployeeId: employeeId,
      ),
    );
    return result.when(
      success: (_) async {
        await loadMyPlans();
        return true;
      },
      failure: (failure) {
        safeEmit(EmployeePlansState.error(failure.messageKey));
        return false;
      },
    );
  }

  Future<void> removeAssignCustomerPlan(int customerPlanId) async {
    emit(const EmployeePlansState.loading());
    final employeeId = await sessionStorage.readUserId() ?? '';
    final requestBody = EmployeeRemovePlanRequestBody(
      customerPlanId: customerPlanId,
      employeeId: employeeId,
    );
    final result = await attendanceRepo.removeAssignCustomerPlan(requestBody);
    await result.when(
      success: (_) async {
        await loadMyPlans();
        safeEmit(
          const EmployeePlansState.actionSuccess('Plan removed successfully'),
        );
      },
      failure: (failure) async =>
          safeEmit(EmployeePlansState.error(failure.messageKey)),
    );
  }

  Future<void> loadFeedbackStatuses() async {
    final result = await attendanceRepo.getFeedbackStatuses();
    result.when(
      success: (data) => safeEmit(EmployeePlansState.statusesLoaded(data)),
      failure: (failure) =>
          safeEmit(EmployeePlansState.error(failure.messageKey)),
    );
  }
}
