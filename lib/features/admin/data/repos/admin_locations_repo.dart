import '../../../../core/network/api_result.dart';
import '../models/branch_request_model.dart';
import '../models/branch_response_model.dart';
import '../models/department_request_model.dart';
import '../models/department_response_model.dart';

abstract class AdminLocationsRepo {
  Future<ApiResult<List<DepartmentModel>>> getDepartments();
  Future<ApiResult<List<DepartmentModel>>> searchDepartments(String query);
  Future<ApiResult<void>> addDepartment(DepartmentRequestModel request);
  Future<ApiResult<void>> editDepartment({
    required int id,
    required DepartmentRequestModel request,
  });
  Future<ApiResult<void>> deleteDepartment({required int id});
  Future<ApiResult<List<BranchModel>>> getBranches();
  Future<ApiResult<void>> addBranch(BranchRequestModel request);
  Future<ApiResult<void>> editBranch({
    required int id,
    required BranchRequestModel request,
  });
  Future<ApiResult<void>> deleteBranch({required int id});
}
