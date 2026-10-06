import 'package:check_point_v2/core/network/api_result.dart';
import 'package:check_point_v2/features/admin/data/models/locations/customer_visit_model.dart';

abstract class AdminCustomerVisitsRepo {
  Future<ApiResult<List<CustomerVisitModel>>> getCustomerVisits(
    String customerId,
  );
  Future<ApiResult<List<CustomerVisitModel>>> getAllVisits();
  Future<ApiResult<void>> addVisitPlan(CustomerVisitModel visit);
  Future<ApiResult<void>> updateVisitOutcome({
    required String visitId,
    required String outcome,
    required String status,
    String? notes,
  });
}
