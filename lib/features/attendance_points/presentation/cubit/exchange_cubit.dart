import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:check_point_v2/core/auth/auth_session_storage.dart';

import '../../data/models/points_exchange_model.dart';
import '../../data/repos/attendance_points_repo.dart';
import 'exchange_state.dart';

class ExchangeCubit extends Cubit<ExchangeState> {
  ExchangeCubit({
    required this.pointsRepo,
    required this.sessionStorage,
  }) : super(const ExchangeState.initial());

  final AttendancePointsRepo pointsRepo;
  final AuthSessionStorage sessionStorage;

  Future<void> exchange({
    required String target,
    required int quantity,
    required String idempotencyKey,
    String? employeeId,
  }) async {
    emit(const ExchangeState.loading());

    // Use the explicitly provided employeeId (from the loaded summary) or
    // fall back to reading it from the session storage.
    final resolvedEmployeeId =
        employeeId ?? await sessionStorage.readEmployeeId();

    final result = await pointsRepo.exchangePoints(
      PointsExchangeRequestBody(
        target: target,
        quantity: quantity,
        idempotencyKey: idempotencyKey,
        employeeId: resolvedEmployeeId,
      ),
    );

    result.when(
      success: (data) => emit(ExchangeState.success(data)),
      failure: (failure) => emit(ExchangeState.error(failure.messageKey)),
    );
  }

  void reset() {
    emit(const ExchangeState.initial());
  }
}

