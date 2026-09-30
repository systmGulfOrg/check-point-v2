import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';

class AuthShellWidget extends StatelessWidget {
  const AuthShellWidget({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.authShellGradientStart,
              AppColors.pageBackground,
              AppColors.white,
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: EdgeInsetsDirectional.symmetric(
                horizontal: 16.w,
                vertical: 20.h,
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 460.w),
                child: child,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
