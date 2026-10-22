import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/auth/presentation/cubit/tenant_lookup/tenant_lookup_cubit.dart';
import 'package:check_point_v2/features/auth/presentation/cubit/tenant_lookup/tenant_lookup_state.dart';
import 'package:check_point_v2/features/auth/presentation/widgets/auth_card_widget.dart';
import 'package:check_point_v2/features/auth/presentation/widgets/auth_shell_widget.dart';
import 'package:check_point_v2/features/auth/presentation/widgets/brand_header_widget.dart';
import 'package:check_point_v2/features/auth/presentation/widgets/start_trial_banner_widget.dart';
import 'package:check_point_v2/features/auth/presentation/widgets/tenant_lookup_bloc_listener_widget.dart';
import 'package:check_point_v2/main.dart' show pendingStartupMessageKey;

class CompanyCodeScreen extends StatefulWidget {
  const CompanyCodeScreen({super.key});

  @override
  State<CompanyCodeScreen> createState() => _CompanyCodeScreenState();
}

class _CompanyCodeScreenState extends State<CompanyCodeScreen>
    with SingleTickerProviderStateMixin {
  final _codeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  late final AnimationController _animController;
  late final Animation<double> _fadeAnim;
  late final Animation<Offset> _slideAnim;

  @override
  void initState() {
    super.initState();

    // Card entrance animation
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _fadeAnim = CurvedAnimation(parent: _animController, curve: Curves.easeOut);
    _slideAnim = Tween<Offset>(
      begin: const Offset(0, 0.12),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _animController, curve: Curves.easeOut));

    _animController.forward();

    // Show pending startup message if any
    final messageKey = pendingStartupMessageKey;
    if (messageKey != null) {
      pendingStartupMessageKey = null;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        CustomSnackBar.showError(
          context,
          message: messageKey.tr(context: context),
          duration: const Duration(seconds: 5),
        );
      });
    }
  }

  @override
  void dispose() {
    _codeController.dispose();
    _animController.dispose();
    super.dispose();
  }

  void _showWhereIsMyCode() {
    showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.white,
        surfaceTintColor: AppColors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        title: Text(
          'auth.companyCode.whereIsMyCodeTitle'.tr(context: context),
          style: AppTextStyles.font16Bold,
        ),
        content: Text(
          'auth.companyCode.whereIsMyCodeBody'.tr(context: context),
          style: AppTextStyles.font14Regular.copyWith(height: 1.6),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(
              'core.actions.ok'.tr(context: context),
              style: AppTextStyles.font14SemiBold.copyWith(
                color: AppColors.brandPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _launchPrivacy() async {
    final uri = Uri.parse('https://systmgulf.com/privacy-policy');
    if (await canLaunchUrl(uri)) await launchUrl(uri);
  }

  Future<void> _launchTerms() async {
    final uri = Uri.parse('https://systmgulf.com/terms-of-service');
    if (await canLaunchUrl(uri)) await launchUrl(uri);
  }

  Future<void> _launchSupport() async {
    final uri = Uri(scheme: 'mailto', path: 'support@systmgulf.com');
    if (await canLaunchUrl(uri)) await launchUrl(uri);
  }

  @override
  Widget build(BuildContext context) {
    return TenantLookupBlocListenerWidget(
      child: AuthShellWidget(
        child: FadeTransition(
          opacity: _fadeAnim,
          child: SlideTransition(
            position: _slideAnim,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                // ── Top bar: language switcher ──
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [const LanguageSwitcherWidget()],
                ),
                hSpace(12),

                // ── Trial banner ──
                StartTrialBannerWidget(
                  onTap: () => context.pushNamed(AppRoutes.trialSignup),
                ),
                hSpace(16),

                // ── Main card ──
                AuthCardWidget(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Brand header (logo + title + subtitle)
                        const BrandHeaderWidget(
                          titleKey: 'auth.companyCode.title',
                          subtitleKey: 'auth.companyCode.subtitle',
                        ),
                        hSpace(24),

                        // Field label row: "كود الشركة *" + "أين الكود مني؟"
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'auth.companyCode.codeLabel'.tr(
                                      context: context,
                                    ),
                                    style: AppTextStyles.font13SemiBold
                                        .copyWith(color: AppColors.textPrimary),
                                  ),
                                  TextSpan(
                                    text: ' *',
                                    style: AppTextStyles.font13SemiBold
                                        .copyWith(color: AppColors.error),
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: _showWhereIsMyCode,
                              child: Text(
                                'auth.companyCode.whereIsMyCode'.tr(
                                  context: context,
                                ),
                                style: AppTextStyles.font12Regular.copyWith(
                                  color: AppColors.brandPrimary,
                                  decoration: TextDecoration.underline,
                                  decorationColor: AppColors.brandPrimary,
                                ),
                              ),
                            ),
                          ],
                        ),
                        hSpace(8),

                        // Code input field
                        CustomTextFormField(
                          controller: _codeController,
                          hintText: 'auth.companyCode.codeHint'.tr(
                            context: context,
                          ),
                          keyboardType: TextInputType.text,
                          validator: AppValidators.required(context: context),
                          prefixIcon: Icon(
                            Icons.apartment_rounded,
                            size: 20.r,
                            color: AppColors.placeholder,
                          ),
                        ),
                        hSpace(18),

                        // Continue button with arrow icon
                        BlocBuilder<TenantLookupCubit, TenantLookupState>(
                          builder: (ctx, state) => CustomButton(
                            text: 'auth.companyCode.continueButton'.tr(
                              context: context,
                            ),
                            onTap: () {
                              if (!(_formKey.currentState?.validate() ??
                                  false)) {
                                return;
                              }
                              context.read<TenantLookupCubit>().verify(
                                _codeController.text,
                              );
                            },
                            isLoading: state is TenantLookupLoading,
                            icon: Icons.arrow_back_ios_new_rounded,
                          ),
                        ),
                        hSpace(20),

                        // ── "أو" divider ──
                        Row(
                          children: [
                            Expanded(
                              child: Divider(
                                color: AppColors.border,
                                thickness: 1,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.symmetric(
                                horizontal: 12.w,
                              ),
                              child: Text(
                                'auth.companyCode.orDivider'.tr(
                                  context: context,
                                ),
                                style: AppTextStyles.font13Regular.copyWith(
                                  color: AppColors.placeholder,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Divider(
                                color: AppColors.border,
                                thickness: 1,
                              ),
                            ),
                          ],
                        ),
                        hSpace(12),

                        // Register new company CTA
                        TextButton.icon(
                          onPressed: () =>
                              context.pushNamed(AppRoutes.trialSignup),
                          icon: Icon(
                            Icons.add_circle_outline_rounded,
                            size: 16.r,
                            color: AppColors.brandPrimary,
                          ),
                          label: Text(
                            'auth.companyCode.registerNewCompany'.tr(
                              context: context,
                            ),
                            style: AppTextStyles.font13SemiBold.copyWith(
                              color: AppColors.brandPrimary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                hSpace(20),

                // ── Footer links ──
                _FooterLinksWidget(
                  onPrivacy: _launchPrivacy,
                  onTerms: _launchTerms,
                  onSupport: _launchSupport,
                ),
                hSpace(8),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Footer links widget
// ─────────────────────────────────────────────────────────────────────────────

class _FooterLinksWidget extends StatelessWidget {
  const _FooterLinksWidget({
    required this.onPrivacy,
    required this.onTerms,
    required this.onSupport,
  });

  final VoidCallback onPrivacy;
  final VoidCallback onTerms;
  final VoidCallback onSupport;

  @override
  Widget build(BuildContext context) {
    final linkStyle = AppTextStyles.font11Regular.copyWith(
      color: AppColors.placeholder,
    );
    final dot = Text(' • ', style: linkStyle);

    return Column(
      children: [
        Wrap(
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            GestureDetector(
              onTap: onPrivacy,
              child: Text(
                'auth.companyCode.privacyPolicy'.tr(context: context),
                style: linkStyle.copyWith(decoration: TextDecoration.underline),
              ),
            ),
            dot,
            GestureDetector(
              onTap: onTerms,
              child: Text(
                'auth.companyCode.termsOfService'.tr(context: context),
                style: linkStyle.copyWith(decoration: TextDecoration.underline),
              ),
            ),
            dot,
            GestureDetector(
              onTap: onSupport,
              child: Text(
                'auth.companyCode.supportLink'.tr(context: context),
                style: linkStyle.copyWith(decoration: TextDecoration.underline),
              ),
            ),
          ],
        ),
        hSpace(6),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.lock_outline_rounded,
              size: 11.r,
              color: AppColors.placeholder,
            ),
            wSpace(4),
            Text(
              'auth.companyCode.sslSecure'.tr(context: context),
              style: AppTextStyles.font11Regular.copyWith(
                color: AppColors.placeholder,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
