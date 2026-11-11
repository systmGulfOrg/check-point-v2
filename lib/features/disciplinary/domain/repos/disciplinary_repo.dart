import 'package:check_point_v2/core/network/api_result.dart';
import '../../data/models/disciplinary_models.dart';

abstract class DisciplinaryRepo {
  Future<ApiResult<DisciplinarySummaryModel>> getMyViolations({String? month});

  Future<ApiResult<void>> submitAppeal({
    required String violationId,
    required String reason,
    List<String> attachments = const [],
  });

  Future<ApiResult<List<DisciplinaryRuleModel>>> getRulesMatrix();

  Future<ApiResult<DisciplinaryPreviewModel>> previewViolation({
    required String employeeId,
    required String ruleId,
    String? date,
  });

  Future<ApiResult<void>> recordViolation({
    required String employeeId,
    required String ruleId,
    String? violationDate,
    String? notes,
  });

  Future<ApiResult<List<DisciplinaryViolationModel>>> listViolations({
    String? month,
    String? status,
    int? index,
    int? itemCount,
  });
}
