import 'dart:io';

import 'package:check_point_v2/core/network/api_result.dart';
import 'package:check_point_v2/features/admin/data/models/locations/customer_visit_model.dart';

abstract class AdminCustomerVisitsRepo {
  Future<ApiResult<List<CustomerVisitModel>>> getCustomerVisits(
    String customerId,
  );
  Future<ApiResult<List<CustomerVisitModel>>> getAllVisits();
  Future<ApiResult<void>> addVisitPlan(CustomerVisitModel visit);
  /// Uploads [file] as the visit's attachment and returns the stored
  /// (name, url) pair. The url is a real server-hosted link, never a local
  /// device path — never persist [file.path] directly as `documentUrl`.
  Future<ApiResult<({String documentName, String documentUrl})>>
  uploadVisitDocument({required String visitId, required File file});

  /// Same as [uploadVisitDocument] but used before the visit exists yet
  /// (the create-visit form lets the user attach a document pre-submit).
  Future<ApiResult<({String documentName, String documentUrl})>>
  uploadNewVisitDocument(File file);
  Future<ApiResult<void>> updateVisitOutcome({
    required String visitId,
    required String outcome,
    required String status,
    String? notes,
    String? documentName,
    String? documentUrl,
  });
  Future<ApiResult<void>> cancelVisit({
    required String visitId,
    String? reason,
  });
  Future<ApiResult<void>> rescheduleVisit({
    required String visitId,
    required String visitDate,
    String? visitTime,
    String? reason,
  });
}
