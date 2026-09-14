import 'package:flutter_test/flutter_test.dart';

import 'package:check_point_v2/core/network/api_result.dart';
import 'package:check_point_v2/features/admin/data/models/shifts_policies/police_model.dart';
import 'package:check_point_v2/features/admin/data/models/shifts_policies/shift_model.dart';
import 'package:check_point_v2/features/admin/data/repos/admin_shifts_policies_repo.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/shifts_policies/admin_shifts_policies_cubit.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/shifts_policies/admin_shifts_policies_state.dart';

class _FakeShiftsPoliciesRepo implements AdminShiftsPoliciesRepo {
  final shifts = <ShiftModel>[];
  AddShiftRequestBody? addedBody;

  @override
  Future<ApiResult<List<ShiftModel>>> getShifts() async =>
      ApiResult.success(shifts);

  @override
  Future<ApiResult<void>> addShift(AddShiftRequestBody body) async {
    addedBody = body;
    shifts.add(
      ShiftModel(
        id: shifts.length + 1,
        name: body.name,
        description: body.description,
      ),
    );
    return const ApiResult.success(null);
  }

  @override
  Future<ApiResult<void>> editShift({
    required int id,
    required AddShiftRequestBody body,
  }) async => const ApiResult.success(null);

  @override
  Future<ApiResult<void>> deleteShift({required int id}) async =>
      const ApiResult.success(null);

  @override
  Future<ApiResult<void>> assignShift(AssignShiftsRequestBody body) async =>
      const ApiResult.success(null);

  @override
  Future<ApiResult<List<PoliceModel>>> getPoliciesByShift({
    required int shiftId,
  }) async => const ApiResult.success([]);

  @override
  Future<ApiResult<void>> addPolicy(AddPoliceRequestBody body) async =>
      const ApiResult.success(null);

  @override
  Future<ApiResult<void>> editPolicy({
    required int id,
    required AddPoliceRequestBody body,
  }) async => const ApiResult.success(null);

  @override
  Future<ApiResult<void>> deletePolicy({required int id}) async =>
      const ApiResult.success(null);

  @override
  Future<ApiResult<void>> assignPolicy(AssignPoliceRequestBody body) async =>
      const ApiResult.success(null);

  @override
  Future<ApiResult<void>> removeAssignPolicy(
    RemoveAssignPolicyRequestBody body,
  ) async => const ApiResult.success(null);
}

void main() {
  test('addShift sends the description and reloads the shifts', () async {
    final repo = _FakeShiftsPoliciesRepo();
    final cubit = AdminShiftsPoliciesCubit(shiftsPoliciesRepo: repo);
    addTearDown(cubit.close);

    final saved = await cubit.addShift(
      const AddShiftRequestBody(
        name: 'Morning Shift',
        description: 'Standard morning working hours',
      ),
    );

    expect(saved, isTrue);
    expect(repo.addedBody?.name, 'Morning Shift');
    expect(repo.addedBody?.description, 'Standard morning working hours');
    final state = cubit.state;
    expect(state, isA<AdminShiftsPoliciesState>());
    state.maybeWhen(
      success: (loadedShifts, loadedPolicies) {
        expect(loadedShifts.single.name, 'Morning Shift');
        expect(
          loadedShifts.single.description,
          'Standard morning working hours',
        );
        expect(loadedPolicies, isEmpty);
      },
      orElse: () => fail('Expected a successful shift state'),
    );
  });
}
