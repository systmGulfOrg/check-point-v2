import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/admin/presentation/widgets/admin_wizard_field_widget.dart';

class AdminCreateEmployeePersonalStepWidget extends StatefulWidget {
  const AdminCreateEmployeePersonalStepWidget({
    required this.nameController,
    required this.usernameController,
    required this.passwordController,
    required this.mobileController,
    required this.phoneController,
    required this.emailController,
    required this.employeeCodeController,
    required this.selectedPhotoPath,
    required this.onPhotoSelected,
    this.initialPhotoUrl,
    super.key,
  });

  final TextEditingController nameController;
  final TextEditingController usernameController;
  final TextEditingController passwordController;
  final TextEditingController mobileController;
  final TextEditingController phoneController;
  final TextEditingController emailController;
  final TextEditingController employeeCodeController;
  final String? selectedPhotoPath;
  final String? initialPhotoUrl;
  final ValueChanged<String?> onPhotoSelected;

  @override
  State<AdminCreateEmployeePersonalStepWidget> createState() =>
      _AdminCreateEmployeePersonalStepWidgetState();
}

class _AdminCreateEmployeePersonalStepWidgetState
    extends State<AdminCreateEmployeePersonalStepWidget> {
  bool obscurePassword = false;

  Future<void> _pickPhoto() async {
    try {
      final result = await FilePicker.pickFiles(
        type: FileType.image,
        allowMultiple: false,
      );
      if (result != null && result.files.single.path != null) {
        widget.onPhotoSelected(result.files.single.path);
      }
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    final hasPhoto = widget.selectedPhotoPath != null ||
        (widget.initialPhotoUrl != null && widget.initialPhotoUrl!.isNotEmpty);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'admin.employeeWizard.personalTitle'.tr(context: context),
          style: AppTextStyles.font16Bold,
        ),
        hSpace(16),

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
                    border: Border.all(
                      color: hasPhoto
                          ? AppColors.brandPrimary
                          : AppColors.border,
                      width: 2,
                    ),
                    image: () {
                      final provider = AppImageProvider.resolve(
                        widget.selectedPhotoPath ?? widget.initialPhotoUrl,
                      );
                      return provider != null
                          ? DecorationImage(
                              image: provider,
                              fit: BoxFit.cover,
                            )
                          : null;
                    }(),
                  ),
                  child: !hasPhoto
                      ? Icon(
                          Icons.person_rounded,
                          size: 48.r,
                          color: AppColors.placeholder,
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
            hasPhoto
                ? 'تم إرفاق الصورة الشخصية'
                : 'admin.employeeWizard.profilePhoto'.tr(context: context),
            style: AppTextStyles.font12Medium.copyWith(
              color: hasPhoto ? AppColors.success : AppColors.brandPrimary,
            ),
          ),
        ),
        hSpace(18),

        // Full Name
        AdminWizardFieldWidget(
          label: 'admin.employeeWizard.fullName'.tr(context: context),
          child: CustomTextFormField(
            hintText: 'admin.employeeWizard.fullNameHint'.tr(context: context),
            controller: widget.nameController,
            prefixIcon: Icon(
              Icons.person_outline_rounded,
              size: 20.r,
              color: AppColors.placeholder,
            ),
            validator: AppValidators.name(
              message: 'admin.employeeWizard.requiredField'.tr(
                context: context,
              ),
              context: context,
            ),
          ),
        ),

        // Username
        AdminWizardFieldWidget(
          label: 'admin.employeeWizard.username'.tr(context: context),
          child: CustomTextFormField(
            hintText: 'admin.employeeWizard.usernameHint'.tr(context: context),
            controller: widget.usernameController,
            prefixIcon: Icon(
              Icons.alternate_email_rounded,
              size: 20.r,
              color: AppColors.placeholder,
            ),
            validator: AppValidators.required(
              message: 'admin.employeeWizard.requiredField'.tr(
                context: context,
              ),
              context: context,
            ),
          ),
        ),

        // Password with Default Def123! Note
        AdminWizardFieldWidget(
          label: 'admin.employeeWizard.password'.tr(context: context),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextFormField(
                hintText:
                    'admin.employeeWizard.passwordHint'.tr(context: context),
                controller: widget.passwordController,
                obscureText: obscurePassword,
                prefixIcon: Icon(
                  Icons.lock_outline_rounded,
                  size: 20.r,
                  color: AppColors.placeholder,
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    obscurePassword
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    size: 20.r,
                    color: AppColors.placeholder,
                  ),
                  onPressed: () =>
                      setState(() => obscurePassword = !obscurePassword),
                ),
                validator: AppValidators.password(
                  minLength: 6,
                  message: 'admin.employeeWizard.requiredField'.tr(
                    context: context,
                  ),
                  context: context,
                ),
              ),
              hSpace(6),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 2.h),
                    child: Icon(
                      Icons.info_outline_rounded,
                      size: 14.r,
                      color: AppColors.placeholder,
                    ),
                  ),
                  vSpace(6),
                  Expanded(
                    child: Text(
                      'admin.employeeWizard.defaultPasswordNote'.tr(
                        context: context,
                      ),
                      style: AppTextStyles.font11Regular.copyWith(
                        color: AppColors.textSecondary,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        // Mobile ID (Read-only + Copyable)
        AdminWizardFieldWidget(
          label: 'admin.employeeWizard.mobile'.tr(context: context),
          child: CustomTextFormField(
            hintText: 'admin.employeeWizard.mobileHint'.tr(context: context),
            controller: widget.mobileController,
            readOnly: true,
            prefixIcon: Icon(
              Icons.tag_rounded,
              size: 20.r,
              color: AppColors.placeholder,
            ),
            suffixIcon: IconButton(
              icon: Icon(
                Icons.content_copy_outlined,
                size: 18.r,
                color: AppColors.placeholder,
              ),
              onPressed: () {
                Clipboard.setData(
                  ClipboardData(text: widget.mobileController.text),
                );
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'admin.employeeWizard.mobileCopied'.tr(context: context),
                    ),
                    duration: const Duration(seconds: 2),
                  ),
                );
              },
            ),
            validator: AppValidators.required(
              message: 'admin.employeeWizard.requiredField'.tr(
                context: context,
              ),
              context: context,
            ),
          ),
        ),

        // Phone Number
        AdminWizardFieldWidget(
          label: 'admin.employeeWizard.phone'.tr(context: context),
          child: CustomTextFormField(
            hintText: 'admin.employeeWizard.phoneHint'.tr(context: context),
            controller: widget.phoneController,
            keyboardType: TextInputType.phone,
            prefixIcon: Icon(
              Icons.phone_outlined,
              size: 20.r,
              color: AppColors.placeholder,
            ),
            validator: AppValidators.phone(isRequired: false, context: context),
          ),
        ),

        // Email
        AdminWizardFieldWidget(
          label: 'admin.employeeWizard.email'.tr(context: context),
          child: CustomTextFormField(
            hintText: 'admin.employeeWizard.emailHint'.tr(context: context),
            controller: widget.emailController,
            keyboardType: TextInputType.emailAddress,
            prefixIcon: Icon(
              Icons.email_outlined,
              size: 20.r,
              color: AppColors.placeholder,
            ),
            validator: AppValidators.email(isRequired: false, context: context),
          ),
        ),

        // Employee Code (Generated & Editable)
        AdminWizardFieldWidget(
          label: 'admin.employeeWizard.employeeCode'.tr(context: context),
          child: CustomTextFormField(
            hintText:
                'admin.employeeWizard.employeeCodeHint'.tr(context: context),
            controller: widget.employeeCodeController,
            prefixIcon: Icon(
              Icons.badge_outlined,
              size: 20.r,
              color: AppColors.placeholder,
            ),
          ),
        ),
      ],
    );
  }
}
