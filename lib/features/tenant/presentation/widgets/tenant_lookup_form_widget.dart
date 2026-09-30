import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/tenant/presentation/cubit/tenant_lookup_cubit.dart';
import 'tenant_lookup_submit_button_widget.dart';

class TenantLookupFormWidget extends StatefulWidget {
  const TenantLookupFormWidget({super.key});

  @override
  State<TenantLookupFormWidget> createState() => _TenantLookupFormWidgetState();
}

class _TenantLookupFormWidgetState extends State<TenantLookupFormWidget> {
  final _companyCodeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _companyCodeController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    context.read<TenantLookupCubit>().lookupTenant(
          _companyCodeController.text.trim(),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CustomTextFormField(
            controller: _companyCodeController,
            hintText: 'tenant.lookup.codeHint'.tr(context: context),
            keyboardType: TextInputType.text,
            prefixIcon: Icon(
              Icons.domain_rounded,
              size: 20.r,
              color: AppColors.placeholder,
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'tenant.lookup.required'.tr(context: context);
              }
              return null;
            },
          ),
          hSpace(20),
          TenantLookupSubmitButtonWidget(onSubmit: _submit),
          hSpace(16),
          Container(
            padding: EdgeInsets.all(12.r),
            decoration: BoxDecoration(
              color: AppColors.infoBackground,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: AppColors.brandPrimary.withAlpha(50),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.info_outline_rounded,
                  size: 20.r,
                  color: AppColors.brandPrimary,
                ),
                wSpace(10),
                Expanded(
                  child: Text(
                    'tenant.lookup.helper'.tr(context: context),
                    style: AppTextStyles.font12Regular.copyWith(
                      color: AppColors.brandInk,
                      height: 1.45,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
