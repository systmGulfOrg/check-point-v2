import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/core.dart';
import '../widgets/auth_card_widget.dart';
import '../widgets/auth_labeled_field_widget.dart';
import '../widgets/auth_shell_widget.dart';
import '../widgets/brand_header_widget.dart';
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

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _obscurePassword = true;
  bool _rememberMe = true;
  String _selectedRole = _roles.first;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AuthShellWidget(
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
              labelKey: 'auth.login.emailLabel',
              hintKey: 'auth.login.emailHint',
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
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
            hSpace(14),
            CheckboxListTile(
              value: _rememberMe,
              onChanged: (value) {
                setState(() => _rememberMe = value ?? false);
              },
              dense: true,
              contentPadding: EdgeInsets.zero,
              activeColor: AppColors.brandPrimary,
              controlAffinity: ListTileControlAffinity.leading,
              title: Text(
                'auth.login.rememberMe'.tr(context: context),
                style: AppTextStyles.font14Regular,
              ),
            ),
            hSpace(10),
            CustomButton(
              text: 'auth.login.submit'.tr(context: context),
              onTap: () {
                if (_selectedRole.contains('supervisor')) {
                  context.pushNamed(AppRoutes.supervisor);
                } else if (_selectedRole.contains('employee')) {
                  context.pushNamed(AppRoutes.employee);
                } else {
                  context.pushNamed(AppRoutes.admin);
                }
              },
            ),
            hSpace(18),
            TextButton(
              onPressed: () => context.pushNamed(AppRoutes.requestAccess),
              child: Text('auth.login.requestAccess'.tr(context: context)),
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
    ],
  ),
);
  }
}
