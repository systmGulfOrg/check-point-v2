import 'package:check_point_v2/core/bloc/safe_cubit.dart';

import 'package:check_point_v2/features/admin/data/models/shifts_policies/police_model.dart';
import 'package:check_point_v2/features/admin/data/models/shifts_policies/shift_model.dart';
import 'package:check_point_v2/features/admin/data/repos/admin_shifts_policies_repo.dart';
import 'admin_shifts_policies_state.dart';

class AdminShiftsPoliciesCubit extends SafeCubit<AdminShiftsPoliciesState> {
  AdminShiftsPoliciesCubit({required this.shiftsPoliciesRepo})
    : super(const AdminShiftsPoliciesState.initial());

  final AdminShiftsPoliciesRepo shiftsPoliciesRepo;
  List<ShiftModel> shifts = const [];
  List<PoliceModel> policies = const [];

  Future<void> load({int? shiftId}) async {
    emit(const AdminShiftsPoliciesState.loading());
    final result = await shiftsPoliciesRepo.getShifts();
    await result.when(
      success: (data) async {
        shifts = data;
        final selectedShiftId =
            shiftId ?? (shifts.isNotEmpty ? shifts.first.id : null);
        if (selectedShiftId != null) {
          await loadPoliciesForShift(selectedShiftId);
        } else {
          safeEmit(
            AdminShiftsPoliciesState.success(
              shifts: shifts,
              policies: const [],
            ),
          );
        }
      },
      failure: (failure) async =>
          safeEmit(AdminShiftsPoliciesState.error(failure.messageKey)),
    );
  }

  Future<void> loadPoliciesForShift(int shiftId) async {
    final result = await shiftsPoliciesRepo.getPoliciesByShift(
      shiftId: shiftId,
    );
    result.when(
      success: (data) {
        policies = data;
        safeEmit(
          AdminShiftsPoliciesState.success(shifts: shifts, policies: policies),
        );
      },
      failure: (failure) =>
          safeEmit(AdminShiftsPoliciesState.error(failure.messageKey)),
    );
  }

  Future<bool> addShift(AddShiftRequestBody body) async {
    emit(const AdminShiftsPoliciesState.loading());
    final result = await shiftsPoliciesRepo.addShift(body);
    return result.when(
      success: (_) async {
        await load();
        return true;
      },
      failure: (failure) {
        safeEmit(AdminShiftsPoliciesState.error(failure.messageKey));
        return false;
      },
    );
  }

  Future<bool> editShift(int id, AddShiftRequestBody body) async {
    emit(const AdminShiftsPoliciesState.loading());
    final result = await shiftsPoliciesRepo.editShift(id: id, body: body);
    return result.when(
      success: (_) async {
        await load();
        return true;
      },
      failure: (failure) {
        safeEmit(AdminShiftsPoliciesState.error(failure.messageKey));
        return false;
      },
    );
  }

  Future<bool> deleteShift(int id) async {
    emit(const AdminShiftsPoliciesState.loading());
    final result = await shiftsPoliciesRepo.deleteShift(id: id);
    return result.when(
      success: (_) async {
        await load();
        return true;
      },
      failure: (failure) {
        safeEmit(AdminShiftsPoliciesState.error(failure.messageKey));
        return false;
      },
    );
  }

  Future<bool> addPolicy(AddPoliceRequestBody body) async {
    emit(const AdminShiftsPoliciesState.loading());
    final result = await shiftsPoliciesRepo.addPolicy(body);
    return result.when(
      success: (_) async {
        await loadPoliciesForShift(body.shiftId);
        return true;
      },
      failure: (failure) {
        safeEmit(AdminShiftsPoliciesState.error(failure.messageKey));
        return false;
      },
    );
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
    return result.when(
      success: (_) async {
        await loadPoliciesForShift(shiftId);
        return true;
      },
      failure: (failure) {
        safeEmit(AdminShiftsPoliciesState.error(failure.messageKey));
        return false;
      },
    );
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
    final removeSucceeded = removeResult.when(
      success: (_) => true,
      failure: (failure) {
        safeEmit(AdminShiftsPoliciesState.error(failure.messageKey));
        return false;
      },
    );
    if (!removeSucceeded) return false;

    final assignResult = await shiftsPoliciesRepo.assignPolicy(
      AssignPoliceRequestBody(policyId: policyId, employeeIds: [employeeId]),
    );
    return assignResult.when(
      success: (_) async {
        await loadPoliciesForShift(shiftId);
        return true;
      },
      failure: (failure) {
        safeEmit(AdminShiftsPoliciesState.error(failure.messageKey));
        return false;
      },
    );
  }

  Future<bool> deletePolicy(int id, int shiftId) async {
    emit(const AdminShiftsPoliciesState.loading());
    final result = await shiftsPoliciesRepo.deletePolicy(id: id);
    return result.when(
      success: (_) async {
        await loadPoliciesForShift(shiftId);
        return true;
      },
      failure: (failure) {
        safeEmit(AdminShiftsPoliciesState.error(failure.messageKey));
        return false;
      },
    );
  }
}
