import 'package:freezed_annotation/freezed_annotation.dart';
import '../../data/models/disciplinary_models.dart';

part 'disciplinary_state.freezed.dart';

@freezed
class DisciplinaryState with _$DisciplinaryState {
  const factory DisciplinaryState.initial() = DisciplinaryStateInitial;
  const factory DisciplinaryState.loading() = DisciplinaryStateLoading;
  const factory DisciplinaryState.success({
    required DisciplinarySummaryModel summary,
  }) = DisciplinaryStateSuccess;
  const factory DisciplinaryState.error(String messageKey) =
      DisciplinaryStateError;
}
