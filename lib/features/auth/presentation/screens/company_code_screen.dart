import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/auth/presentation/cubit/tenant_lookup/tenant_lookup_cubit.dart';
import 'package:check_point_v2/features/auth/presentation/widgets/auth_card_widget.dart';
import 'package:check_point_v2/features/auth/presentation/widgets/auth_labeled_field_widget.dart';
import 'package:check_point_v2/features/auth/presentation/widgets/auth_shell_widget.dart';
import 'package:check_point_v2/features/auth/presentation/widgets/brand_header_widget.dart';
import 'package:check_point_v2/features/auth/presentation/widgets/tenant_lookup_bloc_listener_widget.dart';
import 'package:check_point_v2/features/auth/presentation/widgets/tenant_lookup_submit_button_widget.dart';

class CompanyCodeScreen extends StatefulWidget {
  const CompanyCodeScreen({super.key});

  @override
  State<CompanyCodeScreen> createState() => _CompanyCodeScreenState();
}

class _CompanyCodeScreenState extends State<CompanyCodeScreen> {
  final _codeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TenantLookupBlocListenerWidget(
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
                      titleKey: 'auth.companyCode.title',
                      subtitleKey: 'auth.companyCode.subtitle',
                    ),
                    hSpace(24),
                    AuthLabeledFieldWidget(
                      labelKey: 'auth.companyCode.codeLabel',
                      hintKey: 'auth.companyCode.codeHint',
                      controller: _codeController,
                      keyboardType: TextInputType.text,
                      validator: AppValidators.required(context: context),
                      prefixIcon: Icon(
                        Icons.apartment_rounded,
                        size: 20.r,
                        color: AppColors.placeholder,
                      ),
                    ),
                    hSpace(18),
                    TenantLookupSubmitButtonWidget(
                      onSubmit: () {
                        if (!(_formKey.currentState?.validate() ?? false)) {
                          return;
                        }
                        context.read<TenantLookupCubit>().verify(
                          _codeController.text,
                        );
                      },
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
