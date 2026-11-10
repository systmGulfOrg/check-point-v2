import 'package:check_point_v2/core/network/api_result.dart';
import 'package:check_point_v2/features/disciplinary/data/models/disciplinary_models.dart';
import 'package:check_point_v2/features/disciplinary/domain/repos/disciplinary_repo.dart';
import 'package:check_point_v2/features/disciplinary/presentation/cubit/disciplinary_cubit.dart';
import 'package:check_point_v2/features/disciplinary/presentation/cubit/disciplinary_state.dart';
import 'package:flutter_test/flutter_test.dart';

class _FakeDisciplinaryRepo implements DisciplinaryRepo {
  _FakeDisciplinaryRepo({required this.summaryResult});

  final ApiResult<DisciplinarySummaryModel> summaryResult;

  @override
  Future<ApiResult<DisciplinarySummaryModel>> getMyViolations({
    String? month,
  }) async =>
      summaryResult;

  @override
  Future<ApiResult<void>> submitAppeal({
    required String violationId,
    required String reason,
    List<String> attachments = const [],
  }) async =>
      const ApiResult.success(null);

  @override
  Future<ApiResult<List<DisciplinaryRuleModel>>> getRulesMatrix() async =>
      const ApiResult.success([]);

  @override
  Future<ApiResult<DisciplinaryPreviewModel>> previewViolation({
    required String employeeId,
    required String ruleId,
    String? date,
  }) async =>
      const ApiResult.success(
        DisciplinaryPreviewModel(
          occurrenceIndex: 1,
          penaltyType: 'FRACTION_OF_DAY',
          penaltyValue: 0.5,
          deductedDays: 0.5,
          calculatedAmount: 100.0,
          requiresAdminReview: false,
          dayWage: 200.0,
          labelAr: 'خصم نصف يوم (0.5)',
        ),
      );

  @override
  Future<ApiResult<void>> recordViolation({
    required String employeeId,
    required String ruleId,
    String? violationDate,
    String? notes,
  }) async =>
      const ApiResult.success(null);

  @override
  Future<ApiResult<List<DisciplinaryViolationModel>>> listViolations({
    String? month,
    String? status,
    int? index,
    int? itemCount,
  }) async =>
      const ApiResult.success([]);
}

void main() {
  group('DisciplinaryCubit Tests', () {
    test('initial state is DisciplinaryStateInitial', () {
      final repo = _FakeDisciplinaryRepo(
        summaryResult: const ApiResult.success(
          DisciplinarySummaryModel(
            month: '2026-11',
            violationsCount: 0,
            totalDeductedDays: 0,
            totalCalculatedAmount: 0,
            violations: [],
          ),
        ),
      );
      final cubit = DisciplinaryCubit(repo: repo);
      expect(cubit.state, const DisciplinaryState.initial());
      cubit.close();
    });

    test('loadMyViolations emits loading then success', () async {
      const summary = DisciplinarySummaryModel(
        month: '2026-11',
        violationsCount: 1,
        totalDeductedDays: 0.5,
        totalCalculatedAmount: 100.0,
        violations: [
          DisciplinaryViolationModel(
            id: 'v1',
            occurrenceIndex: 1,
            penaltyType: 'FRACTION_OF_DAY',
            penaltyValue: 0.5,
            deductedDays: 0.5,
            calculatedAmount: 100.0,
            requiresAdminReview: false,
            requiresWrittenWarning: false,
            status: 'APPROVED',
            violationDate: '2026-11-10T10:00:00.000Z',
            ruleDescriptionAr: 'دخول مكتب الإدارة',
          ),
        ],
      );

      final repo = _FakeDisciplinaryRepo(
        summaryResult: const ApiResult.success(summary),
      );
      final cubit = DisciplinaryCubit(repo: repo);

      await cubit.loadMyViolations();

      expect(cubit.state, isA<DisciplinaryStateSuccess>());
      final success = cubit.state as DisciplinaryStateSuccess;
      expect(success.summary.violationsCount, 1);
      expect(success.summary.totalDeductedDays, 0.5);

      cubit.close();
    });

    test('previewViolation calls repo and returns model', () async {
      final repo = _FakeDisciplinaryRepo(
        summaryResult: const ApiResult.success(
          DisciplinarySummaryModel(
            month: '2026-11',
            violationsCount: 0,
            totalDeductedDays: 0,
            totalCalculatedAmount: 0,
            violations: [],
          ),
        ),
      );
      final cubit = DisciplinaryCubit(repo: repo);

      final preview = await cubit.previewViolation(
        employeeId: 'emp-1',
        ruleId: 'rule-1',
      );

      expect(preview, isNotNull);
      expect(preview!.occurrenceIndex, 1);
      expect(preview.deductedDays, 0.5);
      expect(preview.labelAr, 'خصم نصف يوم (0.5)');

      cubit.close();
    });

    test('recordViolation delegates to repo and returns success', () async {
      final repo = _FakeDisciplinaryRepo(
        summaryResult: const ApiResult.success(
          DisciplinarySummaryModel(
            month: '2026-11',
            violationsCount: 0,
            totalDeductedDays: 0,
            totalCalculatedAmount: 0,
            violations: [],
          ),
        ),
      );
      final cubit = DisciplinaryCubit(repo: repo);

      final result = await cubit.recordViolation(
        employeeId: 'emp-101',
        ruleId: 'rule-smoke',
        notes: 'مخالفة تدخين في مكان العمل',
      );

      expect(result, isTrue);
      cubit.close();
    });

    test('submitAppeal delegates to repo and returns success', () async {
      final repo = _FakeDisciplinaryRepo(
        summaryResult: const ApiResult.success(
          DisciplinarySummaryModel(
            month: '2026-11',
            violationsCount: 0,
            totalDeductedDays: 0,
            totalCalculatedAmount: 0,
            violations: [],
          ),
        ),
      );
      final cubit = DisciplinaryCubit(repo: repo);

      final result = await cubit.submitAppeal(
        violationId: 'viol-99',
        reason: 'كنت متواجداً في اجتماع خارجي',
      );

      expect(result, isTrue);
      cubit.close();
    });
  });
}
