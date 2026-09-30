import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:check_point_v2/core/services/national_id_ocr.dart';
import '../cubit/national_id_ocr_cubit.dart';
import '../cubit/national_id_ocr_state.dart';

class NationalIdOcrListenerWidget extends StatelessWidget {
  const NationalIdOcrListenerWidget({
    required this.onDetected,
    required this.onFailure,
    required this.child,
    super.key,
  });
  final ValueChanged<NationalIdScanResult> onDetected;
  final ValueChanged<String> onFailure;
  final Widget child;

  @override
  Widget build(BuildContext context) =>
      BlocListener<NationalIdOcrCubit, NationalIdOcrState>(
        listener: (context, state) {
          switch (state) {
            case NationalIdOcrSuccess(:final result):
              onDetected(result);
            case NationalIdOcrEmpty():
              onFailure('errors.nationalIdNotRecognized'.tr());
            case NationalIdOcrError(:final messageKey):
              onFailure(messageKey.tr());
            case NationalIdOcrInitial() || NationalIdOcrLoading():
              break;
          }
        },
        child: child,
      );
}
