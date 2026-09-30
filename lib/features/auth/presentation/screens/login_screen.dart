import 'package:check_point_v2/features/auth/presentation/cubit/login/login_state.dart';
import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/auth/presentation/cubit/login/login_cubit.dart';
import 'package:check_point_v2/features/auth/presentation/widgets/auth_card_widget.dart';
import 'package:check_point_v2/features/auth/presentation/widgets/auth_labeled_field_widget.dart';
import 'package:check_point_v2/features/auth/presentation/widgets/auth_shell_widget.dart';
import 'package:check_point_v2/features/auth/presentation/widgets/biometric_login_button_widget.dart';
import 'package:check_point_v2/features/auth/presentation/widgets/brand_header_widget.dart';
import 'package:check_point_v2/features/auth/presentation/widgets/login_bloc_listener_widget.dart';
import 'package:check_point_v2/features/auth/presentation/widgets/login_submit_button_widget.dart';
import 'package:check_point_v2/features/auth/presentation/widgets/login_account_request_status_bloc_builder_widget.dart';
import 'package:check_point_v2/core/di/service_locator.dart';
import 'package:check_point_v2/core/tenant/tenant_storage.dart';
import 'package:check_point_v2/features/tenant/data/models/tenant_model.dart';
import 'package:check_point_v2/features/auth/presentation/widgets/role_switcher_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TenantModel? _currentTenant;

  List<String> get _roles {
    final tenant = _currentTenant;
    if (tenant?.roles != null && tenant!.roles!.isNotEmpty) {
      final mapped = tenant.roles!.map((r) => switch (r.toLowerCase()) {
        'admin' || 'hr' => 'auth.role.hr',
        'supervisor' || 'site supervisor' => 'auth.role.supervisor',
        'contractor' => 'auth.role.contractor',
        'employee' || 'worker' => 'auth.role.employee',
        _ => 'auth.role.hr',
      }).toSet().toList();
      if (mapped.isNotEmpty) return mapped;
    }
    final isContractorOrg = tenant?.orgModel == 'contractor_worker' ||
        (tenant?.tenantCode?.toLowerCase().contains('samco') ?? true);
    if (isContractorOrg) {
      return const [
        'auth.role.hr',
        'auth.role.supervisor',
        'auth.role.contractor',
      ];
    }
    return const [
      'auth.role.hr',
      'auth.role.supervisor',
      'auth.role.employee',
    ];
  }

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  bool _obscurePassword = true;
  bool _enableBiometricLogin = false;
  int _rateLimitSeconds = 0;
  Timer? _rateLimitTimer;

  bool _biometricLoginAttempted = false;
  bool _hasSavedBiometric = false;
  bool _isBiometricSupported = false;
  late String _selectedRole;

  @override
  void initState() {
    super.initState();
    _selectedRole = _roles.first;
    _loadTenant();
    _checkBiometricSupport();
  }

  Future<void> _loadTenant() async {
    final tenant = await sl<TenantStorage>().readTenant();
    if (!mounted) return;
    setState(() {
      _currentTenant = tenant;
      if (!_roles.contains(_selectedRole)) {
        _selectedRole = _roles.first;
      }
    });
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
    _rateLimitTimer?.cancel();
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        state.maybeWhen(
          error: (msg) {
            if (msg.toLowerCase().contains('rate limit') ||
                msg.toLowerCase().contains('retry in')) {
              int seconds = 60;
              final match = RegExp(
                r'retry in (\d+)',
              ).firstMatch(msg.toLowerCase());
              if (match != null) {
                final val = int.tryParse(match.group(1) ?? '');
                if (val != null) {
                  if (msg.toLowerCase().contains('minute')) {
                    seconds = val * 60;
                  } else {
                    seconds = val;
                  }
                }
              }
              setState(() {
                _rateLimitSeconds = seconds > 60 ? 60 : seconds;
              });
              _rateLimitTimer?.cancel();
              _rateLimitTimer = Timer.periodic(const Duration(seconds: 1), (
                timer,
              ) {
                if (_rateLimitSeconds > 0) {
                  setState(() {
                    _rateLimitSeconds--;
                  });
                } else {
                  timer.cancel();
                }
              });
            }
          },
          orElse: () {},
        );
      },
      child: LoginBlocListenerWidget(
        onDeviceTransferRequired: () {
          showDialog(
            context: context,
            builder: (dialogContext) => CustomDialogWidget(
              title: 'auth.login.deviceTransferTitle'.tr(context: context),
              message: 'auth.login.deviceTransferMessage'.tr(context: context),
              icon: Icons.phone_android_rounded,
              onConfirm: () {
                Navigator.pop(dialogContext);
                context.read<LoginCubit>().requestDeviceTransfer(
                  userName: _usernameController.text.trim(),
                  password: _passwordController.text,
                );
              },
            ),
          );
        },
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
                      hSpace(20),
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
                            setState(
                              () => _obscurePassword = !_obscurePassword,
                            );
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
                              Expanded(
                                child: Text(
                                  'auth.login.biometricLogin'.tr(
                                    context: context,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppTextStyles.font14Regular,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                      hSpace(10),
                      LoginSubmitButtonWidget(
                        rateLimitSeconds: _rateLimitSeconds,
                        onSubmit: () {
                          if (_rateLimitSeconds > 0) return;
                          if (!(formKey.currentState?.validate() ?? false)) {
                            return;
                          }
                          context.read<LoginCubit>().login(
                            userName: _usernameController.text.trim(),
                            password: _passwordController.text,
                            role: switch (_selectedRole) {
                              'auth.role.hr' => 'HR',
                              'auth.role.admin' => 'Admin',
                              'auth.role.supervisor' => 'Supervisor',
                              'auth.role.contractor' => 'Contractor',
                              'auth.role.employee' => 'Employee',
                              _ => 'HR',
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
                              localizedReason: 'auth.login.biometricReason'.tr(
                                context: context,
                              ),
                            );
                          },
                        ),
                      ],
                      hSpace(18),
                      const LoginAccountRequestStatusBlocBuilderWidget(),
                      hSpace(12),
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
                        style: AppTextStyles.font13Regular.copyWith(
                          height: 1.45,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
