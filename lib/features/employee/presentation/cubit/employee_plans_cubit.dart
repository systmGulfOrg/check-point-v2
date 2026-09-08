import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/auth/auth_session_storage.dart';
import '../../../../core/network/api_result.dart';
import '../../data/models/employee_plan_feedback_request_body.dart';
import '../../data/models/employee_remove_plan_request_body.dart';
import '../../data/repos/employee_attendance_repo.dart';
import 'employee_plans_state.dart';

class EmployeePlansCubit extends Cubit<EmployeePlansState> {
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
    switch (result) {
      case Success(:final data):
        emit(EmployeePlansState.success(data));
      case Failure(:final failure):
        emit(EmployeePlansState.error(failure.messageKey));
    }
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
    switch (result) {
      case Success():
        await loadMyPlans();
        emit(const EmployeePlansState.actionSuccess('Plan feedback added successfully'));
      case Failure(:final failure):
        emit(EmployeePlansState.error(failure.messageKey));
    }
  }

  Future<void> removeAssignCustomerPlan(int customerPlanId) async {
    emit(const EmployeePlansState.loading());
    final employeeId = await sessionStorage.readUserId() ?? '';
    final requestBody = EmployeeRemovePlanRequestBody(
      customerPlanId: customerPlanId,
      employeeId: employeeId,
    );
    final result = await attendanceRepo.removeAssignCustomerPlan(requestBody);
    switch (result) {
      case Success():
        await loadMyPlans();
        emit(const EmployeePlansState.actionSuccess('Plan removed successfully'));
      case Failure(:final failure):
        emit(EmployeePlansState.error(failure.messageKey));
    }
  }

  Future<void> loadFeedbackStatuses() async {
    final result = await attendanceRepo.getFeedbackStatuses();
    switch (result) {
      case Success(:final data):
        emit(EmployeePlansState.statusesLoaded(data));
      case Failure(:final failure):
        emit(EmployeePlansState.error(failure.messageKey));
    }
  }
}
