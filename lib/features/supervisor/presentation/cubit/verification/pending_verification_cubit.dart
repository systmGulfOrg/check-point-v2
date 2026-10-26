import 'package:check_point_v2/core/bloc/safe_cubit.dart';
import 'package:check_point_v2/core/models/offline_attendance_models.dart';
import 'package:check_point_v2/features/supervisor/domain/use_cases/get_pending_verifications_use_case.dart';
import 'package:check_point_v2/features/supervisor/domain/use_cases/verify_attendance_record_use_case.dart';
import 'pending_verification_state.dart';

class PendingVerificationCubit extends SafeCubit<PendingVerificationState> {
  final GetPendingVerificationsUseCase getPendingVerificationsUseCase;
  final VerifyAttendanceRecordUseCase verifyAttendanceRecordUseCase;

  List<PendingAttendanceItem> _currentItems = [];
  List<PendingAttendanceItem> get currentItems => _currentItems;

  PendingVerificationCubit({
    required this.getPendingVerificationsUseCase,
    required this.verifyAttendanceRecordUseCase,
  }) : super(const PendingVerificationState.initial());

  Future<void> loadPendingVerifications() async {
    emit(const PendingVerificationState.loading());
    final result = await getPendingVerificationsUseCase();
    result.when(
      success: (items) {
        _currentItems = items;
        safeEmit(PendingVerificationState.loaded(items));
      },
      failure: (f) => safeEmit(PendingVerificationState.error(f.messageKey)),
    );
  }

  Future<bool> approve(int id) async {
    final result = await verifyAttendanceRecordUseCase(id, action: 'APPROVE');
    return result.when(
      success: (_) {
        _currentItems = _currentItems.where((item) => item.id != id).toList();
        safeEmit(const PendingVerificationState.actionSuccess('offline.approveSuccess'));
        safeEmit(PendingVerificationState.loaded(_currentItems));
        return true;
      },
      failure: (f) {
        safeEmit(PendingVerificationState.error(f.messageKey));
        return false;
      },
    );
  }

  Future<bool> reject(int id, {String? reason}) async {
    final result = await verifyAttendanceRecordUseCase(
      id,
      action: 'REJECT',
      reason: reason,
    );
    return result.when(
      success: (_) {
        _currentItems = _currentItems.where((item) => item.id != id).toList();
        safeEmit(const PendingVerificationState.actionSuccess('offline.rejectSuccess'));
        safeEmit(PendingVerificationState.loaded(_currentItems));
        return true;
      },
      failure: (f) {
        safeEmit(PendingVerificationState.error(f.messageKey));
        return false;
      },
    );
  }
}
