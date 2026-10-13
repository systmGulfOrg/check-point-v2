import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/points_exchange_model.dart';
import '../../data/repos/attendance_points_repo.dart';
import 'exchange_state.dart';

class ExchangeCubit extends Cubit<ExchangeState> {
  ExchangeCubit({required this.pointsRepo})
    : super(const ExchangeState.initial());

  final AttendancePointsRepo pointsRepo;

  Future<void> exchange({
    required String target,
    required int quantity,
    required String idempotencyKey,
    String? employeeId,
  }) async {
    emit(const ExchangeState.loading());
    final result = await pointsRepo.exchangePoints(
      PointsExchangeRequestBody(
        target: target,
        quantity: quantity,
        idempotencyKey: idempotencyKey,
        employeeId: employeeId,
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
