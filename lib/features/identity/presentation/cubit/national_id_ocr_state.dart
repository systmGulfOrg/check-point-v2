import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:check_point_v2/core/services/national_id_ocr.dart';

part 'national_id_ocr_state.freezed.dart';

@freezed
class NationalIdOcrState with _$NationalIdOcrState {
  const factory NationalIdOcrState.initial() = NationalIdOcrInitial;
  const factory NationalIdOcrState.loading() = NationalIdOcrLoading;
  const factory NationalIdOcrState.success(NationalIdScanResult result) =
      NationalIdOcrSuccess;
  const factory NationalIdOcrState.empty() = NationalIdOcrEmpty;
  const factory NationalIdOcrState.error(String messageKey) =
      NationalIdOcrError;
}
