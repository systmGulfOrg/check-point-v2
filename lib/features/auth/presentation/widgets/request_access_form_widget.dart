import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/core/di/service_locator.dart';
import 'package:check_point_v2/features/auth/presentation/cubit/request_account/request_account_cubit.dart';
import 'request_access_device_id_widget.dart';
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
  late final TextEditingController siteNameController;
  late final TextEditingController notesController;

  String _accountType = 'Personal'; // 'Personal' or 'Site'
  String _deviceId = '';

  @override
  void initState() {
    super.initState();
    fullNameController = TextEditingController();
    nationalIdController = TextEditingController();
    phoneController = TextEditingController();
    siteNameController = TextEditingController();
    notesController = TextEditingController();
    _loadDeviceId();
  }

  Future<void> _loadDeviceId() async {
    final id = await sl<DeviceIdentityProvider>().getOrGenerateMobileId();
    if (!mounted) return;
    setState(() => _deviceId = id);
  }

  @override
  void dispose() {
    fullNameController.dispose();
    nationalIdController.dispose();
    phoneController.dispose();
    siteNameController.dispose();
    notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Form(
    key: formKey,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Account Type Selector
        Text(
          'auth.requestAccess.accountTypeLabel'.tr(context: context),
          textAlign: TextAlign.start,
          style: AppTextStyles.font14SemiBold,
        ),
        hSpace(8),
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () => setState(() => _accountType = 'Personal'),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  decoration: BoxDecoration(
                    color: _accountType == 'Personal'
                        ? AppColors.softBrandBackground
                        : AppColors.white,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: _accountType == 'Personal'
                          ? AppColors.brandPrimary
                          : AppColors.border,
                      width: _accountType == 'Personal' ? 1.5 : 1,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'auth.requestAccess.personalAccount'.tr(context: context),
                      style: AppTextStyles.font13Medium.copyWith(
                        color: _accountType == 'Personal'
                            ? AppColors.brandPrimaryDark
                            : AppColors.textSecondary,
                        fontWeight: _accountType == 'Personal'
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            wSpace(12),
            Expanded(
              child: GestureDetector(
                onTap: () => setState(() => _accountType = 'Site'),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  decoration: BoxDecoration(
                    color: _accountType == 'Site'
                        ? AppColors.softBrandBackground
                        : AppColors.white,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: _accountType == 'Site'
                          ? AppColors.brandPrimary
                          : AppColors.border,
                      width: _accountType == 'Site' ? 1.5 : 1,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'auth.requestAccess.siteAccount'.tr(context: context),
                      style: AppTextStyles.font13Medium.copyWith(
                        color: _accountType == 'Site'
                            ? AppColors.brandPrimaryDark
                            : AppColors.textSecondary,
                        fontWeight: _accountType == 'Site'
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
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

        // If Site Account: Site / Project Name
        if (_accountType == 'Site') ...[
          hSpace(16),
          Text(
            'auth.requestAccess.siteNameLabel'.tr(context: context),
            textAlign: TextAlign.start,
            style: AppTextStyles.font14SemiBold,
          ),
          hSpace(8),
          CustomTextFormField(
            hintText: 'auth.requestAccess.siteNameHint'.tr(context: context),
            controller: siteNameController,
            prefixIcon: Icon(
              Icons.location_city_outlined,
              size: 21.r,
              color: AppColors.placeholder,
            ),
            validator: (value) {
              if (_accountType == 'Site' && (value == null || value.trim().isEmpty)) {
                return 'auth.requestAccess.siteNameRequired'.tr(context: context);
              }
              return null;
            },
          ),
        ],

        // National ID (Optional)
        hSpace(16),
        Text(
          'auth.requestAccess.nationalIdLabel'.tr(context: context),
          textAlign: TextAlign.start,
          style: AppTextStyles.font14SemiBold,
        ),
        hSpace(8),
        CustomTextFormField(
          hintText: 'auth.requestAccess.nationalIdHint'.tr(context: context),
          controller: nationalIdController,
          keyboardType: TextInputType.number,
          prefixIcon: Icon(
            Icons.badge_outlined,
            size: 21.r,
            color: AppColors.placeholder,
          ),
        ),

        // Phone Number (Optional)
        hSpace(16),
        Text(
          'auth.requestAccess.phoneLabel'.tr(context: context),
          textAlign: TextAlign.start,
          style: AppTextStyles.font14SemiBold,
        ),
        hSpace(8),
        CustomTextFormField(
          hintText: 'auth.requestAccess.phoneHint'.tr(context: context),
          controller: phoneController,
          keyboardType: TextInputType.phone,
          prefixIcon: Icon(
            Icons.phone_outlined,
            size: 21.r,
            color: AppColors.placeholder,
          ),
        ),

        // Notes (Optional)
        hSpace(16),
        Text(
          'auth.requestAccess.notesLabel'.tr(context: context),
          textAlign: TextAlign.start,
          style: AppTextStyles.font14SemiBold,
        ),
        hSpace(8),
        CustomTextFormField(
          hintText: 'auth.requestAccess.notesHint'.tr(context: context),
          controller: notesController,
          prefixIcon: Icon(
            Icons.note_alt_outlined,
            size: 21.r,
            color: AppColors.placeholder,
          ),
        ),

        if (_deviceId.isNotEmpty) ...[
          hSpace(18),
          RequestAccessDeviceIdWidget(deviceId: _deviceId),
        ],

        hSpace(24),
        RequestAccountSubmitButtonWidget(
          onSubmit: () {
            FocusScope.of(context).unfocus();
            if (!(formKey.currentState?.validate() ?? false)) return;
            context.read<RequestAccountCubit>().submit(
              name: fullNameController.text.trim(),
              accountType: _accountType,
              siteId: _accountType == 'Site' ? siteNameController.text.trim() : null,
              nationalId: nationalIdController.text.trim().isNotEmpty
                  ? nationalIdController.text.trim()
                  : null,
              phone: phoneController.text.trim().isNotEmpty
                  ? phoneController.text.trim()
                  : null,
              notes: notesController.text.trim().isNotEmpty
                  ? notesController.text.trim()
                  : null,
            );
          },
        ),
      ],
    ),
  );
}
