import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:check_point_v2/core/network/api_result.dart';
import 'package:check_point_v2/features/admin/data/models/shifts_policies/police_model.dart';
import 'package:check_point_v2/features/admin/data/models/shifts_policies/shift_model.dart';
import 'package:check_point_v2/features/admin/data/repos/admin_shifts_policies_repo.dart';
import 'admin_shifts_policies_state.dart';

class AdminShiftsPoliciesCubit extends Cubit<AdminShiftsPoliciesState> {
  AdminShiftsPoliciesCubit({required this.shiftsPoliciesRepo})
    : super(const AdminShiftsPoliciesState.initial());

  final AdminShiftsPoliciesRepo shiftsPoliciesRepo;
  List<ShiftModel> shifts = const [];
  List<PoliceModel> policies = const [];

  Future<void> load({int? shiftId}) async {
    emit(const AdminShiftsPoliciesState.loading());
    final result = await shiftsPoliciesRepo.getShifts();
    switch (result) {
      case Success(:final data):
        shifts = data;
        final selectedShiftId =
            shiftId ?? (shifts.isNotEmpty ? shifts.first.id : null);
        if (selectedShiftId != null) {
          await loadPoliciesForShift(selectedShiftId);
        } else {
          emit(
            AdminShiftsPoliciesState.success(
              shifts: shifts,
              policies: const [],
            ),
          );
        }
      case Failure(:final failure):
        emit(AdminShiftsPoliciesState.error(failure.messageKey));
    }
  }

  Future<void> loadPoliciesForShift(int shiftId) async {
    final result = await shiftsPoliciesRepo.getPoliciesByShift(
      shiftId: shiftId,
    );
    switch (result) {
      case Success(:final data):
        policies = data;
        emit(
          AdminShiftsPoliciesState.success(shifts: shifts, policies: policies),
        );
      case Failure(:final failure):
        emit(AdminShiftsPoliciesState.error(failure.messageKey));
    }
  }

  Future<bool> addShift(AddShiftRequestBody body) async {
    emit(const AdminShiftsPoliciesState.loading());
    final result = await shiftsPoliciesRepo.addShift(body);
    switch (result) {
      case Success():
        await load();
        emit(
          const AdminShiftsPoliciesState.actionSuccess(
            'Shift added successfully',
          ),
        );
        return true;
      case Failure(:final failure):
        emit(AdminShiftsPoliciesState.error(failure.messageKey));
        return false;
      default:
        return false;
    }
  }

  Future<bool> editShift(int id, AddShiftRequestBody body) async {
    emit(const AdminShiftsPoliciesState.loading());
    final result = await shiftsPoliciesRepo.editShift(id: id, body: body);
    switch (result) {
      case Success():
        await load();
        emit(
          const AdminShiftsPoliciesState.actionSuccess(
            'Shift updated successfully',
          ),
        );
        return true;
      case Failure(:final failure):
        emit(AdminShiftsPoliciesState.error(failure.messageKey));
        return false;
      default:
        return false;
    }
  }

  Future<bool> deleteShift(int id) async {
    emit(const AdminShiftsPoliciesState.loading());
    final result = await shiftsPoliciesRepo.deleteShift(id: id);
    switch (result) {
      case Success():
        await load();
        emit(
          const AdminShiftsPoliciesState.actionSuccess(
            'Shift deleted successfully',
          ),
        );
        return true;
      case Failure(:final failure):
        emit(AdminShiftsPoliciesState.error(failure.messageKey));
        return false;
      default:
        return false;
    }
  }

  Future<bool> addPolicy(AddPoliceRequestBody body) async {
    emit(const AdminShiftsPoliciesState.loading());
    final result = await shiftsPoliciesRepo.addPolicy(body);
    switch (result) {
      case Success():
        await loadPoliciesForShift(body.shiftId);
        emit(
          const AdminShiftsPoliciesState.actionSuccess(
            'Policy added successfully',
          ),
        );
        return true;
      case Failure(:final failure):
        emit(AdminShiftsPoliciesState.error(failure.messageKey));
        return false;
      default:
        return false;
    }
  }

  Future<bool> assignEmployees({
    required int policyId,
    required int shiftId,
    required List<String> employeeIds,
  }) async {
    emit(const AdminShiftsPoliciesState.loading());
    final result = await shiftsPoliciesRepo.assignPolicy(
      AssignPoliceRequestBody(policyId: policyId, employeeIds: employeeIds),
    );
    switch (result) {
      case Success():
        await loadPoliciesForShift(shiftId);
        return true;
      case Failure(:final failure):
        emit(AdminShiftsPoliciesState.error(failure.messageKey));
        return false;
      default:
        return false;
    }
  }

  Future<bool> transferEmployee({
    required int policyId,
    required int shiftId,
    required String employeeId,
  }) async {
    emit(const AdminShiftsPoliciesState.loading());
    final removeResult = await shiftsPoliciesRepo.removeAssignPolicy(
      RemoveAssignPolicyRequestBody(employeeId: employeeId),
    );
    if (removeResult case Failure(:final failure)) {
      emit(AdminShiftsPoliciesState.error(failure.messageKey));
      return false;
    }
    final assignResult = await shiftsPoliciesRepo.assignPolicy(
      AssignPoliceRequestBody(policyId: policyId, employeeIds: [employeeId]),
    );
    switch (assignResult) {
      case Success():
        await loadPoliciesForShift(shiftId);
        return true;
      case Failure(:final failure):
        emit(AdminShiftsPoliciesState.error(failure.messageKey));
        return false;
      default:
        return false;
    }
  }

  Future<bool> deletePolicy(int id, int shiftId) async {
    emit(const AdminShiftsPoliciesState.loading());
    final result = await shiftsPoliciesRepo.deletePolicy(id: id);
    switch (result) {
      case Success():
        await loadPoliciesForShift(shiftId);
        emit(
          const AdminShiftsPoliciesState.actionSuccess(
            'Policy deleted successfully',
          ),
        );
        return true;
      case Failure(:final failure):
        emit(AdminShiftsPoliciesState.error(failure.messageKey));
        return false;
      default:
        return false;
    }
  }
}
