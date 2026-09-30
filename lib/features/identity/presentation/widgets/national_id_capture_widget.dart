import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:check_point_v2/core/core.dart';
import '../cubit/national_id_ocr_cubit.dart';
import '../cubit/national_id_ocr_state.dart';

class NationalIdCaptureWidget extends StatelessWidget {
  const NationalIdCaptureWidget({required this.controller, super.key});
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'identity.nationalId'.tr(context: context),
        style: AppTextStyles.font13SemiBold,
      ),
      hSpace(6),
      CustomTextFormField(
        controller: controller,
        hintText: 'identity.nationalIdHint'.tr(context: context),
        prefixIcon: const Icon(
          Icons.credit_card_outlined,
          color: AppColors.brandPrimary,
        ),
        keyboardType: TextInputType.number,
        maxLength: 14,
      ),
      BlocSelector<NationalIdOcrCubit, NationalIdOcrState, bool>(
        selector: (state) => state is NationalIdOcrLoading,
        builder: (context, isLoading) => Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: isLoading
                    ? null
                    : () => context.read<NationalIdOcrCubit>().scan(
                        source: ImageSource.camera,
                      ),
                icon: const Icon(Icons.camera_alt_outlined),
                label: Text('identity.scanCard'.tr(context: context)),
              ),
            ),
            wSpace(8),
            Expanded(
              child: OutlinedButton.icon(
                onPressed: isLoading
                    ? null
                    : () => context.read<NationalIdOcrCubit>().scan(
                        source: ImageSource.gallery,
                      ),
                icon: const Icon(Icons.photo_library_outlined),
                label: Text('identity.chooseCard'.tr(context: context)),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}
