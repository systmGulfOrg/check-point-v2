import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:check_point_v2/core/services/national_id_ocr.dart';
import 'national_id_ocr_state.dart';

class NationalIdOcrCubit extends Cubit<NationalIdOcrState> {
  NationalIdOcrCubit({required this.ocr})
    : super(const NationalIdOcrState.initial());
  final NationalIdOcr ocr;

  Future<void> scan({required ImageSource source}) async {
    emit(const NationalIdOcrState.loading());
    try {
      final result = await ocr.recognize(source: source);
      emit(
        result == null
            ? const NationalIdOcrState.empty()
            : NationalIdOcrState.success(result),
      );
    } catch (_) {
      emit(const NationalIdOcrState.error('errors.nationalIdNotRecognized'));
    }
  }
}
