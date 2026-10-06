import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/auth/presentation/cubit/request_account/request_account_cubit.dart';
import 'request_account_submit_button_widget.dart';

class RequestAccessFormWidget extends StatefulWidget {
  const RequestAccessFormWidget({super.key});

  @override
  State<RequestAccessFormWidget> createState() =>
      _RequestAccessFormWidgetState();
}

class _RequestAccessFormWidgetState extends State<RequestAccessFormWidget> {
  final formKey = GlobalKey<FormState>();
  late final TextEditingController fullNameController;

  String? _selectedPhotoPath;
  bool _photoError = false;

  @override
  void initState() {
    super.initState();
    fullNameController = TextEditingController();
  }

  @override
  void dispose() {
    fullNameController.dispose();
    super.dispose();
  }

  Future<void> _pickPhoto() async {
    try {
      final result = await FilePicker.pickFiles(
        type: FileType.image,
        allowMultiple: false,
      );
      if (result != null && result.files.single.path != null) {
        setState(() {
          _selectedPhotoPath = result.files.single.path;
          _photoError = false;
        });
      }
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) => Form(
    key: formKey,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Avatar Photo Picker at Top (Mandatory)
        Center(
          child: GestureDetector(
            onTap: _pickPhoto,
            child: Stack(
              children: [
                Container(
                  width: 100.r,
                  height: 100.r,
                  decoration: BoxDecoration(
                    color: _photoError
                        ? AppColors.error.withValues(alpha: 0.1)
                        : AppColors.softBrandBackground,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: _selectedPhotoPath != null
                          ? AppColors.brandPrimary
                          : (_photoError ? AppColors.error : AppColors.border),
                      width: _photoError ? 2.5 : 2,
                    ),
                    image: _selectedPhotoPath != null
                        ? DecorationImage(
                            image: FileImage(File(_selectedPhotoPath!)),
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                  child: _selectedPhotoPath == null
                      ? Icon(
                          Icons.person_rounded,
                          size: 52.r,
                          color: _photoError
                              ? AppColors.error
                              : AppColors.placeholder,
                        )
                      : null,
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    padding: EdgeInsets.all(7.r),
                    decoration: BoxDecoration(
                      color: _photoError
                          ? AppColors.error
                          : AppColors.brandPrimary,
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.white, width: 2),
                    ),
                    child: Icon(
                      Icons.camera_alt_rounded,
                      size: 16.r,
                      color: AppColors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        hSpace(8),
        Center(
          child: Text(
            _selectedPhotoPath != null
                ? 'تم إرفاق الصورة الشخصية'
                : 'auth.requestAccess.photoRequired'.tr(context: context),
            style: AppTextStyles.font12Medium.copyWith(
              color: _selectedPhotoPath != null
                  ? AppColors.success
                  : (_photoError ? AppColors.error : AppColors.brandPrimary),
              fontWeight: _photoError ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ),
        hSpace(24),

        // Full Name
        Text(
          'auth.requestAccess.fullName'.tr(context: context),
          textAlign: TextAlign.start,
          style: AppTextStyles.font14SemiBold,
        ),
        hSpace(8),
        CustomTextFormField(
          hintText: 'auth.requestAccess.fullNameHint'.tr(context: context),
          controller: fullNameController,
          prefixIcon: Icon(
            Icons.person_outline_rounded,
            size: 21.r,
            color: AppColors.placeholder,
          ),
          validator: AppValidators.name(context: context),
        ),

        hSpace(32),
        RequestAccountSubmitButtonWidget(
          onSubmit: () {
            FocusScope.of(context).unfocus();
            if (_selectedPhotoPath == null || _selectedPhotoPath!.isEmpty) {
              setState(() {
                _photoError = true;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'validation.photoRequired'.tr(context: context),
                  ),
                  backgroundColor: AppColors.error,
                ),
              );
              return;
            }
            if (!(formKey.currentState?.validate() ?? false)) return;
            context.read<RequestAccountCubit>().submit(
              name: fullNameController.text.trim(),
              accountType: 'Personal',
              siteId: null,
              photoPath: _selectedPhotoPath,
            );
          },
        ),
      ],
    ),
  );
}
