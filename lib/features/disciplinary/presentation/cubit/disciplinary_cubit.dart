import 'package:check_point_v2/core/bloc/safe_cubit.dart';
import '../../domain/repos/disciplinary_repo.dart';
import '../../data/models/disciplinary_models.dart';
import 'disciplinary_state.dart';

class DisciplinaryCubit extends SafeCubit<DisciplinaryState> {
  DisciplinaryCubit({required this.repo})
      : super(const DisciplinaryState.initial());

  final DisciplinaryRepo repo;
  DisciplinarySummaryModel? currentSummary;

  Future<void> loadMyViolations({String? month}) async {
    emit(const DisciplinaryState.loading());
    final result = await repo.getMyViolations(month: month);
    if (isClosed) return;
    result.when(
      success: (summary) {
        currentSummary = summary;
        safeEmit(DisciplinaryState.success(summary: summary));
      },
      failure: (f) => safeEmit(DisciplinaryState.error(f.messageKey)),
    );
  }

  Future<bool> submitAppeal({
    required String violationId,
    required String reason,
    List<String> attachments = const [],
  }) async {
    final result = await repo.submitAppeal(
      violationId: violationId,
      reason: reason,
      attachments: attachments,
    );
    return result.when(
      success: (_) async {
        await loadMyViolations(month: currentSummary?.month);
        return true;
      },
      failure: (f) {
        safeEmit(DisciplinaryState.error(f.messageKey));
        return false;
      },
    );
  }

  Future<DisciplinaryPreviewModel?> previewViolation({
    required String employeeId,
    required String ruleId,
    String? date,
  }) async {
    final result = await repo.previewViolation(
      employeeId: employeeId,
      ruleId: ruleId,
      date: date,
    );
    return result.when(
      success: (preview) => preview,
      failure: (_) => null,
    );
  }

  Future<bool> recordViolation({
    required String employeeId,
    required String ruleId,
    String? violationDate,
    String? notes,
  }) async {
    final result = await repo.recordViolation(
      employeeId: employeeId,
      ruleId: ruleId,
      violationDate: violationDate,
      notes: notes,
    );
    return result.when(
      success: (_) => true,
      failure: (f) {
        safeEmit(DisciplinaryState.error(f.messageKey));
        return false;
      },
    );
  }

  Future<List<DisciplinaryRuleModel>> getRulesMatrix() async {
    final result = await repo.getRulesMatrix();
    return result.when(
      success: (rules) => rules,
      failure: (_) => const [],
    );
  }
}
