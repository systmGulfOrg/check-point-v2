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
  late final TextEditingController nationalIdController;
  late final TextEditingController phoneController;
  late final TextEditingController notesController;

  String? _selectedPhotoPath;

  @override
  void initState() {
    super.initState();
    fullNameController = TextEditingController();
    nationalIdController = TextEditingController();
    phoneController = TextEditingController();
    notesController = TextEditingController();
  }

  @override
  void dispose() {
    fullNameController.dispose();
    nationalIdController.dispose();
    phoneController.dispose();
    notesController.dispose();
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
        // Avatar Photo Picker at Top
        Center(
          child: GestureDetector(
            onTap: _pickPhoto,
            child: Stack(
              children: [
                Container(
                  width: 90.r,
                  height: 90.r,
                  decoration: BoxDecoration(
                    color: AppColors.softBrandBackground,
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.brandPrimary, width: 2),
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
                          size: 48.r,
                          color: AppColors.brandPrimary,
                        )
                      : null,
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    padding: EdgeInsets.all(6.r),
                    decoration: BoxDecoration(
                      color: AppColors.brandPrimary,
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
        hSpace(6),
        Center(
          child: Text(
            _selectedPhotoPath != null
                ? 'تم إرفاق الصورة الشخصية'
                : 'اضغط لالتقاط أو اختيار الصورة الشخصية',
            style: AppTextStyles.font12Medium.copyWith(
              color: _selectedPhotoPath != null
                  ? AppColors.success
                  : AppColors.textSecondary,
            ),
          ),
        ),
        hSpace(18),

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
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'auth.requestAccess.fullNameRequired'.tr(context: context);
            }
            return null;
          },
        ),

        // National ID
        hSpace(16),
        Text(
          'الرقم القومي',
          textAlign: TextAlign.start,
          style: AppTextStyles.font14SemiBold,
        ),
        hSpace(8),
        CustomTextFormField(
          hintText: 'أدخل 14 رقم البطاقة الشخصية',
          controller: nationalIdController,
          keyboardType: TextInputType.number,
          prefixIcon: Icon(
            Icons.badge_outlined,
            size: 21.r,
            color: AppColors.placeholder,
          ),
        ),

        // Phone Number
        hSpace(16),
        Text(
          'رقم الهاتف',
          textAlign: TextAlign.start,
          style: AppTextStyles.font14SemiBold,
        ),
        hSpace(8),
        CustomTextFormField(
          hintText: 'أدخل رقم الموبايل',
          controller: phoneController,
          keyboardType: TextInputType.phone,
          prefixIcon: Icon(
            Icons.phone_outlined,
            size: 21.r,
            color: AppColors.placeholder,
          ),
        ),

        // Notes
        hSpace(16),
        Text(
          'ملاحظات إضافية',
          textAlign: TextAlign.start,
          style: AppTextStyles.font14SemiBold,
        ),
        hSpace(8),
        CustomTextFormField(
          hintText: 'أي تفاصيل أو ملاحظات للإدارة',
          controller: notesController,
          prefixIcon: Icon(
            Icons.note_alt_outlined,
            size: 21.r,
            color: AppColors.placeholder,
          ),
        ),

        hSpace(22),
        RequestAccountSubmitButtonWidget(
          onSubmit: () {
            FocusScope.of(context).unfocus();
            if (!(formKey.currentState?.validate() ?? false)) return;
            context.read<RequestAccountCubit>().submit(
              name: fullNameController.text.trim(),
              accountType: 'Personal',
              siteId: null,
              nationalId: nationalIdController.text.trim().isNotEmpty
                  ? nationalIdController.text.trim()
                  : null,
              phone: phoneController.text.trim().isNotEmpty
                  ? phoneController.text.trim()
                  : null,
              notes: notesController.text.trim().isNotEmpty
                  ? notesController.text.trim()
                  : null,
              photoPath: _selectedPhotoPath,
            );
          },
        ),
      ],
    ),
  );
}
