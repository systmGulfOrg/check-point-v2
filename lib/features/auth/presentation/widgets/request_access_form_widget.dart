import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/core.dart';

class RequestAccessFormWidget extends StatefulWidget {
  const RequestAccessFormWidget({required this.onSubmitted, super.key});

  final VoidCallback onSubmitted;

  @override
  State<RequestAccessFormWidget> createState() =>
      _RequestAccessFormWidgetState();
}

class _RequestAccessFormWidgetState extends State<RequestAccessFormWidget> {
  final formKey = GlobalKey<FormState>();
  late final TextEditingController fullNameController;
  bool isLoading = false;
  String? errorMessage;

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

  @override
  Widget build(BuildContext context) => Form(
    key: formKey,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'auth.requestAccess.cardTitle'.tr(context: context),
          style: AppTextStyles.font18Bold.copyWith(color: AppColors.brandInk),
        ),
        hSpace(6),
        Text(
          'auth.requestAccess.cardDescription'.tr(context: context),
          style: AppTextStyles.font13Regular.copyWith(height: 1.5),
        ),
        hSpace(22),
        Text(
          'auth.requestAccess.fullName'.tr(context: context),
          textAlign: TextAlign.right,
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
        if (errorMessage != null) ...[
          hSpace(12),
          Container(
            padding: EdgeInsets.all(12.r),
            decoration: BoxDecoration(
              color: AppColors.softRedBackground,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Text(
              errorMessage!.tr(context: context),
              textAlign: TextAlign.right,
              style: AppTextStyles.font13Regular.copyWith(
                color: AppColors.error,
              ),
            ),
          ),
        ],
        hSpace(22),
        CustomButton(
          text: 'auth.requestAccess.submit'.tr(context: context),
          onTap: () async {
            FocusScope.of(context).unfocus();
            setState(() => errorMessage = null);
            if (!(formKey.currentState?.validate() ?? false)) return;
            setState(() => isLoading = true);
            try {
              await Future<void>.delayed(const Duration(milliseconds: 850));
            } catch (_) {
              if (mounted) {
                setState(() {
                  isLoading = false;
                  errorMessage = 'auth.requestAccess.failed';
                });
              }
              return;
            }
            if (!mounted) return;
            setState(() => isLoading = false);
            widget.onSubmitted();
          },
          isLoading: isLoading,
          gradient: AppColors.brandGradient,
          height: 54,
        ),
      ],
    ),
  );
}
