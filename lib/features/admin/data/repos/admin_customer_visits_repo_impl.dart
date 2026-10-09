import 'package:check_point_v2/core/network/api_failure_mapper.dart';
import 'package:check_point_v2/core/network/api_result.dart';
import 'package:check_point_v2/features/admin/data/apis/admin_api_service.dart';
import 'package:check_point_v2/features/admin/data/models/locations/customer_visit_model.dart';
import 'admin_customer_visits_repo.dart';

class AdminCustomerVisitsRepoImpl implements AdminCustomerVisitsRepo {
  AdminCustomerVisitsRepoImpl({required this.api});

  final AdminApiService api;

  @override
  Future<ApiResult<List<CustomerVisitModel>>> getCustomerVisits(
    String customerId,
  ) async {
    try {
      final response = await api.getCustomerPlans(
        customerId: customerId.isNotEmpty ? customerId : null,
        itemCount: 100,
      );
      final list = response.value?.list ?? [];
      return ApiResult.success(list);
    } catch (e) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }

  @override
  Future<ApiResult<List<CustomerVisitModel>>> getAllVisits() async {
    try {
      final response = await api.getCustomerPlans(itemCount: 200);
      final list = response.value?.list ?? [];
      return ApiResult.success(list);
    } catch (e) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }

  @override
  Future<ApiResult<void>> addVisitPlan(CustomerVisitModel visit) async {
    try {
      await api.createCustomerPlan({
        'customerId': visit.customerId,
        'title': visit.title,
        'visitDate': visit.visitDate,
        'visitTime': visit.visitTime,
        'attendees': visit.attendees,
        'documentName': visit.documentName,
        'documentUrl': visit.documentUrl,
        'note': visit.notes,
        'notes': visit.notes,
        'outcome': visit.outcome,
        'status': visit.status,
      });
      return const ApiResult.success(null);
    } catch (e) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }

  @override
  Future<ApiResult<void>> updateVisitOutcome({
    required String visitId,
    required String outcome,
    required String status,
    String? notes,
    String? documentName,
    String? documentUrl,
  }) async {
    try {
      await api.updateCustomerPlan(visitId, {
        'outcome': outcome,
        'status': status,
        ...?notes == null ? null : {'note': notes, 'notes': notes},
        ...?documentName == null ? null : {'documentName': documentName},
        ...?documentUrl == null ? null : {'documentUrl': documentUrl},
      });
      return const ApiResult.success(null);
    } catch (e) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }

  @override
  Future<ApiResult<void>> cancelVisit({
    required String visitId,
    String? reason,
  }) async {
    try {
      await api.updateCustomerPlan(visitId, {
        'status': 'Cancelled',
        ...?reason == null ? null : {'note': reason, 'notes': reason},
      });
      return const ApiResult.success(null);
    } catch (e) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }

  @override
  Future<ApiResult<void>> rescheduleVisit({
    required String visitId,
    required String visitDate,
    String? visitTime,
    String? reason,
  }) async {
    try {
      await api.updateCustomerPlan(visitId, {
        'visitDate': visitDate,
        'status': 'Rescheduled',
        ...?visitTime == null ? null : {'visitTime': visitTime},
        ...?reason == null ? null : {'note': reason, 'notes': reason},
      });
      return const ApiResult.success(null);
    } catch (e) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }
}
