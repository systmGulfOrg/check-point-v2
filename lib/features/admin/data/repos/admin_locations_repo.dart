import '../../../../core/network/api_result.dart';
import '../models/branch_request_model.dart';
import '../models/branch_response_model.dart';
import '../models/customer_request_model.dart';
import '../models/customer_response_model.dart';
import '../models/department_request_model.dart';
import '../models/department_response_model.dart';

abstract class AdminLocationsRepo {
  Future<ApiResult<List<BranchModel>>> getBranches();
  Future<ApiResult<void>> addBranch(BranchRequestModel request);
  Future<ApiResult<void>> editBranch(int id, BranchRequestModel request);
  Future<ApiResult<void>> deleteBranch(int id);

  Future<ApiResult<List<DepartmentModel>>> getDepartments();
  Future<ApiResult<List<DepartmentModel>>> searchDepartments(String searchKey);
  Future<ApiResult<void>> addDepartment(DepartmentRequestModel request);
  Future<ApiResult<void>> editDepartment(
    int id,
    DepartmentRequestModel request,
  );
  Future<ApiResult<void>> deleteDepartment(int id);

  Future<ApiResult<List<CustomerModel>>> getCustomersByType(String type);
  Future<ApiResult<void>> addCustomer(CustomerRequestModel request);
  Future<ApiResult<void>> editCustomer(String id, CustomerRequestModel request);
  Future<ApiResult<void>> deleteCustomer(String id);
}
