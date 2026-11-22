import 'package:check_point_v2/core/core.dart';
import '../../domain/repos/disciplinary_repo.dart';
import '../../data/models/disciplinary_models.dart';
import 'disciplinary_state.dart';

class DisciplinaryCubit extends SafeCubit<DisciplinaryState> {
  DisciplinaryCubit({required this.repo})
      : super(const DisciplinaryState.initial());

  final DisciplinaryRepo repo;
  DisciplinarySummaryModel? currentSummary;
  DateTime currentMonth = DateTime(DateTime.now().year, DateTime.now().month);

  bool get canGoNext {
    final now = DateTime.now();
    return currentMonth.year < now.year ||
        (currentMonth.year == now.year && currentMonth.month < now.month);
  }

  Future<void> loadMyViolations({DateTime? forMonth}) async {
    if (forMonth != null) {
      currentMonth = DateTime(forMonth.year, forMonth.month);
    }
    final monthStr =
        '${currentMonth.year}-${currentMonth.month.toString().padLeft(2, '0')}';
    emit(const DisciplinaryState.loading());
    final result = await repo.getMyViolations(month: monthStr);
    if (isClosed) return;
    result.when(
      success: (summary) {
        currentSummary = summary;
        safeEmit(DisciplinaryState.success(summary: summary));
      },
      failure: (f) => safeEmit(DisciplinaryState.error(f.messageKey)),
    );
  }

  Future<void> previousMonth() =>
      loadMyViolations(forMonth: DateTime(currentMonth.year, currentMonth.month - 1));

  Future<void> nextMonth() {
    if (!canGoNext) return Future.value();
    return loadMyViolations(forMonth: DateTime(currentMonth.year, currentMonth.month + 1));
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
        await loadMyViolations(forMonth: currentMonth);
        return true;
      },
      failure: (f) {
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
