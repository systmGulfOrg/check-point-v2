import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/core.dart';

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
              Color(0xFFFFF7F0),
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
