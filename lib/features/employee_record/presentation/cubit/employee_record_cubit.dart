import 'package:check_point_v2/core/bloc/safe_cubit.dart';
import 'package:check_point_v2/features/employee_record/data/repos/employee_record_repo.dart';
import 'employee_record_state.dart';

/// One month of an employee's record (own, team member, or any for admins;
/// the server enforces the scope).
class EmployeeRecordCubit extends SafeCubit<EmployeeRecordState> {
  EmployeeRecordCubit({required this.recordRepo, DateTime Function()? clock})
    : clock = clock ?? DateTime.now,
      super(const EmployeeRecordState.initial());

  final EmployeeRecordRepo recordRepo;
  final DateTime Function() clock;

  String employeeId = 'me';
  late DateTime month = DateTime(clock().year, clock().month);

  /// The next month is only reachable up to the current month.
  bool get canGoNext {
    final now = clock();
    return month.isBefore(DateTime(now.year, now.month));
  }

  Future<void> load({String? forEmployee, DateTime? forMonth}) async {
    if (forEmployee != null) employeeId = forEmployee;
    if (forMonth != null) month = DateTime(forMonth.year, forMonth.month);
    emit(EmployeeRecordState.loading(month));
    final requested = month;
    final result = await recordRepo.getMonth(employeeId: employeeId, month: requested);
    result.when(
      success: (record) => safeEmit(EmployeeRecordState.success(record, requested)),
      failure: (f) => safeEmit(EmployeeRecordState.error(f.messageKey, requested)),
    );
  }

  Future<void> previousMonth() => load(forMonth: DateTime(month.year, month.month - 1));

  Future<void> nextMonth() async {
    if (!canGoNext) return;
    await load(forMonth: DateTime(month.year, month.month + 1));
  }
}
