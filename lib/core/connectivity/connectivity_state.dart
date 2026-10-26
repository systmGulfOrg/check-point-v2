import 'package:freezed_annotation/freezed_annotation.dart';

part 'connectivity_state.freezed.dart';

@freezed
class ConnectivityState with _$ConnectivityState {
  const factory ConnectivityState({
    @Default(true) bool isOnline,
    @Default(false) bool isChecking,
    @Default(0) int pendingCount,
  }) = _ConnectivityState;
}
