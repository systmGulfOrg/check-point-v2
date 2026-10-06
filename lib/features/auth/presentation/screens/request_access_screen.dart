import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/auth/presentation/widgets/request_account_bloc_listener_widget.dart';
import 'package:check_point_v2/features/auth/presentation/widgets/request_access_brand_widget.dart';
import 'package:check_point_v2/features/auth/presentation/widgets/request_access_form_widget.dart';
import 'package:check_point_v2/features/auth/presentation/widgets/request_access_success_widget.dart';

class RequestAccessScreen extends StatefulWidget {
  const RequestAccessScreen({super.key});

  @override
  State<RequestAccessScreen> createState() => _RequestAccessScreenState();
}

class _RequestAccessScreenState extends State<RequestAccessScreen> {
  bool requestSent = false;

  @override
  Widget build(BuildContext context) {
    return RequestAccountBlocListenerWidget(
      onSuccess: () => setState(() => requestSent = true),
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsetsDirectional.fromSTEB(20.w, 16.h, 20.w, 16.h),
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 460.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const RequestAccessBrandWidget(),
                    hSpace(18),
                    if (requestSent)
                      Card(
                        elevation: 0,
                        margin: EdgeInsets.zero,
                        color: AppColors.cardBackground,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(20.r),
                          child: RequestAccessSuccessWidget(
                            onBack: () => context.pushNamedAndRemoveUntil(
                              AppRoutes.login,
                            ),
                          ),
                        ),
                      )
                    else ...[
                      Card(
                        elevation: 0,
                        margin: EdgeInsets.zero,
                        color: AppColors.cardBackground,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(18.r),
                          child: const RequestAccessFormWidget(),
                        ),
                      ),
                    ],
                    hSpace(20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(AppAssets.logo, height: 19.h, width: 19.w),
                        vSpace(7),
                        Text(
                          'auth.requestAccess.footer'.tr(context: context),
                          style: AppTextStyles.font11Medium.copyWith(
                            color: AppColors.placeholder,
                            letterSpacing: 0.3,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
