import 'package:check_point_v2/core/network/api_failure_mapper.dart';
import 'package:check_point_v2/core/network/api_result.dart';
import '../../domain/repos/disciplinary_repo.dart';
import '../apis/disciplinary_api_service.dart';
import '../models/disciplinary_models.dart';

class DisciplinaryRepoImpl implements DisciplinaryRepo {
  DisciplinaryRepoImpl({required this.api});
  final DisciplinaryApiService api;

  @override
  Future<ApiResult<DisciplinarySummaryModel>> getMyViolations({
    String? month,
  }) async {
    try {
      final response = await api.getMyViolations(month: month)
          as Map<String, dynamic>;
      final value = response['value'] as Map<String, dynamic>;
      return ApiResult.success(DisciplinarySummaryModel.fromJson(value));
    } catch (e) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }

  @override
  Future<ApiResult<void>> submitAppeal({
    required String violationId,
    required String reason,
    List<String> attachments = const [],
  }) async {
    try {
      await api.submitAppeal({
        'violationId': violationId,
        'reason': reason,
        'attachments': attachments,
      });
      return const ApiResult.success(null);
    } catch (e) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }

  @override
  Future<ApiResult<List<DisciplinaryRuleModel>>> getRulesMatrix() async {
    try {
      final response = await api.getMatrix() as Map<String, dynamic>;
      final value = response['value'] as Map<String, dynamic>?;
      final categories = value?['categories'] as List? ?? [];

      final rules = <DisciplinaryRuleModel>[];
      for (final cat in categories) {
        if (cat is Map<String, dynamic>) {
          final catName = cat['nameAr'] as String?;
          final rList = cat['rules'] as List? ?? [];
          for (final r in rList) {
            if (r is Map<String, dynamic>) {
              rules.add(
                DisciplinaryRuleModel.fromJson(r, categoryName: catName),
              );
            }
          }
        }
      }

      return ApiResult.success(rules);
    } catch (e) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }

  @override
  Future<ApiResult<DisciplinaryPreviewModel>> previewViolation({
    required String employeeId,
    required String ruleId,
    String? date,
  }) async {
    try {
      final response = await api.previewViolation(
        employeeId: employeeId,
        ruleId: ruleId,
        date: date,
      ) as Map<String, dynamic>;
      final value = response['value'] as Map<String, dynamic>;
      return ApiResult.success(DisciplinaryPreviewModel.fromJson(value));
    } catch (e) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }

  @override
  Future<ApiResult<void>> recordViolation({
    required String employeeId,
    required String ruleId,
    String? violationDate,
    String? notes,
  }) async {
    try {
      await api.recordViolation({
        'employeeId': employeeId,
        'ruleId': ruleId,
        'violationDate': violationDate,
        'notes': notes,
      });
      return const ApiResult.success(null);
    } catch (e) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }

  @override
  Future<ApiResult<List<DisciplinaryViolationModel>>> listViolations({
    String? month,
    String? status,
    int? index,
    int? itemCount,
  }) async {
    try {
      final response = await api.listViolations(
        month: month,
        status: status,
        index: index,
        itemCount: itemCount,
      ) as Map<String, dynamic>;
      final value = response['value'];
      final items = value is Map<String, dynamic> ? value['items'] : value;

      return ApiResult.success(
        items is List
            ? items
                .whereType<Map<String, dynamic>>()
                .map(DisciplinaryViolationModel.fromJson)
                .toList()
            : const [],
      );
    } catch (e) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }
}
