import 'package:freezed_annotation/freezed_annotation.dart';
import '../../data/models/points_exchange_model.dart';

part 'exchange_state.freezed.dart';

@freezed
class ExchangeState with _$ExchangeState {
  const factory ExchangeState.initial() = ExchangeInitial;
  const factory ExchangeState.loading() = ExchangeLoading;
  const factory ExchangeState.success(PointsExchangeResultModel result) =
      ExchangeSuccess;
  const factory ExchangeState.error(String message) = ExchangeError;
}
