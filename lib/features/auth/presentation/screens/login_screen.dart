import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/core.dart';
import '../cubit/login_cubit.dart';
import '../widgets/auth_card_widget.dart';
import '../widgets/auth_labeled_field_widget.dart';
import '../widgets/auth_shell_widget.dart';
import '../widgets/biometric_login_button_widget.dart';
import '../widgets/brand_header_widget.dart';
import '../widgets/login_bloc_listener_widget.dart';
import '../widgets/login_submit_button_widget.dart';
import '../widgets/role_switcher_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  static const _roles = <String>[
    'auth.role.admin',
    'auth.role.supervisor',
    'auth.role.employee',
  ];

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  bool _obscurePassword = true;
  bool _enableBiometricLogin = false;
  bool _biometricLoginAttempted = false;
  bool _hasSavedBiometric = false;
  bool _isBiometricSupported = false;
  String _selectedRole = _roles.first;

  @override
  void initState() {
    super.initState();
    _checkBiometricSupport();
  }

  Future<void> _checkBiometricSupport() async {
    final cubit = context.read<LoginCubit>();
    final session = await cubit.authSessionStorage.readBiometricSession();
    final isAvailable = await cubit.biometricAuthService.isAvailable();
    if (!mounted) return;

    setState(() {
      _isBiometricSupported = isAvailable;
      _hasSavedBiometric = session != null && isAvailable;
      if (session != null) {
        _enableBiometricLogin = true;
        if (session.username != null && session.username!.isNotEmpty) {
          _usernameController.text = session.username!;
        }
        final match = _roles.firstWhere(
          (r) => r.toLowerCase().endsWith(session.role.toLowerCase()),
          orElse: () => _selectedRole,
        );
        _selectedRole = match;
      }
    });

    if (session != null && isAvailable && !_biometricLoginAttempted) {
      _biometricLoginAttempted = true;
      unawaited(
        cubit.loginWithBiometrics(
          localizedReason: 'auth.login.biometricReason'.tr(context: context),
        ),
      );
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LoginBlocListenerWidget(
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
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const BrandHeaderWidget(
                      titleKey: 'auth.login.title',
                      subtitleKey: 'auth.login.subtitle',
                    ),
                    hSpace(24),
                    RoleSwitcherWidget(
                      roles: _roles,
                      selectedRole: _selectedRole,
                      onRoleSelected: (role) {
                        setState(() => _selectedRole = role);
                      },
                    ),
                    hSpace(18),
                    AuthLabeledFieldWidget(
                      labelKey: 'auth.login.usernameLabel',
                      hintKey: 'auth.login.usernameHint',
                      controller: _usernameController,
                      keyboardType: TextInputType.text,
                      validator: (value) =>
                          value == null || value.trim().isEmpty
                          ? 'auth.login.required'.tr(context: context)
                          : null,
                      prefixIcon: Icon(
                        Icons.mail_outline_rounded,
                        size: 20.r,
                        color: AppColors.placeholder,
                      ),
                    ),
                    hSpace(18),
                    AuthLabeledFieldWidget(
                      labelKey: 'auth.login.passwordLabel',
                      hintKey: 'auth.login.passwordHint',
                      controller: _passwordController,
                      obscureText: _obscurePassword,
                      validator: (value) => value == null || value.isEmpty
                          ? 'auth.login.required'.tr(context: context)
                          : null,
                      prefixIcon: Icon(
                        Icons.lock_outline_rounded,
                        size: 20.r,
                        color: AppColors.placeholder,
                      ),
                      // Keep the password field ergonomic without introducing extra state.
                      // The visibility toggle stays local to this screen.
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() => _obscurePassword = !_obscurePassword);
                        },
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          size: 20.r,
                          color: AppColors.placeholder,
                        ),
                      ),
                    ),
                    if (_isBiometricSupported) ...[
                      hSpace(14),
                      CheckboxListTile(
                        value: _enableBiometricLogin,
                        onChanged: (value) {
                          setState(
                            () => _enableBiometricLogin = value ?? false,
                          );
                        },
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        activeColor: AppColors.brandPrimary,
                        controlAffinity: ListTileControlAffinity.leading,
                        title: Row(
                          children: [
                            Icon(
                              Icons.fingerprint_rounded,
                              size: 21.r,
                              color: AppColors.brandPrimary,
                            ),
                            wSpace(8),
                            Text(
                              'auth.login.biometricLogin'.tr(context: context),
                              style: AppTextStyles.font14Regular,
                            ),
                          ],
                        ),
                      ),
                    ],
                    hSpace(10),
                    LoginSubmitButtonWidget(
                      onSubmit: () {
                        if (!(formKey.currentState?.validate() ?? false)) {
                          return;
                        }
                        context.read<LoginCubit>().login(
                          userName: _usernameController.text.trim(),
                          password: _passwordController.text,
                          role: switch (_selectedRole) {
                            'auth.role.admin' => 'Admin',
                            'auth.role.supervisor' => 'Supervisor',
                            _ => 'Employee',
                          },
                          enableBiometricLogin: _enableBiometricLogin,
                        );
                      },
                    ),
                    if (_hasSavedBiometric) ...[
                      hSpace(12),
                      BiometricLoginButtonWidget(
                        onPressed: () {
                          context.read<LoginCubit>().loginWithBiometrics(
                            localizedReason:
                                'auth.login.biometricReason'.tr(
                                  context: context,
                                ),
                          );
                        },
                      ),
                    ],
                    hSpace(18),
                    TextButton(
                      onPressed: () =>
                          context.pushNamed(AppRoutes.requestAccess),
                      child: Text(
                        'auth.login.requestAccess'.tr(context: context),
                      ),
                    ),
                    hSpace(8),
                    Text(
                      'auth.login.requestNote'.tr(context: context),
                      textAlign: TextAlign.center,
                      style: AppTextStyles.font13Regular.copyWith(height: 1.45),
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
