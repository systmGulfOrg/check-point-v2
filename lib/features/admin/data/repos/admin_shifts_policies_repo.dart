import '../../../../core/network/api_result.dart';
import '../models/police_model.dart';
import '../models/shift_model.dart';

abstract class AdminShiftsPoliciesRepo {
  Future<ApiResult<List<ShiftModel>>> getShifts();
  Future<ApiResult<void>> addShift(AddShiftRequestBody body);
  Future<ApiResult<void>> editShift({
    required int id,
    required AddShiftRequestBody body,
  });
  Future<ApiResult<void>> deleteShift({required int id});
  Future<ApiResult<void>> assignShift(AssignShiftsRequestBody body);

  Future<ApiResult<List<PoliceModel>>> getPoliciesByShift({
    required int shiftId,
  });
  Future<ApiResult<void>> addPolicy(AddPoliceRequestBody body);
  Future<ApiResult<void>> editPolicy({
    required int id,
    required AddPoliceRequestBody body,
  });
  Future<ApiResult<void>> deletePolicy({required int id});
  Future<ApiResult<void>> assignPolicy(AssignPoliceRequestBody body);
  Future<ApiResult<void>> removeAssignPolicy(
    RemoveAssignPolicyRequestBody body,
  );
}
