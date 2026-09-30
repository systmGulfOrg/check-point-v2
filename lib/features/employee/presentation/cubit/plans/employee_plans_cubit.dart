import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:check_point_v2/core/auth/auth_session_storage.dart';
import 'package:check_point_v2/core/network/api_result.dart';
import 'package:check_point_v2/features/employee/data/models/plans/employee_plan_feedback_request_body.dart';
import 'package:check_point_v2/features/employee/data/models/plans/employee_remove_plan_request_body.dart';
import 'package:check_point_v2/features/admin/data/models/plans/admin_plan_model.dart';
import 'package:check_point_v2/features/employee/data/repos/employee_attendance_repo.dart';
import 'employee_plans_state.dart';

class EmployeePlansCubit extends Cubit<EmployeePlansState> {
  EmployeePlansCubit({
    required this.attendanceRepo,
    required this.sessionStorage,
  }) : super(const EmployeePlansState.initial());

  final EmployeeAttendanceRepo attendanceRepo;
  final AuthSessionStorage sessionStorage;

  List<AdminPlanModel> myPlans = const [];

  Future<void> loadMyPlans() async {
    emit(const EmployeePlansState.loading());
    final employeeId = await sessionStorage.readEmployeeId() ?? '';
    final result = await attendanceRepo.getCustomerPlansForEmployee(employeeId);
    switch (result) {
      case Success(:final data):
        myPlans = data;
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
        emit(
          const EmployeePlansState.actionSuccess(
            'Plan feedback added successfully',
          ),
        );
      case Failure(:final failure):
        emit(EmployeePlansState.error(failure.messageKey));
    }
  }

  Future<bool> createPlan({
    required String title,
    required String description,
    required String startDate,
    required String endDate,
  }) async {
    final employeeId = await sessionStorage.readEmployeeId() ?? '';
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
        emit(EmployeePlansState.error(failure.messageKey));
        return false;
      },
    );
  }

  Future<void> removeAssignCustomerPlan(int customerPlanId) async {
    emit(const EmployeePlansState.loading());
    final employeeId = await sessionStorage.readEmployeeId() ?? '';
    final requestBody = EmployeeRemovePlanRequestBody(
      customerPlanId: customerPlanId,
      employeeId: employeeId,
    );
    final result = await attendanceRepo.removeAssignCustomerPlan(requestBody);
    switch (result) {
      case Success():
        await loadMyPlans();
        emit(
          const EmployeePlansState.actionSuccess('Plan removed successfully'),
        );
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
