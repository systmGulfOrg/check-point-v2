import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/auth/presentation/cubit/trial_signup/trial_signup_cubit.dart';
import 'package:check_point_v2/features/auth/presentation/widgets/auth_card_widget.dart';
import 'package:check_point_v2/features/auth/presentation/widgets/auth_labeled_field_widget.dart';
import 'package:check_point_v2/features/auth/presentation/widgets/auth_shell_widget.dart';
import 'package:check_point_v2/features/auth/presentation/widgets/brand_header_widget.dart';
import 'package:check_point_v2/features/auth/presentation/widgets/trial_signup_bloc_listener_widget.dart';
import 'package:check_point_v2/features/auth/presentation/widgets/trial_signup_country_dropdown_widget.dart';
import 'package:check_point_v2/features/auth/presentation/widgets/trial_signup_submit_button_widget.dart';

class TrialSignupScreen extends StatefulWidget {
  const TrialSignupScreen({super.key});

  @override
  State<TrialSignupScreen> createState() => _TrialSignupScreenState();
}

class _TrialSignupScreenState extends State<TrialSignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _companyNameController = TextEditingController();
  final _slugController = TextEditingController();
  final _contactEmailController = TextEditingController();
  final _contactPhoneController = TextEditingController();
  final _adminNameController = TextEditingController();
  final _adminUserNameController = TextEditingController();
  final _passwordController = TextEditingController();

  String? _country;
  bool _obscurePassword = true;
  bool _acceptTerms = false;

  @override
  void dispose() {
    _companyNameController.dispose();
    _slugController.dispose();
    _contactEmailController.dispose();
    _contactPhoneController.dispose();
    _adminNameController.dispose();
    _adminUserNameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    if (!_acceptTerms) {
      CustomSnackBar.showError(
        context,
        message: 'auth.trialSignup.mustAcceptTerms'.tr(context: context),
      );
      return;
    }
    context.read<TrialSignupCubit>().submit(
      companyName: _companyNameController.text,
      slug: _slugController.text,
      contactEmail: _contactEmailController.text,
      adminName: _adminNameController.text,
      adminUserName: _adminUserNameController.text,
      password: _passwordController.text,
      contactPhone: _contactPhoneController.text,
      country: _country,
    );
  }

  @override
  Widget build(BuildContext context) {
    return TrialSignupBlocListenerWidget(
      child: AuthShellWidget(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Align(
              alignment: AlignmentDirectional.centerEnd,
              child: LanguageSwitcherWidget(),
            ),
            hSpace(12),
            AuthCardWidget(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const BrandHeaderWidget(
                      titleKey: 'auth.trialSignup.title',
                      subtitleKey: 'auth.trialSignup.subtitle',
                    ),
                    hSpace(16),
                    Center(
                      child: Container(
                        padding: EdgeInsetsDirectional.symmetric(
                          horizontal: 14.w,
                          vertical: 6.h,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.softBrandBackground,
                          borderRadius: BorderRadius.circular(999.r),
                        ),
                        child: Text(
                          'auth.trialSignup.trialBadge'.tr(context: context),
                          style: AppTextStyles.font12Medium.copyWith(
                            color: AppColors.brandPrimary,
                          ),
                        ),
                      ),
                    ),
                    hSpace(24),
                    AuthLabeledFieldWidget(
                      labelKey: 'auth.trialSignup.companyNameLabel',
                      hintKey: 'auth.trialSignup.companyNameHint',
                      controller: _companyNameController,
                      validator: AppValidators.name(context: context),
                      prefixIcon: Icon(
                        Icons.apartment_rounded,
                        size: 20.r,
                        color: AppColors.placeholder,
                      ),
                    ),
                    hSpace(16),
                    AuthLabeledFieldWidget(
                      labelKey: 'auth.trialSignup.slugLabel',
                      hintKey: 'auth.trialSignup.slugHint',
                      controller: _slugController,
                      validator: AppValidators.required(context: context),
                      prefixIcon: Icon(
                        Icons.link_rounded,
                        size: 20.r,
                        color: AppColors.placeholder,
                      ),
                    ),
                    hSpace(16),
                    TrialSignupCountryDropdownWidget(
                      value: _country,
                      onChanged: (value) => setState(() => _country = value),
                    ),
                    hSpace(16),
                    AuthLabeledFieldWidget(
                      labelKey: 'auth.trialSignup.contactPhoneLabel',
                      hintKey: 'auth.trialSignup.contactPhoneHint',
                      controller: _contactPhoneController,
                      keyboardType: TextInputType.phone,
                      validator: AppValidators.phone(
                        context: context,
                        isRequired: false,
                      ),
                      prefixIcon: Icon(
                        Icons.phone_outlined,
                        size: 20.r,
                        color: AppColors.placeholder,
                      ),
                    ),
                    hSpace(16),
                    AuthLabeledFieldWidget(
                      labelKey: 'auth.trialSignup.contactEmailLabel',
                      hintKey: 'auth.trialSignup.contactEmailHint',
                      controller: _contactEmailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: AppValidators.email(context: context),
                      prefixIcon: Icon(
                        Icons.mail_outline_rounded,
                        size: 20.r,
                        color: AppColors.placeholder,
                      ),
                    ),
                    hSpace(16),
                    AuthLabeledFieldWidget(
                      labelKey: 'auth.trialSignup.adminNameLabel',
                      hintKey: 'auth.trialSignup.adminNameHint',
                      controller: _adminNameController,
                      validator: AppValidators.name(context: context),
                      prefixIcon: Icon(
                        Icons.person_outline_rounded,
                        size: 20.r,
                        color: AppColors.placeholder,
                      ),
                    ),
                    hSpace(16),
                    AuthLabeledFieldWidget(
                      labelKey: 'auth.trialSignup.adminUserNameLabel',
                      hintKey: 'auth.trialSignup.adminUserNameHint',
                      helperKey: 'auth.trialSignup.adminUserNameHelper',
                      controller: _adminUserNameController,
                      validator: AppValidators.required(context: context),
                      prefixIcon: Icon(
                        Icons.badge_outlined,
                        size: 20.r,
                        color: AppColors.placeholder,
                      ),
                    ),
                    hSpace(16),
                    AuthLabeledFieldWidget(
                      labelKey: 'auth.trialSignup.passwordLabel',
                      hintKey: 'auth.trialSignup.passwordHint',
                      controller: _passwordController,
                      obscureText: _obscurePassword,
                      validator: AppValidators.password(
                        minLength: 12,
                        context: context,
                      ),
                      prefixIcon: Icon(
                        Icons.lock_outline_rounded,
                        size: 20.r,
                        color: AppColors.placeholder,
                      ),
                      suffixIcon: IconButton(
                        onPressed: () => setState(
                          () => _obscurePassword = !_obscurePassword,
                        ),
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          size: 20.r,
                          color: AppColors.placeholder,
                        ),
                      ),
                    ),
                    hSpace(14),
                    CheckboxListTile(
                      value: _acceptTerms,
                      onChanged: (value) =>
                          setState(() => _acceptTerms = value ?? false),
                      dense: true,
                      contentPadding: EdgeInsets.zero,
                      activeColor: AppColors.brandPrimary,
                      controlAffinity: ListTileControlAffinity.leading,
                      title: Text(
                        'auth.trialSignup.acceptTerms'.tr(context: context),
                        style: AppTextStyles.font13Regular,
                      ),
                    ),
                    hSpace(10),
                    TrialSignupSubmitButtonWidget(onSubmit: _submit),
                    hSpace(12),
                    Center(
                      child: TextButton(
                        onPressed: () =>
                            context.pushNamedAndRemoveUntil(AppRoutes.login),
                        child: Text(
                          'auth.trialSignup.backToCompanyCode'.tr(
                            context: context,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
